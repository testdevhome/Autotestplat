# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.0
############################################
import re,os,time,json,traceback,requests,autotest
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render
from django.http import JsonResponse, HttpResponse
from django.db import connection
from Autotestplat.celery import app
from .models import *
from django.core.cache import cache
from django.db.models import Q
from djcelery.models import PeriodicTask, CrontabSchedule, IntervalSchedule
from .views_interface import print_log, interface_test_start, assert_test_old,cache

current_dir = os.getcwd()
logfile = os.path.join(current_dir, 'autotest', 'test_out.log')
session = requests.Session()

def periodictaskView(request):
    '''
    :return:
    auther: fin
    '''
    return render(request, "periodic_task.html")

def runPeriodictask(request,suit_id):
    '''
    :return:
    auther: fin
    '''
    runtask = 'api_autotest_task'+'('+str(suit_id.split('-')[0])+')'
    print(runtask)
    eval(runtask)
    return HttpResponse("运行完成。  该测试计划为：" + str(suit_id) + " 请在测试报告中查看此时间点的测试结果 ")

def periodic_task(request):
    task_list = PeriodicTask.objects.all()
    periodic_list = IntervalSchedule.objects.all()
    crontab_list = CrontabSchedule.objects.all()
    obj_count = len(task_list)
    obj_perpage = 10
    pagetag_current = request.GET.get('page', 1)
    pagetag_dsp_count = 5
    paginator = autotest.models.PaginatorTask(obj_count, obj_perpage, pagetag_current, pagetag_dsp_count)
    task_list = task_list[paginator.obj_slice_start:paginator.obj_slice_end]
    return render(request, "periodic_task.html", {"tasks": task_list,"periodics": periodic_list,"crontabs": crontab_list,'paginator':paginator })

def task_open(request,id):
    '''
    :return:
    auther: fin
    '''
    task = PeriodicTask.objects.get(id=id)
    sql = "UPDATE djcelery_periodictask set djcelery_periodictask.enabled=%s where djcelery_periodictask.id=%s;"
    if(task.enabled == 1):
        param = (0, id)
        cursor = connection.cursor()
        cursor.execute(sql, param)
        return HttpResponse("已停止  "+str(task.id)+"  "+task.name+"  任务")
    else:
        param = (1, id)
        cursor = connection.cursor()
        cursor.execute(sql, param)
        return HttpResponse("开启  "+str(task.id)+"  "+task.name+"  任务")
    cursor.close()

@csrf_exempt
def loadPeriodicTask(request):
    '''
    :return:
    auther: fin
    '''
    items = PeriodicTask.objects.all().values_list().order_by('-id')
    rst = []
    for item in items:
        id = item[4]
        runtime_year = datetime.now().year
        runtime_month = CrontabSchedule.objects.filter(id=id).values_list()[0][5]
        runtime_day = CrontabSchedule.objects.filter(id=id).values_list()[0][4]
        runtime_hour = CrontabSchedule.objects.filter(id=id).values_list()[0][2]
        runtime_min = CrontabSchedule.objects.filter(id=id).values_list()[0][1]
        runtime = str(runtime_year)+'-'+runtime_month+'-'+runtime_day+' '+runtime_hour+':'+runtime_min
        item=item[:3] +(runtime,)+item[4:]
        arr = []
        for j in item:
            arr.append(j)
        rst.append(arr)
    realRst = {'data': rst}
    return JsonResponse(realRst)

@csrf_exempt
def loadOptions(request):
    '''
    :return:
    auther: fin
    '''
    suit_ids = []
    ids = AutotestplatTestplan.objects.filter().values('id').order_by('id').distinct()
    for id in ids:
        name=AutotestplatTestplan.objects.filter(id=id['id']).values('suit_name')
        suitname=name[0]['suit_name']
        suit_ids.append(str(id['id'])+'-'+suitname)
    rst = [suit_ids]
    return JsonResponse(rst, safe=False)

def tasksearch(request):
    '''
    :return:
    auther: fin
    '''
    key_words_task = request.GET.get("key_words_task", "")
    key_words_name = request.GET.get('key_words_name', '')
    task_list = PeriodicTask.objects.filter(Q(name__icontains=key_words_name))
    print(task_list)
    periodic_list = IntervalSchedule.objects.all()
    crontab_list = CrontabSchedule.objects.all()
    obj_count = len(task_list)
    obj_perpage = 10
    pagetag_current = request.GET.get('page', 1)
    pagetag_dsp_count = 5
    paginator = autotest.models.PaginatorTask(obj_count, obj_perpage, pagetag_current, pagetag_dsp_count)
    task_list = task_list[paginator.obj_slice_start:paginator.obj_slice_end]
    return render(request,'periodic_task.html', {"tasks": task_list,"periodics": periodic_list,"crontabs": crontab_list,'paginator':paginator})

