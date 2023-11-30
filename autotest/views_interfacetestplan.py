# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.3
############################################
import json,traceback,re,copy,os,requests,random,time,string
from django.shortcuts import render_to_response
from django.db import connection
from django.db.models import Q
from django.db.models import Max
from django.core.cache import cache
from django.template.context_processors import csrf
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from .models import *
from datetime import datetime
from django.http import HttpResponse
from .views_interface import cache,print_log,interface_test_start, assert_test_old
from django.contrib.auth.decorators import login_required
from djcelery.models import PeriodicTask, CrontabSchedule, IntervalSchedule
from Autotestplat.celery import app

current_dir = os.getcwd()
logfile = os.path.join(current_dir, 'autotest', 'test_out.log')
codefile= os.path.join(current_dir, 'autotest', 'code.jpg')
session = requests.Session()

@login_required
def interface_testplan(req):
    username = req.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        suits = AutotestplatTestplan.objects.all().order_by('-id')
        product_all = AutotestplatProduct.objects.all()
        env_para = AutotestplatParameter.objects.filter(type="env")
        interval = IntervalSchedule.objects.all().order_by('-id')
        interfaces = AutotestplatInterfaceTestcase.objects.all().order_by('-product_id', 'id')
        interfaces_all = []
        for interface in interfaces:
            product = AutotestplatProduct.objects.filter(id=interface.product_id)
            if product:
                new_interface = interface
                new_interface.product_id = product.first().product_name
                interfaces_all.append(new_interface)
    else:
        user_product_id = AuthUser.objects.filter(username=username).first().last_name
        try:
            suits = AutotestplatTestplan.objects.filter(product_id=user_product_id).order_by('-id').all()
        except:
            suits = AutotestplatTestplan.objects.all().order_by('-id')
        product_id = AuthUser.objects.filter(username=username).first().last_name
        product_all = AutotestplatProduct.objects.filter(id=product_id).all()
        env_para = AutotestplatParameter.objects.filter(type="env").filter(product_id=product_id)
        interval = IntervalSchedule.objects.all().order_by('-id')
        interfaces = AutotestplatInterfaceTestcase.objects.filter(product_id=product_id).order_by('-product_id','id')
        interfaces_all =[]
        for interface in interfaces:
            product = AutotestplatProduct.objects.filter(id=product_id).first()
            if product:
                new_interface = interface
                new_interface.product_id = product.product_name
                interfaces_all.append(new_interface)
    new_suits = []
    for id in suits:
        product = AutotestplatProduct.objects.filter(id=id.product_id).first()
        task = PeriodicTask.objects.filter(id=id.task_id).first()
        new_id = id
        new_id.product_id = product.product_name
        if task is not None:
            crontab_id = task.crontab_id
        else:
            crontab_id = None
        if task is not None:
            interval_id = task.interval_id
        else:
            interval_id = None
        if crontab_id!=None and crontab_id!='':
            runtime_year = datetime.now().year
            runtime_month = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][5]
            runtime_day = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][4]
            runtime_hour = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][2]
            runtime_min = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][1]
            runtime = str(runtime_year) + '-' + runtime_month + '-' + runtime_day + ' ' + runtime_hour + ':' + runtime_min
            new_id.task_id = runtime
        elif interval_id!=None and interval_id!='':
            runtime_every = IntervalSchedule.objects.filter(id=interval_id).values_list()[0][1]
            runtime_peroid = IntervalSchedule.objects.filter(id=interval_id).values_list()[0][2]
            if runtime_peroid == 'minutes':
                runtime = '每分钟'+str(runtime_every)+'次'
            elif runtime_peroid == 'hours':
                runtime = '每小时' + str(runtime_every) + '次'
            elif runtime_peroid == 'days':
                runtime = '每天' + str(runtime_every) + '次'
            new_id.task_id = runtime
        else:
            new_id.task_id = ""
        new_suits.append(new_id)

    paginator = Paginator(new_suits, 10)
    num = len(suits)
    page = req.GET.get('page', 1)
    try:
        page_list = paginator.page(page)
    except PageNotAnInteger:
        page_list = paginator.page(1)
    except EmptyPage:
        page_list = paginator.page(paginator.num_pages)
    c = csrf(req)
    c.update({'page_list': page_list,'num': num, 'interfaces_all':interfaces_all,'env_paras':env_para,'product_alls':product_all,'intervals':interval})
    return render_to_response("interface_testplan.html",c)

def add_testplan(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        suit_list = raw_data['suit_list']
        interfaces = ''
        interfaces1 = ''
        interface_list = suit_list[3]
        L = len(interface_list)
        for i in range(L):
            name1 = interface_list[i].split('_')[2]
            if(L == 1):
                interfaces += interface_list[i]
                interfaces1 += name1
            elif(L > 1 and (i != L-1)):
                interfaces += interface_list[i] + ','
                interfaces1 += name1 + u' ，'
            elif(L > 1 and (i == L-1)):
                interfaces += interface_list[i]
                interfaces1 += name1
        product_id = AutotestplatProduct.objects.filter(product_name=suit_list[4]).first().id
        name_exist = AutotestplatTestplan.objects.filter(suit_name=suit_list[0]).first()
        if name_exist:
            return HttpResponse(f'测试计划[{suit_list[0]}]已存在，请重新填写')
        suit_info1 = AutotestplatTestplan(suit_name=suit_list[0],url_host=suit_list[1],charger=suit_list[2],product_id=product_id,interface_name=interfaces,interface_name_display=interfaces1,task_progress=None,interface_num=L,run_time='')
        suit_info1.save()
        suit_id1 = AutotestplatTestplan.objects.order_by('-id')[0].id
        suit_name1 = AutotestplatTestplan.objects.filter(id=suit_id1).first().suit_name
        name = suit_id1
        task = 'autotest.views_interfacetestplan.api_autotest_task'
        crontab = suit_list[5]
        interval = suit_list[6]
        if crontab !=None and crontab!='':
            year = crontab.split('-')[0]
            month = crontab.split('-')[1]
            day = crontab.split('-')[2].split(' ')[0]
            hour = crontab.split(':')[0].split(' ')[1]
            min = crontab.split(':')[1]
            CrontabSchedule.objects.create(month_of_year=month, day_of_month=day, hour=hour, minute=min, day_of_week='*')
            crontab_id = CrontabSchedule.objects.order_by('-id').first().id
            args = '[' + str(suit_id1) + ']'
            description = request.session.get('user', '')
            enabled = '1'
            PeriodicTask.objects.create(name=name, task=task, args=args, crontab_id=crontab_id, interval_id=None,
                                        enabled=enabled, description=description)
            max_task_id = PeriodicTask.objects.order_by('-id')[0].id
        elif interval !=None and interval!='':
            if interval == "每分钟1次":
                interval_id = '5'
            elif interval == "每小时6次":
                interval_id = '4'
            elif interval == "每天1次":
                interval_id = '3'
            elif interval == "每天10次":
                interval_id = '2'
            elif interval == "每天4次":
                interval_id = '1'
            args = '['+str(suit_id1)+']'
            description = request.session.get('user', '')
            enabled = '1'
            PeriodicTask.objects.create(name=name, task=task, args=args, crontab_id=None, interval_id=interval_id,
                                    enabled=enabled, description=description)
            max_task_id = PeriodicTask.objects.order_by('-id')[0].id
        else:
            max_task_id=None
        interface_name_list = ''
        for i in range(L):
            interface_id = interface_list[i].split('_')[1]
            interface_name1 = interface_list[i].split('_')[2]
            url1 = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().url
            assert_use_new1 = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().assert_use_new
            assert_keywords_old1 = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().assert_keywords_old
            assert_keywords_is_contain1 = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().assert_keywords_is_contain
            body_format = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().body_format,
            formated_dict = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().body,
            update_cookie1 = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().update_cookie,
            mode1 = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().mode,
            head1 = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().head,
            para_suit_info = AutotestplatTestplanInterface(suit_id=suit_id1, suit_name=suit_name1,
                                                       interface_id=interface_id,interface_name=interface_name1, url=url1,
                                                       body_format=body_format[0], body=formated_dict[0], mode=mode1[0],
                                                       update_cookie=update_cookie1[0], head=head1[0],
                                                       assert_keywords_is_contain=assert_keywords_is_contain1,
                                                       assert_use_new=assert_use_new1,
                                                       assert_keywords_old=assert_keywords_old1)
            para_suit_info.save()
            print(para_suit_info, ' insert interface success!')
            max_id = AutotestplatTestplanInterface.objects.order_by('-id')[0].id
            current_interface_name = AutotestplatTestplanInterface.objects.filter(id=max_id).first().interface_name
            interface_name_list1 = 'testplan_interface_' + str(max_id) + '_' + current_interface_name
            if (L == 1):
                interface_name_list += interface_name_list1
            elif (L > 1 and (i != L - 1)):
                interface_name_list += interface_name_list1 + ','
            elif (L > 1 and (i == L - 1)):
                interface_name_list += interface_name_list1
            resp_info_list = AutotestplatParameter.objects.filter(module_id=interface_id).values_list()
            for resp_info in resp_info_list:
                resp_edit_name = resp_info[1]
                resp_edit_keywords = resp_info[2]
                resp_edit_left = resp_info[4]
                resp_edit_right = resp_info[5]
                resp_edit_index = resp_info[6]
                resp_info1 = AutotestplatParameter(name=resp_edit_name, keywords=resp_edit_keywords, value='',
                                                       left=resp_edit_left, right=resp_edit_right,
                                                       index=resp_edit_index, product_id='testplan',
                                                       module_id=max_id, type='res')
                resp_info1.save()
            testplan_interface_order_info = AutotestplatTestplanInterfaceOrder(suit_id=suit_id1,interface_id=max_id)
            testplan_interface_order_info.save()
        AutotestplatTestplan.objects.filter(id=suit_id1).update(interface_name=interface_name_list,task_id=max_task_id)
        return HttpResponse('insert success!')

def del_testplan(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        id1 = raw_data['id1']
        testplanApis = AutotestplatTestplanInterface.objects.filter(suit_id=id1).all()
        for testplanApi in testplanApis:
            AutotestplatParameter.objects.filter(module_id=testplanApi.id, product_id='testplan').delete()
        AutotestplatTestplanInterface.objects.filter(suit_id=id1).delete()
        task = AutotestplatTestplan.objects.filter(id=id1)
        if task:
            task_id = AutotestplatTestplan.objects.filter(id=id1).first().task_id
            PeriodicTask.objects.filter(id=task_id).delete()
        crontab = PeriodicTask.objects.filter(id=task_id)
        if crontab:
            crontab_id = PeriodicTask.objects.filter(id=task_id).first().crontab_id
            CrontabSchedule.objects.filter(id=crontab_id).delete()
        AutotestplatTestplan.objects.filter(id=id1).delete()
        AutotestplatTestplanInterfaceOrder.objects.filter(suit_id=id1).delete()
        return HttpResponse('delete success!')

def search_testplan(req):
    username = req.session.get('user', '')
    key_words_product_id = req.GET.get('key_words_product_id', '')
    key_words_suit = req.GET.get('key_words_suit', '')
    key_words_name = req.GET.get('key_words_name', '')
    key_words_charger = req.GET.get('key_words_charger', '')
    interfaces_all = AutotestplatInterfaceTestcase.objects.all().order_by('-product_id','order')
    if key_words_product_id =='':
        if AuthUser.objects.filter(username=username).first().is_superuser == 1:
            product_id = ""
        else:
            product_id = AuthUser.objects.filter(username=username).first().last_name
    else:
        product_id = AutotestplatProduct.objects.filter(product_name=key_words_product_id).first().id
    suits = AutotestplatTestplan.objects.filter(Q(suit_name__icontains=key_words_suit),Q(product_id__icontains=product_id),Q(interface_name__icontains=key_words_name),Q(charger__icontains=key_words_charger)).order_by('id')
    new_suits = []
    for id in suits:
        new_id = id
        task = PeriodicTask.objects.filter(id=id.task_id).first()
        if task is not None:
            crontab_id = task.crontab_id
        else:
            crontab_id = None
        if task is not None:
            interval_id = task.interval_id
        else:
            interval_id = None
        if crontab_id != None and crontab_id != '':
            runtime_year = datetime.now().year
            runtime_month = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][5]
            runtime_day = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][4]
            runtime_hour = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][2]
            runtime_min = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][1]
            runtime = str(
                runtime_year) + '-' + runtime_month + '-' + runtime_day + ' ' + runtime_hour + ':' + runtime_min
            new_id.task_id = runtime
        elif interval_id != None and interval_id != '':
            runtime_every = IntervalSchedule.objects.filter(id=interval_id).values_list()[0][1]
            runtime_peroid = IntervalSchedule.objects.filter(id=interval_id).values_list()[0][2]
            if runtime_peroid == 'minutes':
                runtime = '每分钟' + str(runtime_every) + '次'
            elif runtime_peroid == 'hours':
                runtime = '每小时' + str(runtime_every) + '次'
            elif runtime_peroid == 'days':
                runtime = '每天' + str(runtime_every) + '次'
            new_id.task_id = runtime
        else:
            new_id.task_id = ""
        product = AutotestplatProduct.objects.filter(id=id.product_id).first()
        if product:
            new_id.product_id = product.product_name
        new_suits.append(new_id)
    paginator = Paginator(new_suits, 11)
    num = len(suits)
    page = req.GET.get('page', 1)
    try:
        page_list = paginator.page(page)
    except PageNotAnInteger:
        page_list = paginator.page(1)
    except EmptyPage:
        page_list = paginator.page(paginator.num_pages)
    c = csrf(req)
    c.update({'page_list': page_list, 'num': num, 'interfaces_all':interfaces_all})
    return render_to_response("interface_testplan.html",c)

