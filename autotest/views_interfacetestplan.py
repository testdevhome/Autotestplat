# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.0
############################################
import json,traceback,re,copy,os,requests,random,time,string
from django.shortcuts import render_to_response
from django.db import connection
from django.db.models import Q
from django.db.models import Max
from django.core.cache import cache
from django.template.context_processors import csrf
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from faker import Faker
from .models import *
from datetime import datetime
from django.http import HttpResponse
from .views_interface import cache,print_log,interface_test_start, assert_test_old

current_dir = os.getcwd()
logfile = os.path.join(current_dir, 'autotest', 'test_out.log')
codefile= os.path.join(current_dir, 'autotest', 'code.jpg')
session = requests.Session()

def interface_testplan(req):
    suits = AutotestplatTestplan.objects.all().order_by('-id')
    interfaces_all = AutotestplatInterfaceTestcase.objects.all().order_by('-product_name','id')
    env_para = AutotestplatParameter.objects.filter(type="env")
    product_all = AutotestplatProduct.objects.all()
    new_suits = []
    for id in suits:
        product = AutotestplatProduct.objects.filter(id=id.product_id).first()
        if product:
            new_id = id
            new_id.product_id = product.product_name
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
    c.update({'page_list': page_list,'num': num, 'interfaces_all':interfaces_all,'env_paras':env_para,'product_alls':product_all})
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
        suit_info1 = AutotestplatTestplan(suit_name=suit_list[0],url_host=suit_list[1],charger=suit_list[2],product_id=product_id,interface_name=interfaces,interface_name_display=interfaces1)
        suit_info1.save()

        suit_id1 = AutotestplatTestplan.objects.order_by('-id')[0].id
        suit_name1 = AutotestplatTestplan.objects.filter(id=suit_id1).first().suit_name
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
                                                       interface_name=interface_name1, url=url1,
                                                       body_format=body_format[0], body=formated_dict[0], mode=mode1[0],
                                                       update_cookie=update_cookie1[0], head=head1[0],
                                                       assert_keywords_is_contain=assert_keywords_is_contain1,
                                                       assert_use_new=assert_use_new1,
                                                       assert_keywords_old=assert_keywords_old1)
            para_suit_info.save()
            print(para_suit_info, ' insert interface success!')
            max_id = AutotestplatTestplanInterface.objects.order_by('-id')[0].id
            print('max_id = ', max_id)
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
                                                       index=resp_edit_index, product_name='testplan',
                                                       module_id=max_id, type='res')
                resp_info1.save()
            testplan_interface_order_info = AutotestplatTestplanInterfaceOrder(suit_id=suit_id1,interface_id=max_id)
            testplan_interface_order_info.save()
        AutotestplatTestplan.objects.filter(id=suit_id1).update(interface_name=interface_name_list)
        return HttpResponse('insert success!')