@csrf_exempt
def addPeriodictask(request):
    '''
    :return:
    auther: fin
    '''
    name = request.POST.get('name')
    task = 'api_autotest_task'
    crontab = request.POST.get('crontab_id')
    year = crontab.split('-')[0]
    month = crontab.split('-')[1]
    day = crontab.split('-')[2].split(' ')[0]
    hour = crontab.split(':')[0].split(' ')[1]
    min = crontab.split(':')[1]
    CrontabSchedule.objects.create(month_of_year=month, day_of_month=day, hour=hour, minute=min, day_of_week='*')
    crontab_id = CrontabSchedule.objects.order_by('-id').first().id
    args = request.POST.get('args')
    description = request.POST.get('description')
    interval_id = '3'
    enabled = request.POST.get('enabled')
    name_exist = PeriodicTask.objects.filter(name=name).first()
    if name_exist:
        return HttpResponse(f'定时任务"{name}"已存在，请重新填写')
    PeriodicTask.objects.create(name=name, task=task, args=args,crontab_id=crontab_id, interval_id=interval_id, enabled=enabled, description=description)
    return HttpResponse('200')

@csrf_exempt
def deletePeriodictask(request):
    '''
    :return:
    auther: fin
    '''
    id = request.POST.get('id')
    PeriodicTask.objects.filter(id=id).delete()
    return HttpResponse('200')

@csrf_exempt
def updatePeriodictask(request):
    '''
    :return:
    auther: fin
    '''
    id = request.POST.get('id')
    name = request.POST.get('name')
    crontab = request.POST.get('crontab_id')
    year = crontab.split('-')[0]
    month = crontab.split('-')[1]
    day = crontab.split('-')[2].split(' ')[0]
    hour = crontab.split(':')[0].split(' ')[1]
    min = crontab.split(':')[1]
    crontabid=PeriodicTask.objects.filter(id=id).first().crontab_id
    CrontabSchedule.objects.filter(id=crontabid).update(month_of_year=month, day_of_month=day, hour=hour, minute=min, day_of_week='*')
    args = request.POST.get('args')
    description = request.POST.get('description')
    enabled = request.POST.get('enabled')
    if PeriodicTask.objects.exclude(id=id).filter(name=name).exists():
        return HttpResponse(f'定时任务”{name}“已存在，请重新填写')
    PeriodicTask.objects.filter(id=id).update(name=name,args=args,description=description,enabled=enabled)
    return HttpResponse('200')

@app.task
def hello_world(suit_id):
    print('测试 periodic task!'+str(suit_id))

test_time = ''
response_time = ''
@app.task
def api_autotest_task(suit_id):
    '''
    :return:
    auther: fin
    '''
    try:
        global test_time
        global response_time
        test_time = time.strftime("%Y-%m-%d %H:%M:%S")
        sql = "select t3.interface_id,t2.interface_name,t2.suit_id,t2.suit_name,t2.mode,t2.url,t2.body,t2.assert_keywords_old from autotestplat_testplan t1 INNER JOIN autotestplat_testplan_interface t2 on t1.id=t2.suit_id INNER JOIN autotestplat_testplan_interface_order t3 on t2.suit_id=t3.suit_id and t2.id=t3.interface_id where t2.suit_id="+str(suit_id)+" order by t1.product_id"
        cursor = connection.cursor()
        aa = cursor.execute(sql)
        interface_list = cursor.fetchmany(aa)
        print(interface_list)
        for rec in interface_list:
            case_list = []
            case_list.append(rec)
            result=interfaceTestTask(case_list,test_time,response_time)
        cursor.close()
    except Exception:
        error_info = traceback.format_exc()
        print(error_info)
        return HttpResponse(error_info)

def interfaceTestTask(case_list,test_time,response_time):
    res_flags = []
    request_urls = []
    responses = []

    #==公共参数 - keyword
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
                                body[rec] = body[rec].replace(rec2, cache.get(rec2.replace('{','').replace('}','')).decode('utf-8'))
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
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
                        print(sql)
                        cursor.execute(sql)
                        data = cursor.fetchall()
                        print(u'查询的结果为： ',data[0][0])
                        assert_keywords_old = data[0][0]
                    except Exception:
                        assert_keywords_old = '【ERROR】：查询结果为空！'
                result1 = assert_test_old(response,assert_keywords_old,True)
            suit_id1 = cur_interface.suit_id
            result_info = AutotestplatTestplanInterfaceResult(suit_id=suit_id1,suit_interface_id=case_id,response_time=response_time,mode="定时任务",response=response,result=result1,date_time=test_time)
            result_info.save()
            return result1
        except Exception:
            error_info = traceback.format_exc()
            print(error_info)
            return HttpResponse(error_info)

# def readRes(res, res_check):
#     res = res.decode().replace('":"', "=").replace('":', "=")
#     res_check = res_check.split(';')
#     for s in res_check:
#         if s in res:
#             pass
#         else:
#             return '错误，返回参数和预期结果不一致' + s
#     return 'pass'