def search_testplan_apitestcase(req):
    if req.method == "POST":
        raw_data = req.body
        tname = req.GET.get('testcase_name','')
        pid = req.GET.get('product_id', '')
        print("testcase_name is "+str(tname))
        print("product_id is " + pid)
    return HttpResponse("success")

def show_edit_testplan(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        id1 = raw_data['id1']
        suit_name1 = raw_data['suit_name1']
        suit_info = AutotestplatTestplan.objects.filter(id=id1)[0]
        testplanids=AutotestplatTestplanInterfaceOrder.objects.filter(suit_id=id1).values_list()
        id_list=[]
        for testplanid in testplanids:
            id_list.append(testplanid[2])
        interface_names = ''
        update_list = ''
        interface_ids = ''
        for index, id2 in enumerate(id_list):
            if index == len(id_list) - 1:
                tmp_ids = AutotestplatTestplanInterface.objects.filter(id=id2)
                if tmp_ids:
                    ids=tmp_ids.first().interface_id
                    interface_ids +=str(ids)
                    names = AutotestplatTestplanInterface.objects.filter(id=id2).first().interface_name
                    interface_names += "testplan_interface_"+str(id2)+"_"+names
                    testplan_interface_id = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().interface_id
                    testplan_interface_name = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().interface_name
                    interface_name = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().name
                    testplan_interface_url = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().url
                    interface_url = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().url
                    testplan_interface_head = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().head
                    interface_head = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().head
                    testplan_interface_body = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().body
                    interface_body = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().body
                    testplan_interface_body_format = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().body_format
                    interface_body_format = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().body_format
                    testplan_interface_mode = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().mode
                    interface_mode = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().mode
                    testplan_interface_assert_keywords_old = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().assert_keywords_old
                    interface_assert_keywords_old = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().assert_keywords_old
                    testplan_interface_res = AutotestplatParameter.objects.filter(module_id=id2).filter(product_id='testplan')
                    if testplan_interface_res:
                        testplan_interface_res_name=testplan_interface_res.first().name
                        testplan_interface_res_keywords=testplan_interface_res.first().keywords
                        testplan_interface_res_value=testplan_interface_res.first().value
                        testplan_interface_res_left=testplan_interface_res.first().left
                        testplan_interface_res_right=testplan_interface_res.first().right
                        testplan_interface_res_index=testplan_interface_res.first().index
                        testplan_res=testplan_interface_res_name+testplan_interface_res_keywords+testplan_interface_res_value+testplan_interface_res_left+testplan_interface_res_right+testplan_interface_res_index
                    else:
                        testplan_interface_res_name = ''
                        testplan_interface_res_keywords = ''
                        testplan_interface_res_value = ''
                        testplan_interface_res_left = ''
                        testplan_interface_res_right = ''
                        testplan_interface_res_index = ''
                        testplan_res = testplan_interface_res_name + testplan_interface_res_keywords + testplan_interface_res_value + testplan_interface_res_left + testplan_interface_res_right + testplan_interface_res_index
                    interface_res = AutotestplatParameter.objects.filter(module_id=testplan_interface_id).exclude(product_id='testplan')
                    if interface_res:
                        interface_res_name = interface_res.first().name
                        interface_res_keywords = interface_res.first().keywords
                        interface_res_value = interface_res.first().value
                        interface_res_left = interface_res.first().left
                        interface_res_right = interface_res.first().right
                        interface_res_index = interface_res.first().index
                        res=interface_res_name+interface_res_keywords+interface_res_value+interface_res_left+interface_res_right+interface_res_index
                    else:
                        interface_res_name = ''
                        interface_res_keywords = ''
                        interface_res_value = ''
                        interface_res_left = ''
                        interface_res_right = ''
                        interface_res_index = ''
                        res = interface_res_name + interface_res_keywords + interface_res_value + interface_res_left + interface_res_right + interface_res_index
                    if testplan_interface_name != interface_name:
                        update_list += '1'
                    elif testplan_interface_url != interface_url:
                        update_list += '1'
                    elif testplan_interface_head != interface_head:
                        update_list += '1'
                    elif testplan_interface_body != interface_body:
                        update_list += '1'
                    elif testplan_interface_body_format != interface_body_format:
                        update_list += '1'
                    elif testplan_interface_mode != interface_mode:
                        update_list += '1'
                    elif testplan_interface_assert_keywords_old != interface_assert_keywords_old:
                        update_list += '1'
                    elif testplan_res != res:
                        update_list += '1'
                    else:
                        update_list += '0'
            else:
                tmp_ids = AutotestplatTestplanInterface.objects.filter(id=id2)
                if tmp_ids:
                    ids=tmp_ids.first().interface_id
                    interface_ids += str(ids) + ","
                    names = AutotestplatTestplanInterface.objects.filter(id=id2).first().interface_name
                    interface_names += "testplan_interface_" + str(id2) + "_" + names + ","
                    testplan_interface_id = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().interface_id
                    testplan_interface_name = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().interface_name
                    interface_name = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().name
                    testplan_interface_url = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().url
                    interface_url = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().url
                    testplan_interface_head = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().head
                    interface_head = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().head
                    testplan_interface_body = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().body
                    interface_body = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().body
                    testplan_interface_body_format = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().body_format
                    interface_body_format = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().body_format
                    testplan_interface_mode = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().mode
                    interface_mode = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().mode
                    testplan_interface_assert_keywords_old = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=id1).first().assert_keywords_old
                    interface_assert_keywords_old = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().assert_keywords_old
                    testplan_interface_res = AutotestplatParameter.objects.filter(module_id=id2).filter(product_id='testplan')
                    if testplan_interface_res:
                        testplan_interface_res_name = testplan_interface_res.first().name
                        testplan_interface_res_keywords = testplan_interface_res.first().keywords
                        testplan_interface_res_value = testplan_interface_res.first().value
                        testplan_interface_res_left = testplan_interface_res.first().left
                        testplan_interface_res_right = testplan_interface_res.first().right
                        testplan_interface_res_index = testplan_interface_res.first().index
                        testplan_res = testplan_interface_res_name + testplan_interface_res_keywords + testplan_interface_res_value + testplan_interface_res_left + testplan_interface_res_right + testplan_interface_res_index
                    else:
                        testplan_interface_res_name = ''
                        testplan_interface_res_keywords = ''
                        testplan_interface_res_value = ''
                        testplan_interface_res_left = ''
                        testplan_interface_res_right = ''
                        testplan_interface_res_index = ''
                        testplan_res = testplan_interface_res_name + testplan_interface_res_keywords + testplan_interface_res_value + testplan_interface_res_left + testplan_interface_res_right + testplan_interface_res_index
                    interface_res = AutotestplatParameter.objects.filter(module_id=testplan_interface_id).exclude(product_id='testplan')
                    if interface_res:
                        interface_res_name = interface_res.first().name
                        interface_res_keywords = interface_res.first().keywords
                        interface_res_value = interface_res.first().value
                        interface_res_left = interface_res.first().left
                        interface_res_right = interface_res.first().right
                        interface_res_index = interface_res.first().index
                        res = interface_res_name + interface_res_keywords + interface_res_value + interface_res_left + interface_res_right + interface_res_index
                    else:
                        interface_res_name = ''
                        interface_res_keywords = ''
                        interface_res_value = ''
                        interface_res_left = ''
                        interface_res_right = ''
                        interface_res_index = ''
                        res = interface_res_name + interface_res_keywords + interface_res_value + interface_res_left + interface_res_right + interface_res_index
                    if testplan_interface_name != interface_name:
                        update_list += '1'+ ","
                    elif testplan_interface_url != interface_url:
                        update_list += '1'+ ","
                    elif testplan_interface_head != interface_head:
                        update_list += '1'+ ","
                    elif testplan_interface_body != interface_body:
                        update_list += '1'+ ","
                    elif testplan_interface_body_format != interface_body_format:
                        update_list += '1'+ ","
                    elif testplan_interface_mode != interface_mode:
                        update_list += '1'+ ","
                    elif testplan_interface_assert_keywords_old != interface_assert_keywords_old:
                        update_list += '1'+ ","
                    elif testplan_res != res:
                        update_list += '1'+ ","
                    else:
                        update_list += '0'+ ","

        suit_info.product_id = AutotestplatProduct.objects.filter(id=suit_info.product_id).first().product_name
        crontab = PeriodicTask.objects.filter(id=suit_info.task_id)
        if crontab:
            crontab_id = PeriodicTask.objects.filter(id=suit_info.task_id).first().crontab_id
        else:
            crontab_id = None
        interval = PeriodicTask.objects.filter(id=suit_info.task_id)
        if interval:
            interval_id = PeriodicTask.objects.filter(id=suit_info.task_id).first().interval_id
        else:
            interval_id = None
        if crontab_id != None:
            runtime_year = datetime.now().year
            runtime_month = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][5]
            runtime_day = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][4]
            runtime_hour = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][2]
            runtime_min = CrontabSchedule.objects.filter(id=crontab_id).values_list()[0][1]
            run_time = str(runtime_year) + '-' + runtime_month + '-' + runtime_day + ' ' + runtime_hour + ':' + runtime_min
            run_interval = None
        elif interval_id != None:
            interval_id = PeriodicTask.objects.filter(id=suit_info.task_id).first().interval_id
            runtime_every = IntervalSchedule.objects.filter(id=interval_id).values_list()[0][1]
            runtime_peroid = IntervalSchedule.objects.filter(id=interval_id).values_list()[0][2]
            if runtime_peroid == 'minutes':
                run_interval = '每分钟'+str(runtime_every)+'次'
            elif runtime_peroid == 'hours':
                run_interval = '每小时' + str(runtime_every) + '次'
            elif runtime_peroid == 'days':
                run_interval = '每天' + str(runtime_every) + '次'
            run_time = None
        else:
            run_interval = None
            run_time = None
        suit_info1 = {'id1':id1,
                      'suit_name':suit_info.suit_name,
                      'url_host':suit_info.url_host,
                      'run_interval': run_interval,
                      'run_time':run_time,
                      'id_list': id_list,
                      'interface_name':interface_names,
                      'charger':suit_info.charger,
                      'product_id':suit_info.product_id,
                      'update':update_list,
                      'interface_id':interface_ids,}
        return HttpResponse(json.dumps(suit_info1), content_type='application/json')