def del_testplan(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        id1 = raw_data['id1']
        testplanApis = AutotestplatTestplanInterface.objects.filter(suit_id=id1).all()
        for testplanApi in testplanApis:
            AutotestplatParameter.objects.filter(module_id=testplanApi.id, product_name='testplan').delete()
        AutotestplatTestplanInterface.objects.filter(suit_id=id1).delete()
        AutotestplatTestplan.objects.filter(id=id1).delete()
        AutotestplatTestplanInterfaceOrder.objects.filter(suit_id=id1).delete()
        return HttpResponse('delete success!')

def search_testplan(req):
    key_words_suit = req.GET.get('key_words_suit','')
    key_words_name = req.GET.get('key_words_name','')
    key_words_charger = req.GET.get('key_words_charger','')
    key_words_product_id = req.GET.get('key_words_product_id', '')
    interfaces_all = AutotestplatInterfaceTestcase.objects.all().order_by('-product_name','order')
    try:
        product_id = AutotestplatProduct.objects.filter(product_name=key_words_product_id).first().id
        suits = AutotestplatTestplan.objects.filter(Q(suit_name__icontains=key_words_suit),Q(product_id__icontains=product_id),Q(interface_name__icontains=key_words_name),Q(charger__icontains=key_words_charger)).order_by('id')
        new_suits = []
        for id in suits:
            product = AutotestplatProduct.objects.filter(id=id.product_id).first()
            if product:
                new_id = id
                new_id.product_id = product.product_name
                new_suits.append(new_id)
    except:
        suits = AutotestplatTestplan.objects.all().order_by('id')
        new_suits = suits
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
        for index, id2 in enumerate(id_list):
            if index == len(id_list) - 1:
                names = AutotestplatTestplanInterface.objects.filter(id=id2).first().interface_name
                interface_names += "testplan_interface_"+str(id2)+"_"+names
            else:
                names = AutotestplatTestplanInterface.objects.filter(id=id2).first().interface_name
                interface_names += "testplan_interface_" + str(id2) + "_" + names + ","
        suit_info.product_id = AutotestplatProduct.objects.filter(id=suit_info.product_id).first().product_name
        suit_info1 = {'id1':id1,
                      'suit_name':suit_info.suit_name,
                      'url_host':suit_info.url_host,
                      'id_list': id_list,
                      'interface_name':interface_names,
                      'charger':suit_info.charger,
                      'product_id':suit_info.product_id,}
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
            AutotestplatParameter.objects.filter(module_id=del_id,product_name='testplan').delete()
        return HttpResponse('delete success!')

#==保存测试计划
def save_edit_testplan(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        suit_info = raw_data['suit_info']
        interfaces = ''
        interfaces1 = ''
        interface_list = suit_info[4]
        id_list_final = []
        L = len(interface_list)
        for i in range(L):
            tmp_name1 = interface_list[i]
            if(tmp_name1.startswith('testplan_interface') == True):
                name1 = interface_list[i].split('_')[3]
                id1 = interface_list[i].split('_')[2]
                id_list_final.append(id1)
            else:
                print(interface_list[i])
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
        product_id = AutotestplatProduct.objects.filter(product_name=suit_info[5]).first().id
        suit_status1 = AutotestplatTestplan.objects.filter(id=suit_info[0]).update(suit_name=suit_info[1],interface_name=interfaces,url_host=suit_info[2], interface_name_display=interfaces1,charger=suit_info[3],product_id=product_id)
        tmp_list = AutotestplatTestplanInterface.objects.filter(suit_id=suit_info[0])
        for rec in tmp_list:
            interface_status1 = AutotestplatTestplanInterface.objects.filter(id=rec.id).update(suit_name=suit_info[1])
            print(interface_status1,' update success!')
            if(str(rec.id) not in id_list_final):
                AutotestplatTestplanInterface.objects.filter(id=rec.id).delete()
                AutotestplatParameter.objects.filter(module_id=rec.id,product_name='testplan').delete()
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
                para_suit_info = AutotestplatTestplanInterface(suit_id=suit_id1, suit_name=suit_name1,
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
                                                           index=resp_edit_index, product_name='testplan',
                                                           module_id=max_id, type='res')
                    resp_info1.save()
        for interface_id in id_list:
            testplan_interface_order_info = AutotestplatTestplanInterfaceOrder(suit_id=suit_info[0], interface_id=interface_id)
            testplan_interface_order_info.save()
        interfaces=AutotestplatTestplanInterface.objects.filter(suit_id=suit_info[0]).values_list()
        interface_name_list=''
        for index,interface in enumerate(interfaces):
            if index == len(interfaces) - 1:
                interfaceid = interface[0]
                interfacename = interface[3]
                interface_name_list += 'testplan_interface_' + str(interfaceid) + '_' + interfacename
            else:
                interfaceid = interface[0]
                interfacename = interface[3]
                interface_name_list += 'testplan_interface_' + str(interfaceid) + '_' + interfacename + ','
        AutotestplatTestplan.objects.filter(id=suit_info[0]).update(interface_name=interface_name_list)
        return HttpResponse('update_use_status success!')

def show_edit_testplan_interface(req,para):
    if req.method == "GET":
        table_name = para.split('_')[0]
        id1 = para.split('_')[1]
        id2 = para.split('_')[2]
        flag_resp = 'false'
        if(id2 == ''):
            try:
                body_format = AutotestplatInterfaceTestcase.objects.filter(id=id1)[0].body_format
                if(body_format == ''):
                    body_format = 'false'
                para1 = AutotestplatInterfaceTestcase.objects.filter(id=id1)[0].body
                mode1 = AutotestplatInterfaceTestcase.objects.filter(id=id1)[0].mode
                head1 = AutotestplatInterfaceTestcase.objects.filter(id=id1)[0].head
                assert_keywords_old1 = AutotestplatInterfaceTestcase.objects.filter(id=id1)[0].assert_keywords_old
                url1 = AutotestplatInterfaceTestcase.objects.filter(id=id1)[0].url
                public_list_resp = AutotestplatParameter.objects.filter(module_id=int(id1)).exclude(product_name='suit')
                if(list(public_list_resp) != []):
                    flag_resp = 'true'
            except Exception:
                return HttpResponse('您未选择任何接口，请先选择接口！')
        elif(id2 != ''):
            body_format = AutotestplatTestplanInterface.objects.filter(id=id2)[0].body_format
            if(body_format == ''):
                body_format = 'false'
            para1 = AutotestplatTestplanInterface.objects.filter(id=id2)[0].body
            mode1 = AutotestplatTestplanInterface.objects.filter(id=id2)[0].mode
            head1 = AutotestplatTestplanInterface.objects.filter(id=id2)[0].head
            assert_keywords_old1 = AutotestplatTestplanInterface.objects.filter(id=id2)[0].assert_keywords_old
            url1 = AutotestplatTestplanInterface.objects.filter(id=id2)[0].url
            public_list_resp = AutotestplatParameter.objects.filter(module_id=int(id2))
            if(list(public_list_resp) != []):
                flag_resp = 'true'
        if(mode1 == ''):
            mode1 = 'false'
        head1 = eval(head1)
        tmp_head = {'Accept':'','Content-Type':'','Cookie':''}
        tmp = ['Accept','Content-Type','Cookie']
        for rec in list(head1.keys()):
            if(rec not in tmp):
                tmp.append(rec)
        for rec in tmp:
            if(rec in list(head1.keys())):
                tmp_head[rec] = head1[rec]
        interface_list1 = {'id1': id1,
                           'para_dict': json.dumps(eval(para1), sort_keys=True).encode().decode('raw_unicode_escape'),    # 显示中文，只适用于json
                           'para_str': json.dumps(eval(para1), sort_keys=True, indent=8).encode().decode('raw_unicode_escape'),   # 显示中文，只适用于json
                           'head': json.dumps(tmp_head, sort_keys=True, indent=8).encode().decode('raw_unicode_escape'),     # 显示中文，只适用于json
                           'url': url1,
                           'assert_keywords_old':assert_keywords_old1
                           }
        public_list_all = AutotestplatParameter.objects.filter(Q(type='con')|Q(type='var')|Q(type='testplan'))
        c = csrf(req)
        c.update({'id1': interface_list1['id1'],'para_dict': interface_list1['para_dict'],'para_str': interface_list1['para_str'],'head': interface_list1['head'],'assert_keywords_old':interface_list1['assert_keywords_old'],'mode': mode1,'body_format': body_format,'url': interface_list1['url'],'public_list_all': public_list_all,'flag_resp': flag_resp,'public_list_resp': public_list_resp})
        return render_to_response("interface_testplan_edit.html",c)

def save_edit_testplan_para(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        para_info = raw_data['para_info']
        resp_info = raw_data['resp_info']
        formated_dict = para_info[2]
        formated_dict = formated_dict.replace('null','None')
        mode1 = para_info[3]
        head1 = eval(para_info[4])
        url1 = para_info[7]
        body_format = para_info[8]
        assert_keywords_old1 = para_info[9]
        id1 = para_info[0]
        if(id1 != 'new'):
            interface_head = para_info[6]
            interface_name1 = interface_head.split('_')[3]
            update_status1 = AutotestplatTestplanInterface.objects.filter(id=id1).update(interface_name=interface_name1,body=formated_dict,mode=mode1,head=head1,url=url1,body_format=body_format,assert_keywords_old=assert_keywords_old1)
            if(resp_info != []):
                resp_edit_name = resp_info[0]
                resp_edit_keywords = resp_info[1]
                resp_edit_left = resp_info[2]
                resp_edit_right = resp_info[3]
                resp_edit_index = resp_info[4]
                for i in range(len(resp_edit_name)):
                    AutotestplatParameter.objects.filter(module_id=id1).update(name=resp_edit_name[i],keywords=resp_edit_keywords[i],value='',left=resp_edit_left[i],right=resp_edit_right[i],index=resp_edit_index[i],product_name="testplan",type='res')
            current_interface = AutotestplatTestplanInterface.objects.filter(id=id1)[0]
            interface_name2 = 'testplan_interface_' + str(id1) + '_' + current_interface.interface_name
            interface_list = {'id': current_interface.id,
                              'suit_id': current_interface.suit_id,
                              'suit_name': current_interface.suit_name,
                              'interface_name': interface_name2,
                              'url_host': current_interface.url_host,
                              'head': current_interface.head,
                              'body': current_interface.body,
                              'mode': current_interface.mode,
                              'assert_keywords_old':current_interface.assert_keywords_old,
                              'update_cookie': current_interface.update_cookie}
        else:
            suit_head = para_info[5]
            suit_id1 = suit_head.split('_')[0]
            suit_name1 = suit_head.split('_')[1]
            interface_head = para_info[6]
            table_name = interface_head.split('_')[0]
            id_new = interface_head.split('_')[1]
            interface_id = interface_head.split('_')[1]
            interface_name1 = interface_head.split('_')[2]
            url1 = AutotestplatInterfaceTestcase.objects.filter(id=interface_id)[0].url
            assert_use_new1 = AutotestplatInterfaceTestcase.objects.filter(id=id_new)[0].assert_use_new
            assert_keywords_is_contain1 = AutotestplatInterfaceTestcase.objects.filter(id=id_new)[0].assert_keywords_is_contain
            para_suit_info = AutotestplatTestplanInterface(suit_id=suit_id1,suit_name=suit_name1,interface_name=interface_name1,url=url1,body_format=body_format,body=formated_dict,mode=mode1,head=head1,assert_keywords_is_contain=assert_keywords_is_contain1,assert_use_new=assert_use_new1,assert_keywords_old=assert_keywords_old1)
            para_suit_info.save()
            productid = AutotestplatTestplan.objects.filter(id=suit_id1).first().product_id
            productname = AutotestplatProduct.objects.filter(id=productid).first().product_name
            if(resp_info != []):
                resp_edit_name = resp_info[0]
                resp_edit_keywords = resp_info[1]
                resp_edit_left = resp_info[2]
                resp_edit_right = resp_info[3]
                resp_edit_index = resp_info[4]
                tmp_list = AutotestplatTestplanInterface.objects.aggregate(Max('id'))
                max_id = tmp_list['id__max']
                for i in range(len(resp_edit_name)):
                    resp_info1 = AutotestplatParameter(name=resp_edit_name[i],keywords=resp_edit_keywords[i],value='',left=resp_edit_left[i],right=resp_edit_right[i],index=resp_edit_index[i],product_name="testplan",module_id=max_id,type='res')
                    resp_info1.save()
            max_id = AutotestplatTestplanInterface.objects.order_by('-id')[0].id
            current_interface = AutotestplatTestplanInterface.objects.filter(id=max_id)[0]
            interface_name2 = 'testplan_interface_' + str(max_id) + '_'  + current_interface.interface_name
            interface_list = {'id': current_interface.id,
                              'suit_id': current_interface.suit_id,
                              'suit_name': current_interface.suit_name,
                              'interface_name': interface_name2,
                              'head': current_interface.head,
                              'body': current_interface.body,
                              'mode': current_interface.mode,
                              'assert_keywords_old':current_interface.assert_keywords_old,
                              'update_cookie': current_interface.update_cookie}
        return HttpResponse(json.dumps(interface_list), content_type='application/json')


test_time = ''
response_time = ''
def start_interface_testplan(request):
    if request.method == "POST":
        try:
            raw_data = request.body
            raw_data = json.loads(raw_data)
            cur_id = raw_data['cur_id']
            global test_time
            global response_time
            now = datetime.now()
            present_time1 = now.strftime("%Y-%m-%d %H:%M:%S")
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
            url = cur_interface.url
            try:
                if("{" in url and "}" in url):
                    end_index = url.find("}")
                    key_url = url[:end_index+1]
                    url = url.replace(key_url,public_dict[key_url.replace('{','').replace('}','')])
            except:
                return HttpResponse('【ERROR】：url参数 ' + url + ' 有误，请重新修改 ')
            url = host+url
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
                        return HttpResponse('【ERROR】：参数 '+head[rec]+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+head[rec]+' 的前置接口，以及确认Redis是否已启动')
            is_login_api = False
            n = 0
            while (n < 5):
                body = eval(cur_interface.body)
                for rec in body.keys():
                    if(isinstance(body[rec],str)):
                        for rec1 in keyword_list1:
                            if(rec1 in body[rec]):
                                if('captcha' not in rec1):
                                    body[rec] = body[rec].replace(rec1, public_dict[rec1.replace('{','').replace('}','')])
                                else:
                                    is_login_api = True
                                    yanzheng_url = public_dict[rec1.replace('{','').replace('}','')]
                                    haha = request_get(yanzheng_url,{},{},0)
                                    with open(codefile,'wb') as f:
                                        f.write(haha.content)
                                    yanzheng = getcaptcha()
                                    body[rec] = yanzheng
                                    print_log('【登录验证码】：',','),print_log(yanzheng)
                        for rec5 in keyword_list5:
                            if (rec5 in body[rec]):
                                try:
                                    body[rec] = body[rec].replace(rec5,public_dict[rec5.replace('{', '').replace('}', '')])
                                    body[rec] = str(eval(body[rec]))
                                except Exception:
                                    error_info = traceback.format_exc()
                                    print(error_info)
                                    return HttpResponse('【ERROR】：参数 ' + rec5 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec5 + ' 的前置接口，以及确认Redis是否已启动')
                        for rec2 in keyword_list2:
                            if(rec2 in body[rec]):
                                try:
                                    body[rec] = body[rec].replace(rec2, cache.get(rec2.replace('{','').replace('}','')).decode('utf-8'))
                                except Exception:
                                    error_info = traceback.format_exc()
                                    print(error_info)
                                    return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                        for rec3 in keyword_list3:
                            if(rec3 in body[rec]):
                                para = copy.deepcopy(body)
                                body[rec] = sign_nb(para)
                        if('select' in body[rec]):
                            try:
                                sql = body[rec]
                                cursor = connection.cursor()
                                print(sql)
                                cursor.execute(sql)
                                data = cursor.fetchall()
                                print(u'查询的结果为： ',data[0][0])
                                body[rec] = data[0][0]
                            except Exception:
                                body[rec] = '【ERROR】：查询结果为空！'
                mode = cur_interface.mode
                body_format = cur_interface.body_format
                starttime = datetime.now()
                response,cookie = interface_test_start(url,body,head,mode,body_format,True)
                endtime = datetime.now()
                response_time = (endtime - starttime).total_seconds()
                update_cookie = cur_interface.update_cookie
                public_resp = AutotestplatParameter.objects.filter(module_id=int(cur_id))
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
                                        assert_body[rec] = assert_body[rec].replace(rec2, cache.get(rec2.replace('{','').replace('}','')).decode('utf-8'))
                                    except Exception:
                                        error_info = traceback.format_exc()
                                        print(error_info)
                                        return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                            for rec3 in keyword_list3:
                                if(rec3 in assert_body[rec]):
                                    para = copy.deepcopy(assert_body)
                                    assert_body[rec] = sign_nb(para)
                            if('select' in assert_body[rec]):
                                try:
                                    sql = assert_body[rec]
                                    cursor = connection.cursor()
                                    print(sql)
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
                                assert_keywords = assert_keywords.replace(rec2, cache.get(rec2.replace('{','').replace('}','')).decode('utf-8'))
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                    if('select' in assert_keywords):
                        try:
                            sql = assert_keywords
                            cursor = connection.cursor()
                            print(sql)
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
                                assert_keywords_old = assert_keywords_old.replace(rec2, cache.get(rec2.replace('{','').replace('}','')).decode('utf-8'))
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                    if('select' in assert_keywords_old):
                        try:
                            sql = assert_keywords_old
                            cursor = connection.cursor()
                            print(sql)
                            cursor.execute(sql)
                            data = cursor.fetchall()
                            print(u'查询的结果为： ',data[0][0])
                            assert_keywords_old = data[0][0]
                        except Exception:
                            assert_keywords_old = '【ERROR】：查询结果为空！'
                    result1 = assert_test_old(response,assert_keywords_old,True)
                if(is_login_api == True):
                    if(result1 != 0):
                        n += 1
                    elif(result1 == 0):
                        break
                else:
                    break
            suit_id1 = cur_interface.suit_id
            result_info = AutotestplatTestplanInterfaceResult(suit_id=suit_id1,suit_interface_id=cur_id,response_time=response_time,mode="手工执行",response=response,result=result1,date_time=test_time)
            result_info.save()
            File = logfile
            File1 = open(File,'r',encoding='utf-8')
            test_log = File1.readlines()
            test_log = str(test_log)
            test_log = test_log.replace('<','[').replace('>',"]")
            test_log = eval(test_log)
            return HttpResponse(test_log)
        except Exception:
            error_info = traceback.format_exc()
            print(error_info)
            return HttpResponse(error_info)