def del_row(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        del_id = raw_data['del_id']
        if(del_id != ''):
            AutotestplatTestplanInterface.objects.filter(id=del_id).delete()
        return HttpResponse('delete success!')

def del_row_edit(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        del_id = raw_data['del_id']
        if(del_id != ''):
            AutotestplatTestplanInterface.objects.filter(id=del_id).delete()
            AutotestplatParameter.objects.filter(module_id=del_id,product_id='testplan').delete()
        return HttpResponse('delete success!')

def save_edit_testplan(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        suit_info = raw_data['suit_info']
        interfaces = ''
        interfaces1 = ''
        interface_list = suit_info[3]
        id_list_final = []
        L = len(interface_list)
        for i in range(L):
            tmp_name1 = interface_list[i]
            if(tmp_name1.startswith('testplan_interface') == True):
                name1 = interface_list[i].split('_')[3]
                id1 = interface_list[i].split('_')[2]
                id_list_final.append(id1)
            else:
                name1 = interface_list[i].split('_')[2]
            if(L == 1):
                interfaces += interface_list[i]
                interfaces1 += name1
            elif(L > 1 and (i != L-1)):
                interfaces += interface_list[i] + ','
                interfaces1 += name1 + u' ， '
            elif(L > 1 and (i == L-1)):
                interfaces += interface_list[i]
                interfaces1 += name1
        product_id = AutotestplatProduct.objects.filter(product_name=suit_info[4]).first().id
        AutotestplatTestplan.objects.filter(id=suit_info[0]).update(suit_name=suit_info[1],interface_name=interfaces,url_host=suit_info[2], interface_name_display=interfaces1,product_id=product_id,task_progress=None,interface_num=L,run_time='')
        interval = suit_info[5]
        task_id = AutotestplatTestplan.objects.filter(id=suit_info[0]).first().task_id
        if interval == "每分钟1次":
            PeriodicTask.objects.filter(id=task_id).update(interval_id=5)
        elif interval == "每小时6次":
            PeriodicTask.objects.filter(id=task_id).update(interval_id=4)
        elif interval == "每天1次":
            PeriodicTask.objects.filter(id=task_id).update(interval_id=3)
        elif interval == "每天10次":
            PeriodicTask.objects.filter(id=task_id).update(interval_id=2)
        elif interval == "每天4次":
            PeriodicTask.objects.filter(id=task_id).update(interval_id=1)
        else:
            PeriodicTask.objects.filter(id=task_id).update(interval_id=None)
        crontab = suit_info[6]
        if crontab != '' and crontab != None:
            year = crontab.split('-')[0]
            month = crontab.split('-')[1]
            day = crontab.split('-')[2].split(' ')[0]
            hour = crontab.split(':')[0].split(' ')[1]
            min = crontab.split(':')[1]
            task_id = AutotestplatTestplan.objects.filter(id=suit_info[0]).first().task_id
            crontab_exist = PeriodicTask.objects.filter(id=task_id).first()
            if crontab_exist.crontab_id is not None:
                crontab_id = crontab_exist.crontab_id
                CrontabSchedule.objects.filter(id=crontab_id).update(month_of_year=month, day_of_month=day, hour=hour,
                                                                     minute=min, day_of_week='*')
            else:
                CrontabSchedule.objects.create(month_of_year=month, day_of_month=day, hour=hour, minute=min,
                                               day_of_week='*')
                crontab_id = CrontabSchedule.objects.order_by('-id').first().id
                PeriodicTask.objects.filter(id=task_id).update(crontab_id=crontab_id)
        else:
            task_id = AutotestplatTestplan.objects.filter(id=suit_info[0]).first().task_id
            PeriodicTask.objects.filter(id=task_id).update(crontab_id=None)
        tmp_list = AutotestplatTestplanInterface.objects.filter(suit_id=suit_info[0])
        for rec in tmp_list:
            interface_status1 = AutotestplatTestplanInterface.objects.filter(id=rec.id).update(suit_name=suit_info[1])
            print(interface_status1,' update success!')
            if(str(rec.id) not in id_list_final):
                AutotestplatTestplanInterface.objects.filter(id=rec.id).delete()
                AutotestplatParameter.objects.filter(module_id=rec.id,product_id='testplan').delete()
        AutotestplatTestplanInterfaceOrder.objects.filter(suit_id=suit_info[0]).delete()
        suit_info_list = AutotestplatTestplan.objects.filter(id=suit_info[0])[0]
        id_list = []
        tmp_id_list = suit_info_list.interface_name.split(',')
        for rec in tmp_id_list:
            if (rec.startswith('testplan_interface') == True):
                tmp_id_insert = rec.split('_')[2]
                id_list.append(tmp_id_insert)
            else:
                tmp_id = rec.split('_')[1]
                suit_id1 = suit_info[0]
                suit_name1 = suit_info[1]
                interface_id1 = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().id
                interface_name1 = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().name
                url1 = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().url
                assert_use_new1 = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().assert_use_new
                assert_keywords_old1 = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().assert_keywords_old
                assert_keywords_is_contain1 = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().assert_keywords_is_contain
                body_format = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().body_format,
                formated_dict = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().body,
                update_cookie1 = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().update_cookie,
                mode1 = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().mode,
                head1 = AutotestplatInterfaceTestcase.objects.filter(id=tmp_id).first().head,
                para_suit_info = AutotestplatTestplanInterface(suit_id=suit_id1, suit_name=suit_name1,interface_id=interface_id1,
                                                                   interface_name=interface_name1, url=url1,
                                                                   body_format=body_format[0], body=formated_dict[0],
                                                                   mode=mode1[0],
                                                                   update_cookie=update_cookie1[0], head=head1[0],
                                                                   assert_keywords_is_contain=assert_keywords_is_contain1,
                                                                   assert_use_new=assert_use_new1,
                                                                   assert_keywords_old=assert_keywords_old1)
                para_suit_info.save()
                max_id = AutotestplatTestplanInterface.objects.order_by('-id')[0].id
                id_list.append(max_id)
                resp_info_list = AutotestplatParameter.objects.filter(module_id=tmp_id).values_list()
                for resp_info in resp_info_list:
                    resp_edit_name = resp_info[1]
                    resp_edit_keywords = resp_info[2]
                    resp_edit_left = resp_info[4]
                    resp_edit_right = resp_info[5]
                    resp_edit_index = resp_info[6]
                    resp_info1 = AutotestplatParameter(name=resp_edit_name, keywords=resp_edit_keywords, value='',
                                                           left=resp_edit_left, right=resp_edit_right,
                                                           index=resp_edit_index, product_id='testplan',
                                                           module_id=max_id, type='res')
                    resp_info1.save()
        for interface_id in id_list:
            testplan_interface_order_info = AutotestplatTestplanInterfaceOrder(suit_id=suit_info[0], interface_id=interface_id)
            testplan_interface_order_info.save()
        interfaces=AutotestplatTestplanInterface.objects.filter(suit_id=suit_info[0]).values_list()
        i_num = len(interfaces)
        interface_name_list=''
        for index,interface in enumerate(interfaces):
            if index == len(interfaces) - 1:
                interfaceid = interface[0]
                interfacename = interface[4]
                interface_name_list += 'testplan_interface_' + str(interfaceid) + '_' + interfacename
            else:
                interfaceid = interface[0]
                interfacename = interface[4]
                interface_name_list += 'testplan_interface_' + str(interfaceid) + '_' + interfacename + ','
        AutotestplatTestplan.objects.filter(id=suit_info[0]).update(interface_name=interface_name_list,task_progress=None,interface_num=i_num,run_time='')
        return HttpResponse('update_use_status success!')


def update_testplan_interface(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        update_info = raw_data['update_info']
        testplan_id = update_info[0]
        testplan_interface_id = update_info[2]
        interface_id = update_info[5]
        interface_name = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().name
        interface_url = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().url
        interface_head = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().head
        interface_body = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().body
        interface_body_format = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().body_format
        interface_mode = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().mode
        interface_assert_keywords_old = AutotestplatInterfaceTestcase.objects.filter(id=interface_id).first().assert_keywords_old
        AutotestplatTestplanInterface.objects.filter(id=testplan_interface_id).filter(suit_id=testplan_id).filter(interface_id=interface_id).update(interface_name=interface_name,url=interface_url,head=interface_head,body=interface_body,body_format=interface_body_format,mode=interface_mode,assert_keywords_old=interface_assert_keywords_old)
        case_res = AutotestplatParameter.objects.filter(module_id=interface_id).exclude(product_id='testplan')
        if case_res:
            case_res_name = case_res.first().name
            case_res_keywords = case_res.first().keywords
            case_res_value = case_res.first().value
            case_res_left = case_res.first().left
            case_res_right = case_res.first().right
            case_res_index = case_res.first().index
            plan_res = AutotestplatParameter.objects.filter(module_id=testplan_interface_id).filter(product_id='testplan')
            if plan_res:
                AutotestplatParameter.objects.filter(module_id=testplan_interface_id).filter(product_id='testplan').update(name=case_res_name,keywords=case_res_keywords,value=case_res_value,left=case_res_left,right=case_res_right,index=case_res_index)
            else:
                AutotestplatParameter.objects.create(module_id=testplan_interface_id,product_id='testplan',name=case_res_name, keywords=case_res_keywords, value=case_res_value,left=case_res_left, right=case_res_right, index=case_res_index)
        else:
            plan_res = AutotestplatParameter.objects.filter(module_id=testplan_interface_id).filter(product_id='testplan')
            if plan_res:
                AutotestplatParameter.objects.filter(module_id=testplan_interface_id).filter(product_id='testplan').delete()
        suit_info = AutotestplatTestplan.objects.filter(id=testplan_id)[0]
        testplanids=AutotestplatTestplanInterfaceOrder.objects.filter(suit_id=testplan_id).values_list()
        id_list=[]
        for testplanid in testplanids:
            id_list.append(testplanid[2])
        interface_names = ''
        update_list = ''
        interface_ids = ''
        for index, id2 in enumerate(id_list):
            if index == len(id_list) - 1:
                ids = AutotestplatTestplanInterface.objects.filter(id=id2).first().interface_id
                interface_ids +=str(ids)
                names = AutotestplatTestplanInterface.objects.filter(id=id2).first().interface_name
                interface_names += "testplan_interface_"+str(id2)+"_"+names
                testplan_interface_id = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().interface_id
                testplan_interface_name = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().interface_name
                interface_name = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().name
                testplan_interface_url = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().url
                interface_url = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().url
                testplan_interface_head = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().head
                interface_head = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().head
                testplan_interface_body = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().body
                interface_body = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().body
                testplan_interface_body_format = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().body_format
                interface_body_format = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().body_format
                testplan_interface_mode = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().mode
                interface_mode = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().mode
                testplan_interface_assert_keywords_old = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().assert_keywords_old
                interface_assert_keywords_old  = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().assert_keywords_old
                testplan_interface_res = AutotestplatParameter.objects.filter(module_id=id2).filter(product_id='testplan')
                if testplan_interface_res:
                    testplan_interface_res_name = testplan_interface_res.first().name
                    testplan_interface_res_keywords = testplan_interface_res.first().keywords
                    testplan_interface_res_value = testplan_interface_res.first().value
                    testplan_interface_res_left = testplan_interface_res.first().left
                    testplan_interface_res_right = testplan_interface_res.first().right
                    testplan_interface_res_index = testplan_interface_res.first().index
                    testplan_res = testplan_interface_res_name + testplan_interface_res_keywords + testplan_interface_res_value + testplan_interface_res_left + testplan_interface_res_right + testplan_interface_res_index
                else:
                    testplan_interface_res_name = ''
                    testplan_interface_res_keywords = ''
                    testplan_interface_res_value = ''
                    testplan_interface_res_left = ''
                    testplan_interface_res_right = ''
                    testplan_interface_res_index = ''
                    testplan_res = testplan_interface_res_name + testplan_interface_res_keywords + testplan_interface_res_value + testplan_interface_res_left + testplan_interface_res_right + testplan_interface_res_index
                interface_res = AutotestplatParameter.objects.filter(module_id=testplan_interface_id).exclude(product_id='testplan')
                if interface_res:
                    interface_res_name = interface_res.first().name
                    interface_res_keywords = interface_res.first().keywords
                    interface_res_value = interface_res.first().value
                    interface_res_left = interface_res.first().left
                    interface_res_right = interface_res.first().right
                    interface_res_index = interface_res.first().index
                    res = interface_res_name + interface_res_keywords + interface_res_value + interface_res_left + interface_res_right + interface_res_index
                else:
                    interface_res_name = ''
                    interface_res_keywords = ''
                    interface_res_value = ''
                    interface_res_left = ''
                    interface_res_right = ''
                    interface_res_index = ''
                    res = interface_res_name + interface_res_keywords + interface_res_value + interface_res_left + interface_res_right + interface_res_index
                if testplan_interface_name != interface_name:
                    update_list += '1'
                elif testplan_interface_url != interface_url:
                    update_list += '1'
                elif testplan_interface_head != interface_head:
                    update_list += '1'
                elif testplan_interface_body != interface_body:
                    update_list += '1'
                elif testplan_interface_body_format != interface_body_format:
                    update_list += '1'
                elif testplan_interface_mode != interface_mode:
                    update_list += '1'
                elif testplan_interface_assert_keywords_old != interface_assert_keywords_old:
                    update_list += '1'
                elif testplan_res != res:
                    update_list += '1'
                else:
                    update_list += '0'
            else:
                ids = AutotestplatTestplanInterface.objects.filter(id=id2).first().interface_id
                interface_ids += str(ids) + ","
                names = AutotestplatTestplanInterface.objects.filter(id=id2).first().interface_name
                interface_names += "testplan_interface_" + str(id2) + "_" + names + ","
                testplan_interface_id = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().interface_id
                testplan_interface_name = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().interface_name
                interface_name = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().name
                testplan_interface_url = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().url
                interface_url = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().url
                testplan_interface_head = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().head
                interface_head = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().head
                testplan_interface_body = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().body
                interface_body = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().body
                testplan_interface_body_format = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().body_format
                interface_body_format = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().body_format
                testplan_interface_mode = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().mode
                interface_mode = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().mode
                testplan_interface_assert_keywords_old = AutotestplatTestplanInterface.objects.filter(id=id2).filter(suit_id=testplan_id).first().assert_keywords_old
                interface_assert_keywords_old  = AutotestplatInterfaceTestcase.objects.filter(id=testplan_interface_id).first().assert_keywords_old
                testplan_interface_res = AutotestplatParameter.objects.filter(module_id=id2).filter(product_id='testplan')
                if testplan_interface_res:
                    testplan_interface_res_name = testplan_interface_res.first().name
                    testplan_interface_res_keywords = testplan_interface_res.first().keywords
                    testplan_interface_res_value = testplan_interface_res.first().value
                    testplan_interface_res_left = testplan_interface_res.first().left
                    testplan_interface_res_right = testplan_interface_res.first().right
                    testplan_interface_res_index = testplan_interface_res.first().index
                    testplan_res = testplan_interface_res_name + testplan_interface_res_keywords + testplan_interface_res_value + testplan_interface_res_left + testplan_interface_res_right + testplan_interface_res_index
                else:
                    testplan_interface_res_name = ''
                    testplan_interface_res_keywords = ''
                    testplan_interface_res_value = ''
                    testplan_interface_res_left = ''
                    testplan_interface_res_right = ''
                    testplan_interface_res_index = ''
                    testplan_res = testplan_interface_res_name + testplan_interface_res_keywords + testplan_interface_res_value + testplan_interface_res_left + testplan_interface_res_right + testplan_interface_res_index
                interface_res = AutotestplatParameter.objects.filter(module_id=testplan_interface_id).exclude(product_id='testplan')
                if interface_res:
                    interface_res_name = interface_res.first().name
                    interface_res_keywords = interface_res.first().keywords
                    interface_res_value = interface_res.first().value
                    interface_res_left = interface_res.first().left
                    interface_res_right = interface_res.first().right
                    interface_res_index = interface_res.first().index
                    res = interface_res_name + interface_res_keywords + interface_res_value + interface_res_left + interface_res_right + interface_res_index
                else:
                    interface_res_name = ''
                    interface_res_keywords = ''
                    interface_res_value = ''
                    interface_res_left = ''
                    interface_res_right = ''
                    interface_res_index = ''
                    res = interface_res_name + interface_res_keywords + interface_res_value + interface_res_left + interface_res_right + interface_res_index
                if testplan_interface_name != interface_name:
                    update_list += '1' + ","
                elif testplan_interface_url != interface_url:
                    update_list += '1' + ","
                elif testplan_interface_head != interface_head:
                    update_list += '1' + ","
                elif testplan_interface_body != interface_body:
                    update_list += '1' + ","
                elif testplan_interface_body_format != interface_body_format:
                    update_list += '1' + ","
                elif testplan_interface_mode != interface_mode:
                    update_list += '1' + ","
                elif testplan_interface_assert_keywords_old != interface_assert_keywords_old:
                    update_list += '1' + ","
                elif testplan_res != res:
                    update_list += '1' + ","
                else:
                    update_list += '0' + ","
        suit_info.product_id = AutotestplatProduct.objects.filter(id=suit_info.product_id).first().product_name
        suit_info1 = {
                      'id_list': id_list,
                      'interface_name':interface_names,
                      'update':update_list,
                      'interface_id':interface_ids,}
    return HttpResponse(json.dumps(suit_info1), content_type='application/json')



test_time = ''
response_time = ''
report_id = str(datetime.now().strftime("%Y%m%d%H%M%S%f"))
def start_interface_testplan(request):
    if request.method == "POST":
        try:
            raw_data = request.body
            raw_data = json.loads(raw_data)
            cur_id = raw_data['cur_id']
            suit_id = raw_data['suit_id']
            suit_name = raw_data['suit_name']
            global test_time
            global response_time
            global report_id
            now = datetime.now()
            present_time1 = now.strftime("%Y-%m-%d %H:%M:%S")
            report_id = report_id
            row_index = raw_data['row_index']
            if(str(row_index) == '0'):
                test_time = present_time1
            public_list = AutotestplatParameter.objects.filter()
            keyword_list = ["{"+rec.keywords+"}" for rec in public_list]
            public_list1 = AutotestplatParameter.objects.filter(Q(type='con'))
            keyword_list1 = ["{"+rec.keywords+"}" for rec in public_list1]
            public_dict1 = {}
            for rec in public_list1:
                public_dict1[rec.keywords] = rec.value
            public_list4 = AutotestplatParameter.objects.filter(Q(type='env'))
            keyword_list4 = ["{" + rec.keywords + "}" for rec in public_list4]
            public_dict4 = {}
            for rec in public_list4:
                public_dict4[rec.keywords] = rec.value
            public_list5 = AutotestplatParameter.objects.filter(Q(type='var'))
            keyword_list5 = ["{" + rec.keywords + "}" for rec in public_list5]
            public_dict5 = {}
            for rec in public_list5:
                public_dict5[rec.keywords] = rec.value
            public_list2 = AutotestplatParameter.objects.filter(type='res')
            keyword_list2 = ["{"+rec.keywords+"}" for rec in public_list2]
            public_dict2 = {}
            for rec in public_list2:
                public_dict2[rec.keywords] = str((rec.left,rec.right,rec.index))
            public_list3 = AutotestplatParameter.objects.filter(Q(type='con'),Q(type='env'))
            keyword_list3 = ["{"+rec.keywords+"}" for rec in public_list3]
            public_dict3 = {}
            for rec in public_list3:
                public_dict3[rec.keywords] = rec.value
            public_dict = {}
            public_dict.update(public_dict1)
            public_dict.update(public_dict2)
            public_dict.update(public_dict4)
            public_dict.update(public_dict5)
            f_handler = open(logfile, 'w')
            f_handler.truncate()
            f_handler.close()
            testplanapis = AutotestplatTestplanInterface.objects.all()
            ids = []
            for testplan in testplanapis:
                ids.append(testplan.id)
            count = ids.count(int(cur_id))
            id_list=[]
            if count>0:
                cur_interface = AutotestplatTestplanInterface.objects.filter(id=cur_id)[0]
                host = AutotestplatTestplan.objects.filter(id=cur_interface.suit_id)[0]
                host = host.url_host
                try:
                    if ("{" in host and "}" in host):
                        end_index = host.find("}")
                        key_url = host[:end_index + 1]
                        host = host.replace(key_url, public_dict[key_url.replace('{', '').replace('}', '').strip()])
                except:
                    return HttpResponse('【ERROR】：url_host参数 ' + url_host + ' 有误，请重新修改 ')
                interface_name=cur_interface.interface_name
                print(interface_name)
                url = cur_interface.url
                try:
                    if ("{" in url and "}" in url):
                        end_index = url.find("}")
                        key_url = url[:end_index + 1]
                        url = url.replace(key_url, public_dict[key_url.replace('{', '').replace('}', '')])
                except:
                    return HttpResponse('【ERROR】：url参数 ' + url + ' 有误，请重新修改 ')
                url = host + url
                head = eval(cur_interface.head)
                for rec in head.keys():
                    if (head[rec] in keyword_list1):
                        head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                    elif (head[rec] in keyword_list4):
                        head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                    elif (head[rec] in keyword_list5):
                        head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                        head[rec] = str(eval(head[rec]))
                    elif (head[rec] in keyword_list2):
                        try:
                            head[rec] = cache.get(head[rec].replace('{', '').replace('}', ''))
                        except Exception:
                            return HttpResponse(
                                '【ERROR】：参数 ' + head[rec] + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' +
                                head[rec] + ' 的前置接口，以及确认Redis是否已启动')
                is_login_api = False
                n = 0
                while (n < 5):
                    body = eval(cur_interface.body)
                    for rec in body.keys():
                        if (isinstance(body[rec], str)):
                            for rec1 in keyword_list1:
                                if (rec1 in body[rec]):
                                    if ('captcha' not in rec1):
                                        body[rec] = body[rec].replace(rec1, public_dict[
                                            rec1.replace('{', '').replace('}', '')])
                                    else:
                                        is_login_api = True
                                        yanzheng_url = public_dict[rec1.replace('{', '').replace('}', '')]
                                        haha = request_get(yanzheng_url, {}, {}, 0)
                                        with open(codefile, 'wb') as f:
                                            f.write(haha.content)
                                        yanzheng = getcaptcha()
                                        body[rec] = yanzheng
                                        print_log('【登录验证码】：', ','), print_log(yanzheng)
                            for rec5 in keyword_list5:
                                if (rec5 in body[rec]):
                                    try:
                                        body[rec] = body[rec].replace(rec5, public_dict[
                                            rec5.replace('{', '').replace('}', '')])
                                        body[rec] = str(eval(body[rec]))
                                    except Exception:
                                        error_info = traceback.format_exc()
                                        print(error_info)
                                        return HttpResponse(
                                            '【ERROR】：参数 ' + rec5 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec5 + ' 的前置接口，以及确认Redis是否已启动')
                            for rec2 in keyword_list2:
                                if (rec2 in body[rec]):
                                    try:
                                        parares = cache.get(rec2.replace('{', '').replace('}', ''))
                                        if parares==None:
                                            print_log('【ERROR】：参数 ' + rec2 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec2 + ' 的前置接口，以及确认Redis是否已启动')
                                        else:
                                            body[rec] = body[rec].replace(rec2, cache.get(rec2.replace('{', '').replace('}', '')).decode('utf-8'))
                                    except Exception:
                                        error_info = traceback.format_exc()
                                        print(error_info)
                                        return HttpResponse('【ERROR】：参数 ' + rec2 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec2 + ' 的前置接口，以及确认Redis是否已启动')
                            for rec3 in keyword_list3:
                                if (rec3 in body[rec]):
                                    para = copy.deepcopy(body)
                                    body[rec] = sign_nb(para)
                            if ('select' in body[rec]):
                                try:
                                    sql = body[rec]
                                    cursor = connection.cursor()
                                    cursor.execute(sql)
                                    data = cursor.fetchall()
                                    print(u'查询的结果为： ', data[0][0])
                                    body[rec] = data[0][0]
                                except Exception:
                                    body[rec] = '【ERROR】：查询结果为空！'
                    mode = cur_interface.mode
                    body_format = cur_interface.body_format
                    starttime = datetime.now()
                    response, cookie = interface_test_start(url, body, head, mode, body_format, True)
                    endtime = datetime.now()
                    response_time = (endtime - starttime).total_seconds()
                    update_cookie = cur_interface.update_cookie
                    public_resp = AutotestplatParameter.objects.filter(module_id=int(cur_id))
                    if (str(public_resp) != '[]'):
                        for rec in public_resp:
                            left = rec.left
                            right = rec.right
                            index = int(rec.index)
                            reg = left + '.+?' + right
                            result_all = re.findall(reg, response)
                            try:
                                result_tmp = result_all[index]
                                start = len(left)
                                end = len(result_tmp) - len(right)
                                result = result_tmp[start:end]
                                print(rec.keywords, '匹配结果为：', result)
                                cache.set(rec.keywords, result)
                                cache.expire(rec.keywords, 3600)
                            except Exception:
                                print((rec.keywords, left, right, index), ' 在返回结果中未匹配到')
                    is_new = cur_interface.assert_use_new
                    if (is_new == '1'):
                        assert_url = cur_interface.assert_url
                        assert_head = eval(cur_interface.assert_head)
                        for rec in assert_head.keys():
                            if (assert_head[rec] in keyword_list1):
                                assert_head[rec] = public_dict[assert_head[rec].replace('{', '').replace('}', '')]
                            elif (assert_head[rec] in keyword_list2):
                                try:
                                    assert_head[rec] = cache.get(assert_head[rec].replace('{', '').replace('}', ''))
                                except Exception:
                                    return HttpResponse('【ERROR】：参数 ' + assert_head[
                                        rec] + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + assert_head[
                                                            rec] + ' 的前置接口，以及确认Redis是否已启动')
                        assert_mode = cur_interface.assert_mode
                        assert_body = eval(cur_interface.assert_body)
                        for rec in assert_body.keys():
                            if (isinstance(assert_body[rec], str)):
                                for rec1 in keyword_list1:
                                    if (rec1 in assert_body[rec]):
                                        assert_body[rec] = assert_body[rec].replace(rec1, public_dict[
                                            rec1.replace('{', '').replace('}', '')])
                                for rec2 in keyword_list2:
                                    if (rec2 in assert_body[rec]):
                                        try:
                                            assert_body[rec] = assert_body[rec].replace(rec2, cache.get(
                                                rec2.replace('{', '').replace('}', '')).decode('utf-8'))
                                        except Exception:
                                            error_info = traceback.format_exc()
                                            print(error_info)
                                            return HttpResponse(
                                                '【ERROR】：参数 ' + rec2 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec2 + ' 的前置接口，以及确认Redis是否已启动')
                                for rec3 in keyword_list3:
                                    if (rec3 in assert_body[rec]):
                                        para = copy.deepcopy(assert_body)
                                        assert_body[rec] = sign_nb(para)
                                if ('select' in assert_body[rec]):
                                    try:
                                        sql = assert_body[rec]
                                        cursor = connection.cursor()
                                        print(sql)
                                        cursor.execute(sql)
                                        data = cursor.fetchall()
                                        print(u'查询的结果为： ', data[0][0])
                                        assert_body[rec] = data[0][0]
                                    except Exception:
                                        assert_body[rec] = '【ERROR】：查询结果为空！'
                        assert_keywords = cur_interface.assert_keywords
                        for rec1 in keyword_list1:
                            if (rec1 in assert_keywords):
                                assert_keywords = assert_keywords.replace(rec1, public_dict[
                                    rec1.replace('{', '').replace('}', '')])
                        for rec2 in keyword_list2:
                            if (rec2 in assert_keywords):
                                try:
                                    assert_keywords = assert_keywords.replace(rec2, cache.get(
                                        rec2.replace('{', '').replace('}', '')).decode('utf-8'))
                                except Exception:
                                    error_info = traceback.format_exc()
                                    print(error_info)
                                    return HttpResponse(
                                        '【ERROR】：参数 ' + rec2 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec2 + ' 的前置接口，以及确认Redis是否已启动')
                        if ('select' in assert_keywords):
                            try:
                                sql = assert_keywords
                                cursor = connection.cursor()
                                print(sql)
                                cursor.execute(sql)
                                data = cursor.fetchall()
                                print(u'查询的结果为： ', data[0][0])
                                assert_keywords = data[0][0]
                            except Exception:
                                assert_keywords = '【ERROR】：查询结果为空！'
                        is_contain = cur_interface.assert_keywords_is_contain
                        assert_body_format = cur_interface.assert_body_format
                        result1 = assert_test(assert_url, assert_head, assert_mode, assert_body, assert_keywords,
                                              is_contain, assert_body_format, True)
                        time.sleep(0.1)
                    else:
                        assert_keywords_old = cur_interface.assert_keywords_old
                        for rec1 in keyword_list1:
                            if (rec1 in assert_keywords_old):
                                assert_keywords_old = assert_keywords_old.replace(rec1, public_dict[
                                    rec1.replace('{', '').replace('}', '')])
                        for rec2 in keyword_list2:
                            if (rec2 in assert_keywords_old):
                                try:
                                    assert_keywords_old = assert_keywords_old.replace(rec2, cache.get(
                                        rec2.replace('{', '').replace('}', '')).decode('utf-8'))
                                except Exception:
                                    error_info = traceback.format_exc()
                                    print(error_info)
                                    return HttpResponse(
                                        '【ERROR】：参数 ' + rec2 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec2 + ' 的前置接口，以及确认Redis是否已启动')
                        if ('select' in assert_keywords_old):
                            try:
                                sql = assert_keywords_old
                                cursor = connection.cursor()
                                print(sql)
                                cursor.execute(sql)
                                data = cursor.fetchall()
                                print(u'查询的结果为： ', data[0][0])
                                assert_keywords_old = data[0][0]
                            except Exception:
                                assert_keywords_old = '【ERROR】：查询结果为空！'
                        result1 = assert_test_old(response, assert_keywords_old, True)
                    if (is_login_api == True):
                        if (result1 != 0):
                            n += 1
                        elif (result1 == 0):
                            break
                    else:
                        break
                File = logfile
                File1 = open(File, 'r', encoding='utf-8')
                test_log = File1.readlines()
                test_log = str(test_log)
                test_log = test_log.replace('<', '[').replace('>', "]")
                test_log = eval(test_log)
                return HttpResponse(test_log)
            else:
                interfaces = AutotestplatInterfaceTestcase.objects.filter(id=cur_id)[0]
                print_log('【接口名称】: ', ','), print_log(str(cur_id) + "_", ','), print_log(interfaces.name)
                print_log('【请求方式】: ', ','), print_log(interfaces.mode)
                url_host = interfaces.url_host
                try:
                    if ("{" in url_host and "}" in url_host):
                        end_index = url_host.find("}")
                        key_url_host = url_host[:end_index + 1]
                        url_host = url_host.replace(key_url_host, public_dict[
                            key_url_host.replace('{', '').replace('}', '').replace(' ', '')])
                except:
                    return HttpResponse('【ERROR】：url_host参数 ' + url_host + ' 有误，请重新修改 ')
                url = interfaces.url
                try:
                    if ("{" in url and "}" in url):
                        end_index = url.find("}")
                        start_index = url.find("{")
                        key_url = url[start_index:end_index + 1]
                        url = url.replace(key_url, public_dict[key_url.replace('{', '').replace('}', '')])
                except:
                    return HttpResponse('【ERROR】：url参数 ' + url + ' 有误，请重新修改 ')
                url = url_host + url
                head = eval(interfaces.head)
                for rec in head.keys():
                    if (head[rec] in keyword_list1):
                        head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                    elif (head[rec] in keyword_list4):
                        head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                    elif (head[rec] in keyword_list5):
                        head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                        head[rec] = str(eval(head[rec]))
                    elif (head[rec] in keyword_list2):
                        try:
                            head[rec] = cache.get(head[rec].replace('{', '').replace('}', ''))
                        except Exception:
                            error_info = traceback.format_exc()
                            print(error_info)
                            return HttpResponse(
                                '【ERROR】：参数 ' + head[rec] + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' +
                                head[rec] + ' 的前置接口，以及确认Redis是否已启动')
                is_login_api = False
                n = 0
                while (n < 5):
                    body = eval(interfaces.body)
                    for rec in body.keys():
                        if (isinstance(body[rec], str)):
                            for rec1 in keyword_list1:
                                if (rec1 in body[rec]):
                                    if ('captcha' not in rec1):
                                        body[rec] = body[rec].replace(rec1, public_dict[
                                            rec1.replace('{', '').replace('}', '')])
                                    else:
                                        is_login_api = True
                                        yanzheng_url = public_dict[rec1.replace('{', '').replace('}', '')]
                                        haha = request_get(yanzheng_url, {}, {}, 0)
                                        with open(codefile, 'wb') as f:
                                            f.write(haha.content)
                                        yanzheng = getcaptcha()
                                        body[rec] = yanzheng
                                        print_log('【登录验证码】：', ','), print_log(yanzheng)
                            for rec5 in keyword_list5:
                                if (rec5 in body[rec]):
                                    try:
                                        body[rec] = body[rec].replace(rec5, public_dict[
                                            rec5.replace('{', '').replace('}', '')])
                                        body[rec] = str(eval(body[rec]))
                                    except Exception:
                                        error_info = traceback.format_exc()
                                        print(error_info)
                                        return HttpResponse(
                                            '【ERROR】：参数 ' + rec5 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec5 + ' 的前置接口，以及确认Redis是否已启动')
                            for rec2 in keyword_list2:
                                if (rec2 in body[rec]):
                                    try:
                                        body[rec] = body[rec].replace(rec2, cache.get(
                                            rec2.replace('{', '').replace('}', '')).decode('utf-8'))
                                    except Exception:
                                        error_info = traceback.format_exc()
                                        print(error_info)
                                        return HttpResponse(
                                            '【ERROR】：参数 ' + rec2 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec2 + ' 的前置接口，以及确认Redis是否已启动')
                            for rec3 in keyword_list3:
                                if (rec3 in body[rec]):
                                    para = copy.deepcopy(body)
                                    body[rec] = sign_nb(para)
                            if ('select' in body[rec]):
                                try:
                                    sql = body[rec]
                                    cursor = connection.cursor()
                                    cursor.execute(sql)
                                    data = cursor.fetchall()
                                    print(u'查询的结果为： ', data[0][0])
                                    body[rec] = data[0][0]
                                except Exception:
                                    body[rec] = '【ERROR】：查询结果为空！'
                    mode = interfaces.mode
                    body_format = interfaces.body_format
                    try:
                        response, cookie = interface_test_start(url, body, head, mode, body_format,
                                                                True)  # False，不打印日志；True，打印日志
                    except:
                        return HttpResponse('【ERROR】：' + url + ' 接口录入信息有误，请重新修改')
                    update_cookie = interfaces.update_cookie
                    public_resp = AutotestplatParameter.objects.filter(module_id=int(cur_id)).exclude(product_id='testplan')
                    if (str(public_resp) != '[]'):
                        for rec in public_resp:
                            left = rec.left
                            right = rec.right
                            index = int(rec.index)
                            reg = left + '.+?' + right
                            result_all = re.findall(reg, response)
                            print(result_all)
                            try:
                                result_tmp = result_all[index]
                                start = len(left)
                                end = len(result_tmp) - len(right)
                                result = result_tmp[start:end]
                                cache.set(rec.keywords, result)
                                cache.expire(rec.keywords, 3600)
                                print_log('【响应关联参数】： {' + rec.keywords + '}，匹配的第' + str(
                                    index + 1) + '个值为：' + result)
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                print_log(
                                    '【响应关联参数】： {' + rec.keywords + '} 在响应数据中未匹配到，请检测前置接口关键字配置，以及Redis是否已启动')
                    assert_keywords_old = interfaces.assert_keywords_old
                    for rec1 in keyword_list1:
                        if (rec1 in assert_keywords_old):
                            assert_keywords_old = assert_keywords_old.replace(rec1, public_dict[
                                rec1.replace('{', '').replace('}', '')])
                    for rec2 in keyword_list2:
                        if (rec2 in assert_keywords_old):
                            try:
                                assert_keywords_old = assert_keywords_old.replace(rec2, cache.get(
                                    rec2.replace('{', '').replace('}', '')))
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                return HttpResponse(
                                    '【ERROR】：参数 ' + rec2 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec2 + ' 的前置接口，以及确认Redis是否已启动')
                        if ('select' in assert_keywords_old):
                            sql = assert_keywords_old
                            cursor = connection.cursor()
                            cursor.execute(sql)
                            data = cursor.fetchall()
                            print(u'查询的结果为： ', data[0][0])
                            assert_keywords_old = data[0][0]
                    assert_result = assert_test_old(response, assert_keywords_old, True)
                    if (is_login_api == True):
                        if (assert_result != 0):
                            n += 1
                        elif (assert_result == 0):
                            break
                    else:
                        break
                File = logfile
                File1 = open(File, 'r', encoding='utf-8')
                test_log = File1.readlines()
                test_log = str(test_log)
                test_log = test_log.replace('<', '[').replace('>', "]")
                test_log = eval(test_log)
                return HttpResponse(test_log)
        except Exception:
            error_info = traceback.format_exc()
        print(error_info)
        return HttpResponse(error_info)


def runTestplan(request,suit_id):
    runtask = 'api_autotest_task'+'('+str(suit_id)+')'
    eval(runtask)
    return HttpResponse(200)

def getProgress(request,suit_id):
    instance = AutotestplatTestplan.objects.filter(id=suit_id)
    if instance:
        progress = instance.first().task_progress
        run_time = instance.first().run_time
        data = {'progress': progress, 'run_time': run_time}
    else:
        data = {'progress': '', 'run_time': ''}
    return HttpResponse(json.dumps(data), content_type='application/json')


test_time = ''
response_time = ''
report_id = ''
@app.task
def api_autotest_task(suit_id):
    try:
        global test_time
        global response_time
        global report_id
        test_time = time.strftime("%Y-%m-%d %H:%M:%S")
        report_id = str(datetime.now().strftime("%Y%m%d%H%M%S%f"))
        sql = "select t3.interface_id,t2.interface_name,t2.suit_id,t2.suit_name,t2.mode,t2.url,t2.body,t2.assert_keywords_old from autotestplat_testplan t1 INNER JOIN autotestplat_testplan_interface t2 on t1.id=t2.suit_id INNER JOIN autotestplat_testplan_interface_order t3 on t2.suit_id=t3.suit_id and t2.id=t3.interface_id where t2.suit_id="+str(suit_id)+" order by t1.product_id"
        cursor = connection.cursor()
        aa = cursor.execute(sql)
        interface_list = cursor.fetchmany(aa)
        run_interface_num=0
        for rec in interface_list:
            case_list = []
            case_list.append(rec)
            interfaceTestTask(case_list,test_time,response_time,report_id)
            run_interface_num +=1
            AutotestplatTestplan.objects.filter(id=rec[2]).update(task_progress=run_interface_num,run_time=test_time)
        interfacepass=AutotestplatTestplanInterfaceResult.objects.filter(report_id=report_id).filter(result=0).count()
        interfaceall=len(interface_list)
        testcase_pass_pers = '{:.0%}'.format(interfacepass / interfaceall)
        AutotestplatTestplanInterfaceResult.objects.filter(report_id=report_id).update(pass_pers=testcase_pass_pers)
        cursor.close()
    except Exception:
        error_info = traceback.format_exc()
        print(error_info)
        return HttpResponse(error_info)

def interfaceTestTask(case_list,test_time,response_time,report_id):
    res_flags = []
    request_urls = []
    responses = []
    public_list = AutotestplatParameter.objects.filter()
    keyword_list = ["{"+rec.keywords+"}" for rec in public_list]
    public_list1 = AutotestplatParameter.objects.filter(Q(type='con'))
    keyword_list1 = ["{"+rec.keywords+"}" for rec in public_list1]
    public_dict1 = {}
    for rec in public_list1:
        public_dict1[rec.keywords] = rec.value
    public_list4 = AutotestplatParameter.objects.filter(Q(type='env'))
    keyword_list4 = ["{" + rec.keywords + "}" for rec in public_list4]
    public_dict4 = {}
    for rec in public_list4:
        public_dict4[rec.keywords] = rec.value
    public_list5 = AutotestplatParameter.objects.filter(Q(type='var'))
    keyword_list5 = ["{"+rec.keywords+"}" for rec in public_list5]
    public_dict5 = {}
    for rec in public_list5:
        public_dict5[rec.keywords] = rec.value
    public_list2 = AutotestplatParameter.objects.filter(Q(type='res'))
    keyword_list2 = ["{"+rec.keywords+"}" for rec in public_list2]
    public_dict2 = {}
    for rec in public_list2:
        public_dict2[rec.keywords] = str((rec.left,rec.right,rec.index))
    public_dict = {}
    public_dict.update(public_dict1)
    public_dict.update(public_dict2)
    public_dict.update(public_dict4)
    public_dict.update(public_dict5)

    for case in case_list:
        try:
            case_id = case[0]
            interface_name = case[1]
            suit_name = case[3]
            url = case[2]
            interface_mode = case[4]
            res_check = case[5]
            f_handler = open(logfile, 'w')
            f_handler.truncate()
            f_handler.close()
            print_log('cur_id: ',','),print_log(case_id)
            cur_interface = AutotestplatTestplanInterface.objects.filter(id=case_id)[0]
            cur_testplan = AutotestplatTestplan.objects.filter(id=cur_interface.suit_id)[0]
            host = cur_testplan.url_host
            try:
                if ("{" in host and "}" in host):
                    end_index = host.find("}")
                    key_url = host[:end_index + 1]
                    host = host.replace(key_url, public_dict[key_url.replace('{', '').replace('}', '').strip()])
            except:
                return HttpResponse('【ERROR】：url_host参数 ' + url_host + ' 有误，请重新修改 ')
            url = cur_interface.url
            try:
                if("{" in url and "}" in url):
                    end_index = url.find("}")
                    key_url = url[:end_index+1]
                    url = url.replace(key_url,public_dict[key_url.replace('{','').replace('}','')])
            except:
                return HttpResponse('【ERROR】：url参数 ' + url + ' 有误，请重新修改 ')
            url = host + url
            head = eval(cur_interface.head)
            for rec in head.keys():
                if(head[rec] in keyword_list1):
                    head[rec] = public_dict[head[rec].replace('{','').replace('}','')]
                elif (head[rec] in keyword_list4):
                    head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                elif (head[rec] in keyword_list5):
                    head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                    head[rec] = str(eval(head[rec]))
                elif(head[rec] in keyword_list2):
                    try:
                        head[rec] = cache.get(head[rec].replace('{','').replace('}',''))
                    except Exception:
                        error_info = traceback.format_exc()
                        print(error_info)
                        return HttpResponse('【ERROR】：参数 '+head[rec]+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+head[rec]+' 的前置接口，以及确认Redis是否已启动')
            body = eval(cur_interface.body)
            for rec in body.keys():
                if(isinstance(body[rec],str)):
                    for rec1 in keyword_list1:
                        if(rec1 in body[rec]):
                            body[rec] = body[rec].replace(rec1, public_dict[rec1.replace('{','').replace('}','')])
                    for rec5 in keyword_list5:
                        if (rec5 in body[rec]):
                            try:
                                body[rec] = body[rec].replace(rec5, public_dict[rec5.replace('{', '').replace('}', '')])
                                body[rec] = str(eval(body[rec]))
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                return HttpResponse('【ERROR】：参数 ' + rec5 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec5 + ' 的前置接口，以及确认Redis是否已启动')
                    for rec2 in keyword_list2:
                        if(rec2 in body[rec]):
                            try:
                                parares = cache.get(rec2.replace('{', '').replace('}', ''))
                                if parares == None:
                                    print_log('【ERROR】：参数 ' + rec2 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec2 + ' 的前置接口，以及确认Redis是否已启动')
                                else:
                                    body[rec] = body[rec].replace(rec2,cache.get(rec2.replace('{', '').replace('}', '')).decode('utf-8'))
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                    if('select' in body[rec]):
                        try:
                            sql = body[rec]
                            cursor = connection.cursor()
                            cursor.execute(sql)
                            data = cursor.fetchall()
                            print(u'查询的结果为： ',data[0][0])
                            body[rec] = data[0][0]
                        except Exception:
                            body[rec] = '【ERROR】：查询结果为空！'
            mode = cur_interface.mode
            body_format = cur_interface.body_format
            starttime = datetime.now()
            response,cookie = interface_test_start(url,body,head,mode,body_format,False)     #False，不打印日志；True，打印日志
            endtime = datetime.now()
            response_time = (endtime - starttime).total_seconds()
            update_cookie = cur_interface.update_cookie
            public_resp = AutotestplatParameter.objects.filter(module_id=int(case_id),type='res')
            if(str(public_resp) != '[]'):
                for rec in public_resp:
                    left = rec.left
                    right = rec.right
                    index = int(rec.index)
                    reg = left+'.+?'+right
                    result_all = re.findall(reg,response)
                    try:
                        result_tmp = result_all[index]
                        start = len(left)
                        end = len(result_tmp) - len(right)
                        result = result_tmp[start:end]
                        print(rec.keywords,'匹配结果为：',result)
                        cache.set(rec.keywords, result)
                        cache.expire(rec.keywords, 3600)
                    except Exception:
                        print((rec.keywords,left,right,index),' 在返回结果中未匹配到')
            is_new = cur_interface.assert_use_new
            if(is_new == '1'):
                assert_url = cur_interface.assert_url
                assert_head = eval(cur_interface.assert_head)
                for rec in assert_head.keys():
                    if(assert_head[rec] in keyword_list1):
                        assert_head[rec] = public_dict[assert_head[rec].replace('{','').replace('}','')]
                    elif(assert_head[rec] in keyword_list2):
                        try:
                            assert_head[rec] = cache.get(assert_head[rec].replace('{','').replace('}',''))
                        except Exception:
                            error_info = traceback.format_exc()
                            print(error_info)
                            return HttpResponse('【ERROR】：参数 '+assert_head[rec]+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+assert_head[rec]+' 的前置接口，以及确认Redis是否已启动')
                assert_mode = cur_interface.assert_mode
                assert_body = eval(cur_interface.assert_body)
                for rec in assert_body.keys():
                    if(isinstance(assert_body[rec],str)):
                        for rec1 in keyword_list1:
                            if(rec1 in assert_body[rec]):
                                assert_body[rec] = assert_body[rec].replace(rec1, public_dict[rec1.replace('{','').replace('}','')])
                        for rec2 in keyword_list2:
                            if(rec2 in assert_body[rec]):
                                try:
                                    assert_body[rec] = assert_body[rec].replace(rec2, cache.get(rec2.replace('{','').replace('}','')))
                                except Exception:
                                    error_info = traceback.format_exc()
                                    print(error_info)
                                    return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                        if('select' in assert_body[rec]):
                            try:
                                sql = assert_body[rec]
                                cursor = connection.cursor()
                                cursor.execute(sql)
                                data = cursor.fetchall()
                                print(u'查询的结果为： ',data[0][0])
                                assert_body[rec] = data[0][0]
                            except Exception:
                                assert_body[rec] = '【ERROR】：查询结果为空！'
                assert_keywords = cur_interface.assert_keywords
                for rec1 in keyword_list1:
                    if(rec1 in assert_keywords):
                        assert_keywords = assert_keywords.replace(rec1, public_dict[rec1.replace('{','').replace('}','')])
                for rec2 in keyword_list2:
                    if(rec2 in assert_keywords):
                        try:
                            assert_keywords = assert_keywords.replace(rec2, cache.get(rec2.replace('{','').replace('}','')))
                        except Exception:
                            error_info = traceback.format_exc()
                            print(error_info)
                            return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                if('select' in assert_keywords):
                    try:
                        sql = assert_keywords
                        cursor = connection.cursor()
                        cursor.execute(sql)
                        data = cursor.fetchall()
                        print(u'查询的结果为： ',data[0][0])
                        assert_keywords = data[0][0]
                    except Exception:
                        assert_keywords = '【ERROR】：查询结果为空！'
                is_contain = cur_interface.assert_keywords_is_contain
                assert_body_format = cur_interface.assert_body_format
                result1 = assert_test(assert_url,assert_head,assert_mode,assert_body,assert_keywords,is_contain,assert_body_format,True)
                time.sleep(0.1)
            else:
                assert_keywords_old = cur_interface.assert_keywords_old
                for rec1 in keyword_list1:
                    if(rec1 in assert_keywords_old):
                        assert_keywords_old = assert_keywords_old.replace(rec1, public_dict[rec1.replace('{','').replace('}','')])
                for rec2 in keyword_list2:
                    if(rec2 in assert_keywords_old):
                        try:
                            assert_keywords_old = assert_keywords_old.replace(rec2, cache.get(rec2.replace('{','').replace('}','')))
                        except Exception:
                            return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                if('select' in assert_keywords_old):
                    try:
                        sql = assert_keywords_old
                        cursor = connection.cursor()
                        cursor.execute(sql)
                        data = cursor.fetchall()
                        print(u'查询的结果为： ',data[0][0])
                        assert_keywords_old = data[0][0]
                    except Exception:
                        assert_keywords_old = '【ERROR】：查询结果为空！'
                result1 = assert_test_old(response,assert_keywords_old,True)
            suit_id1 = cur_interface.suit_id
            suit_name1 = cur_interface.suit_name
            product_id = cur_testplan.product_id
            product_name = AutotestplatProduct.objects.filter(id=product_id).first().product_name
            result_info = AutotestplatTestplanInterfaceResult(report_id=report_id,product_id=product_id,product_name=product_name,suit_id=suit_id1,suit_name=suit_name1,suit_interface_id=case_id,interface_name=interface_name,url=url,body=body,mode=mode,assert_keywords_old=assert_keywords_old,response_time=response_time,task_mode="定时任务",response=response,result=result1,date_time=test_time)
            result_info.save()
            return result1
        except Exception:
            error_info = traceback.format_exc()
            print(error_info)
            return HttpResponse(error_info)


