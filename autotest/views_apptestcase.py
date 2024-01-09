# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V4.0
############################################
import time,json,pymysql
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render
from django.http import JsonResponse, HttpResponse
from django.db.models import Count
from django.db.models import Q
from time import sleep
from appium import webdriver
from appium.webdriver.common.touch_action import TouchAction
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from django.template.context_processors import csrf
from django.shortcuts import render_to_response
from .models import *
import uiautomator2 as u2

appium_version=4

def getAppView(request):
    user_name = request.session.get('user', '')
    product_all = AutotestplatProduct.objects.filter(delete_flag='N')
    product_id = AuthUser.objects.filter(username=user_name).first().last_name
    product_name = AutotestplatProduct.objects.filter(id=product_id).first().product_name
    c = csrf(request)
    c.update({"product_name":product_name,"product_alls":product_all})
    return render_to_response("app_testcase.html",c)

@csrf_exempt
def loadAppTestcaseTable(request):
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        items = AutotestplatAppTestcase.objects.all().values_list('app_testcase_code','app_testcase_name','app_testcase_result','tester','run_time','product_id','delete_flag','app_testcase_code_order').annotate(Count('id')).order_by('app_testcase_code_order')
    else:
        user_product_id = AuthUser.objects.filter(username=username).first().last_name
        if user_product_id:
            items = AutotestplatAppTestcase.objects.filter(Q(product_id=user_product_id)).values_list('app_testcase_code', 'app_testcase_name',
                                                                      'app_testcase_result', 'tester', 'run_time',
                                                                      'product_id', 'delete_flag','app_testcase_code_order').annotate(Count('id')).order_by('app_testcase_code_order')
        else:
            items = AutotestplatAppTestcase.objects.all().values_list('app_testcase_code', 'app_testcase_name',
                                                                      'app_testcase_result', 'tester', 'run_time',
                                                                      'product_id', 'delete_flag','app_testcase_code_order').annotate(Count('id')).order_by('app_testcase_code_order')
    rst = []
    for item in items:
        arr = []
        tmp_ids = AutotestplatProduct.objects.all().values_list().order_by('id')
        tmp = []
        for tmp_id in tmp_ids:
            tmp.append(tmp_id[0])
        if (item[5] == None):
            count = 0
        else:
            count = tmp.count(int(item[5]))
        if count > 0:
            product_name = AutotestplatProduct.objects.filter(id=int(item[5])).first().product_name
            item_list = list(item)
            item_list[5] = product_name
            item = tuple(item_list)
        for j in item:
            arr.append(j)
        rst.append(arr)
    realRst = {'data': rst}
    return JsonResponse(realRst)

@csrf_exempt
def addApptestcase(request):
    app_testcase_code = str(int(time.time()))
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        product_id = ''
    else:
        product_id = AuthUser.objects.filter(username=username).first().last_name
    app_testcase_result = '未执行'
    create_time = str(time.strftime("%Y-%m-%d %H:%M:%S"))
    app_testcase_name = request.POST.get('app_testcase_name')
    app_testcase_step = request.POST.getlist('caseStepList[]')
    app_testcase_objname = request.POST.getlist('caseStepList_objname[]')
    app_testcase_findmethod = request.POST.getlist('caseStepList_findmethod[]')
    app_testcase_evelement = request.POST.getlist('caseStepList_evelement[]')
    app_testcase_optmethod = request.POST.getlist('caseStepList_optmethod[]')
    app_testcase_testdata = request.POST.getlist('caseStepList_testdata[]')
    app_testcase_assertdata = request.POST.getlist('caseStepList_assertdata[]')
    app_testcase_stepresult = request.POST.getlist('caseStepList_stepresult[]')
    delete_flag = 'N'
    max_id = AutotestplatAppTestcase.objects.order_by('-app_testcase_code_order')[0].app_testcase_code_order
    if max_id=='' or max_id==None:
        max_id=1
    else:
        max_id = max_id+1
    print(app_testcase_step)
    for i in range(len(app_testcase_step)):
       id = str(datetime.now().strftime("%Y%m%d%H%M%S%f"))
       testcase_step = app_testcase_step[i]
       testcase_objname = app_testcase_objname[i]
       testcase_findmethod = app_testcase_findmethod[i]
       testcase_evelement = app_testcase_evelement[i]
       testcase_optmethod = app_testcase_optmethod[i]
       testcase_testdata = app_testcase_testdata[i]
       testcase_assertdata = app_testcase_assertdata[i]
       testcase_stepresult = app_testcase_stepresult[i]
       time.sleep(2)
       AutotestplatAppTestcase.objects.create(id=id, app_testcase_code=app_testcase_code,app_testcase_name=app_testcase_name,app_testcase_result=app_testcase_result,tester=username,product_id=product_id,app_testcase_step=testcase_step,app_testcase_objname=testcase_objname,app_testcase_findmethod=testcase_findmethod,app_testcase_evelement=testcase_evelement,app_testcase_optmethod=testcase_optmethod,app_testcase_testdata=testcase_testdata,app_testcase_assertdata=testcase_assertdata,app_testcase_stepresult=testcase_stepresult,create_time=create_time,delete_flag=delete_flag,app_testcase_code_order=max_id)
    return HttpResponse('200')

@csrf_exempt
def loadAppOptions(request):
    appcase_result = []
    results = AutotestplatAppTestcase.objects.values('app_testcase_result').distinct()
    for re in results:
        appcase_result.append(re['app_testcase_result'])
    rst = [appcase_result]
    return JsonResponse(rst, safe=False)

@csrf_exempt
def deleteApptestcase(request):
    app_testcase_code = request.POST.get('app_testcase_code')
    AutotestplatAppTestcase.objects.filter(app_testcase_code=app_testcase_code).delete()
    return HttpResponse('200')

def showModAppTestcase(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        id = raw_data['id1']
        name = raw_data['name1']
        order = raw_data['order1']
        case_infos = AutotestplatAppTestcase.objects.filter(app_testcase_code=id)
        case_step_list = ''
        objname = ''
        findmethod = ''
        evelement = ''
        optmethod = ''
        testdata = ''
        assertdata = ''
        stepresult = ''
        for index, case in enumerate(case_infos):
            if index == len(case_infos) - 1:
                case_step_list += case.app_testcase_step
                objname +=case.app_testcase_objname
                findmethod +=case.app_testcase_findmethod
                evelement +=case.app_testcase_evelement
                optmethod +=case.app_testcase_optmethod
                testdata += case.app_testcase_testdata
                assertdata += case.app_testcase_assertdata
                stepresult += case.app_testcase_stepresult
            else:
                case_step_list += case.app_testcase_step + ','
                objname += case.app_testcase_objname + ','
                findmethod += case.app_testcase_findmethod + ','
                evelement += case.app_testcase_evelement + ','
                optmethod += case.app_testcase_optmethod + ','
                testdata += case.app_testcase_testdata + ','
                assertdata += case.app_testcase_assertdata + ','
                stepresult += case.app_testcase_stepresult + ','
        case_info = {'id': id,
                     'name': name,
                     'order':order,
                     'case_step_list':case_step_list,
                     'objname':objname,
                     'findmethod': findmethod,
                     'evelement': evelement,
                     'optmethod': optmethod,
                     'testdata': testdata,
                     'assertdata': assertdata,
                     'stepresult': stepresult,
                    }
        return HttpResponse(json.dumps(case_info), content_type='application/json')


def showCopyAppTestcase(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        id = raw_data['id1']
        name = raw_data['name1']
        case_infos = AutotestplatAppTestcase.objects.filter(app_testcase_code=id)
        case_step_list = ''
        objname = ''
        findmethod = ''
        evelement = ''
        optmethod = ''
        testdata = ''
        assertdata = ''
        stepresult = ''
        for index, case in enumerate(case_infos):
            if index == len(case_infos) - 1:
                case_step_list += case.app_testcase_step
                objname +=case.app_testcase_objname
                findmethod +=case.app_testcase_findmethod
                evelement +=case.app_testcase_evelement
                optmethod +=case.app_testcase_optmethod
                testdata += case.app_testcase_testdata
                assertdata += case.app_testcase_assertdata
                stepresult += case.app_testcase_stepresult
            else:
                case_step_list += case.app_testcase_step + ','
                objname += case.app_testcase_objname + ','
                findmethod += case.app_testcase_findmethod + ','
                evelement += case.app_testcase_evelement + ','
                optmethod += case.app_testcase_optmethod + ','
                testdata += case.app_testcase_testdata + ','
                assertdata += case.app_testcase_assertdata + ','
                stepresult += case.app_testcase_stepresult + ','

        case_info = {'id': id,
                     'name': name,
                     'case_step_list':case_step_list,
                     'objname':objname,
                     'findmethod': findmethod,
                     'evelement': evelement,
                     'optmethod': optmethod,
                     'testdata': testdata,
                     'assertdata': assertdata,
                     'stepresult': stepresult,
                    }
        return HttpResponse(json.dumps(case_info), content_type='application/json')


@csrf_exempt
def modApptestcase(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        print(raw_data)
        id = raw_data['moddataObj']['id1']
        app_testcase_code_order = raw_data['moddataObj']['order1']
        app_testcase_code = id
        username = request.session.get('user', '')
        if AuthUser.objects.filter(username=username).first().is_superuser == 1:
            product_id = ''
        else:
            product_id = AuthUser.objects.filter(username=username).first().last_name
        app_testcase_result = '未执行'
        create_time = str(time.strftime("%Y-%m-%d %H:%M:%S"))
        app_testcase_name = raw_data['moddataObj']['app_testcase_name']
        delete_flag = 'N'
        AutotestplatAppTestcase.objects.filter(app_testcase_code=app_testcase_code).delete()
        time.sleep(1)
        for i in range(len(raw_data['moddataObj']['modcaseStepList'])):
            id = str(datetime.now().strftime("%Y%m%d%H%M%S%f"))
            testcase_step = raw_data['moddataObj']['modcaseStepList'][i]
            testcase_objname = raw_data['moddataObj']['modcaseStepList_objname'][i]
            testcase_findmethod = raw_data['moddataObj']['modcaseStepList_findmethod'][i]
            testcase_evelement = raw_data['moddataObj']['modcaseStepList_evelement'][i]
            testcase_optmethod = raw_data['moddataObj']['modcaseStepList_optmethod'][i]
            testcase_testdata = raw_data['moddataObj']['modcaseStepList_testdata'][i]
            testcase_assertdata = raw_data['moddataObj']['modcaseStepList_assertdata'][i]
            testcase_stepresult = raw_data['moddataObj']['modcaseStepList_stepresult'][i]
            time.sleep(1)
            modAppTestcase = AutotestplatAppTestcase(id=id,app_testcase_code=app_testcase_code,app_testcase_name=app_testcase_name,
                                               app_testcase_result=app_testcase_result, tester=username,create_time=create_time,
                                               product_id=product_id, app_testcase_step=testcase_step,
                                               app_testcase_objname=testcase_objname,
                                               app_testcase_findmethod=testcase_findmethod,
                                               app_testcase_evelement=testcase_evelement,
                                               app_testcase_optmethod=testcase_optmethod,
                                               app_testcase_testdata=testcase_testdata,
                                               app_testcase_assertdata=testcase_assertdata,
                                               app_testcase_stepresult=testcase_stepresult,
                                               app_testcase_code_order=app_testcase_code_order,
                                               delete_flag=delete_flag)
            modAppTestcase.save()
        return HttpResponse('200')


@csrf_exempt
def copyApptestcase(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        app_testcase_code = str(int(time.time()))
        username = request.session.get('user', '')
        if AuthUser.objects.filter(username=username).first().is_superuser == 1:
            product_id = ''
        else:
            product_id = AuthUser.objects.filter(username=username).first().last_name
        app_testcase_result = '未执行'
        create_time = str(time.strftime("%Y-%m-%d %H:%M:%S"))
        app_testcase_name = raw_data['copydataObj']['app_testcase_name']
        delete_flag = 'N'
        max_id = AutotestplatAppTestcase.objects.order_by('-app_testcase_code_order')[0].app_testcase_code_order
        if max_id == '' or max_id == None:
            max_id = 1
        else:
            max_id = max_id + 1
        time.sleep(1)
        for i in range(len(raw_data['copydataObj']['copycaseStepList'])):
            id = str(datetime.now().strftime("%Y%m%d%H%M%S%f"))
            testcase_step = raw_data['copydataObj']['copycaseStepList'][i]
            testcase_objname = raw_data['copydataObj']['copycaseStepList_objname'][i]
            testcase_findmethod = raw_data['copydataObj']['copycaseStepList_findmethod'][i]
            testcase_evelement = raw_data['copydataObj']['copycaseStepList_evelement'][i]
            testcase_optmethod = raw_data['copydataObj']['copycaseStepList_optmethod'][i]
            testcase_testdata = raw_data['copydataObj']['copycaseStepList_testdata'][i]
            testcase_assertdata = raw_data['copydataObj']['copycaseStepList_assertdata'][i]
            testcase_stepresult = raw_data['copydataObj']['copycaseStepList_stepresult'][i]
            time.sleep(1)
            copyAppTestcase = AutotestplatAppTestcase(id=id,app_testcase_code=app_testcase_code,app_testcase_name=app_testcase_name,
                                               app_testcase_result=app_testcase_result, tester=username,create_time=create_time,
                                               product_id=product_id, app_testcase_step=testcase_step,
                                               app_testcase_objname=testcase_objname,
                                               app_testcase_findmethod=testcase_findmethod,
                                               app_testcase_evelement=testcase_evelement,
                                               app_testcase_optmethod=testcase_optmethod,
                                               app_testcase_testdata=testcase_testdata,
                                               app_testcase_assertdata=testcase_assertdata,
                                               app_testcase_stepresult=testcase_stepresult,
                                               app_testcase_code_order=max_id,
                                               delete_flag=delete_flag)
            copyAppTestcase.save()
        return HttpResponse('200')

@csrf_exempt
def runApptestcase(request,app_testcase_code):
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        user_product_id = ''
    else:
        user_product_id = AuthUser.objects.filter(username=username).first().last_name
    appset = AutotestplatParameter.objects.filter(type='app').filter(product_id=user_product_id)
    if appset:
        auto_framework=appset.first().value
        if('uiautomator' in auto_framework.lower()):
            testcase_template_uiautomator2(user_product_id,app_testcase_code)
        elif('appium' in auto_framework.lower()):
            testcase_template_appium(user_product_id, app_testcase_code)
    else:
        testcase_template_uiautomator2(user_product_id, app_testcase_code)
    return HttpResponse("运行完成。  该用例为：" + str(app_testcase_code) + "  " + "。" + "<input style='color:light blue' type='button'' name='Submit'' value='返回查看结果'' onclick='self.location=document.referrer;' />")

@csrf_exempt
def runAllTestcase(request):
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        user_product_id = ''
    else:
        user_product_id = AuthUser.objects.filter(username=username).first().last_name
    app_testcase_code = ''
    appset = AutotestplatParameter.objects.filter(type='app').filter(product_id=user_product_id)
    if appset:
        auto_framework = appset.first().value
        if ('uiautomator' in auto_framework.lower()):
            testcase_template_uiautomator2(user_product_id, app_testcase_code)
        elif ('appium' in auto_framework.lower()):
            testcase_template_appium(user_product_id, app_testcase_code)
    else:
        testcase_template_uiautomator2(user_product_id, app_testcase_code)
    return HttpResponse("运行完成。  该用例为：" + str(app_testcase_code) + "  " + "。" + "<input style='color:light blue' type='button'' name='Submit'' value='返回查看结果'' onclick='self.location=document.referrer;' />")

def testcase_template_uiautomator2(user_product_id,app_testcase_code):
    time.sleep(1)
    print("autotest case %s start..." % app_testcase_code)
    print("autotest product_id %s start..." % user_product_id )
    driver=u2.connect()
    if(app_testcase_code==''):
        sql = "SELECT id,app_testcase_findmethod,app_testcase_evelement,app_testcase_optmethod,app_testcase_testdata,app_testcase_assertdata,`app_testcase_stepresult`,app_testcase_code from autotestplat_app_testcase where autotestplat_app_testcase.product_id=" + str(user_product_id) + " ORDER BY app_testcase_code_order ASC "
        caseResultInit(user_product_id, '未执行')
    else:
        sql = "SELECT id,app_testcase_findmethod,app_testcase_evelement,app_testcase_optmethod,app_testcase_testdata,app_testcase_assertdata,`app_testcase_stepresult`,app_testcase_code from autotestplat_app_testcase where autotestplat_app_testcase.app_testcase_code=" + str(app_testcase_code) + " ORDER BY id ASC "
    coon = pymysql.connect(user='root', passwd='test123456', db='autotestplat', port=3306, host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    aa = cursor.execute(sql)
    info = cursor.fetchmany(aa)
    for ii in info:
        case_list = []
        case_list.append(ii)
        for case in case_list:
            try:
                case_id = case[0]
                findmethod = case[1]
                evelement = case[2]
                optmethod = case[3]
                testdata = case[4]
                app_testcase_code= case[7]
            except Exception as e:
                return '测试用例格式不正确！%s' % e
            if optmethod == 'app_start':
                try:
                    driver.app_start(evelement,testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_id':
                try:
                    driver(resourceId=evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_name':
                try:
                    driver(text=evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_text':
                try:
                    driver(text=evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_desc':
                try:
                    driver(description=evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_class':
                try:
                    driver(className=evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_xpath':
                try:
                    driver.xpath(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_id':
                try:
                    driver.find_element_by_id(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_name':
                try:
                    driver(text=evelement).set_text(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_text':
                try:
                    driver(text=evelement).set_text(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sleep':
                try:
                    sleep(int(evelement))
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
        stepresult_bycode = AutotestplatAppTestcase.objects.filter(app_testcase_code=app_testcase_code).values_list('app_testcase_stepresult')
        tmp = []
        for item in stepresult_bycode:
            tmp += [str(item[0])]
        if '未执行' in tmp:
            caseResult(app_testcase_code, '未执行')
        elif 'fail' in tmp:
            caseResult(app_testcase_code, 'failed')
        else:
            caseResult(app_testcase_code, 'pass')
    driver.press("home")
    sleep(2)
    print("autotest case %s ...end" % app_testcase_code)
    coon.commit()
    cursor.close()
    coon.close()


def testcase_template_appium(user_product_id,app_testcase_code):
    appset = AutotestplatParameter.objects.filter(type='app')
    if appset:
        platformVersion = appset.first().login_account
        deviceName = appset.first().login_password
        appPackage = appset.first().left
        appActivity = appset.first().right
    else:
        platformVersion = ''
        deviceName = ''
        appPackage = ''
        appActivity = ''
        return HttpResponse("未正确设置Andorid App运行环境信息")
    print("android settings is "+platformVersion+" "+deviceName+" "+appPackage+" "+appActivity)
    desired_caps = {}
    desired_caps['platformName'] = 'Android'
    desired_caps['platformVersion'] = platformVersion
    desired_caps['deviceName'] = deviceName
    desired_caps['appPackage'] = appPackage
    desired_caps['appActivity'] = appActivity
    desired_caps['resetKeyboard'] = 'true'
    desired_caps['unicodeKeyboard'] = 'true'
    time.sleep(1)
    print("autotest case %s start..." % app_testcase_code)
    try:
        driver = webdriver.Remote('http://127.0.0.1:4723/wd/hub', desired_caps)
    except:
        print("启动appium运行环境错误，请检测是否正确安装配置和启动")
    time.sleep(3)
    x = driver.get_window_size()['width']
    y = driver.get_window_size()['height']
    x1 = int(x * 0.75)
    y1 = int(y * 0.5)
    x2 = int(x * 0.05)
    if (app_testcase_code == ''):
        sql = "SELECT id,app_testcase_findmethod,app_testcase_evelement,app_testcase_optmethod,app_testcase_testdata,app_testcase_assertdata,`app_testcase_stepresult`,app_testcase_code from autotestplat_app_testcase where autotestplat_app_testcase.product_id=" + str(user_product_id) + " ORDER BY app_testcase_code_order ASC "
        caseResultInit(user_product_id,'未执行')
    else:
        sql = "SELECT id,app_testcase_findmethod,app_testcase_evelement,app_testcase_optmethod,app_testcase_testdata,app_testcase_assertdata,`app_testcase_stepresult`,app_testcase_code from autotestplat_app_testcase where autotestplat_app_testcase.app_testcase_code=" + str(app_testcase_code) + " ORDER BY id ASC "
    coon = pymysql.connect(user='root', passwd='test123456', db='autotestplat', port=3306, host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    aa = cursor.execute(sql)
    info = cursor.fetchmany(aa)
    for ii in info:
        case_list = []
        case_list.append(ii)
        for case in case_list:
            try:
                case_id = case[0]
                findmethod = case[1]
                evelement = case[2]
                optmethod = case[3]
                testdata = case[4]
                app_testcase_code = case[7]
            except Exception as e:
                return '测试用例格式不正确！%s' % e
            driver.implicitly_wait(30)
            if optmethod == 'click' and findmethod == 'find_element_by_id':
                try:
                    driver.find_element_by_id(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_name':
                try:
                    driver.find_element_by_android_uiautomator(f'new UiSelector().text(\"{evelement}\")').click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_id':
                try:
                    driver.find_element_by_id(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_name':
                try:
                    driver.find_element_by_android_uiautomator(f'new UiSelector().text(\"{evelement}\")').send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'slide' and findmethod == 'up':
                try:
                    sleep(3)
                    x = driver.get_window_size()['width']
                    y = driver.get_window_size()['height']
                    x1 = int(x * 0.5)
                    y1 = int(y * 0.75)
                    y2 = int(y * 0.25)
                    driver.swipe(x1, y1, x1, y2, 1000)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'slide' and findmethod == 'down':
                try:
                    sleep(3)
                    x = driver.get_window_size()['width']
                    y = driver.get_window_size()['height']
                    x1 = int(x * 0.5)
                    y1 = int(y * 0.25)
                    y2 = int(y * 0.75)
                    driver.swipe(x1, y1, x1, y2, 1000)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'press' and findmethod == 'find_element_by_id':
                try:
                    action1 = TouchAction(driver)
                    el = driver.find_element_by_id(evelement)
                    action1.long_press(el).wait(10000).perform()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'tap' and findmethod == 'position':
                try:
                    sleep(8)
                    eve_list = evelement.split(',')
                    driver.tap([(eve_list[0], eve_list[1]), (eve_list[2], eve_list[3])], 500)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_xpath':
                try:
                    driver.find_element_by_xpath(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sleep':
                try:
                    sleep(int(evelement))
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
        stepresult_bycode = AutotestplatAppTestcase.objects.filter(app_testcase_code=app_testcase_code).values_list('app_testcase_stepresult')
        tmp = []
        for item in stepresult_bycode:
            tmp += [str(item[0])]
        if '未执行' in tmp:
            caseResult(app_testcase_code, '未执行')
        elif 'fail' in tmp:
            caseResult(app_testcase_code, 'failed')
        else:
            caseResult(app_testcase_code, 'pass')
    sleep(5)
    print("autotest case %s ...end" % app_testcase_code)
    coon.commit()
    cursor.close()
    coon.close()
    driver.quit()

def casestepResult(app_testcase_code, result):
    result = result.encode('utf-8')
    now = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    sql = "UPDATE autotestplat_app_testcase set autotestplat_app_testcase.app_testcase_stepresult=%s,autotestplat_app_testcase.run_time=%s where autotestplat_app_testcase.id=%s;"
    param = (result, now, app_testcase_code)
    coon = pymysql.connect(user='root', passwd='test123456', db='autotestplat', port=3306, host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql, param)
    coon.commit()
    cursor.close()
    coon.close()

def caseResult(app_testcase_code, result):
    result = result.encode('utf-8')
    now = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    sql = "UPDATE autotestplat_app_testcase set autotestplat_app_testcase.app_testcase_result=%s,autotestplat_app_testcase.run_time=%s where autotestplat_app_testcase.app_testcase_code=%s;"
    param = (result, now, app_testcase_code)
    print('app autotest result is ' + result.decode())
    coon = pymysql.connect(user='root', passwd='test123456', db='autotestplat', port=3306, host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql, param)
    coon.commit()
    cursor.close()
    coon.close()

def caseResultInit(user_product_id,result):
    result = result.encode('utf-8')
    now = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    sql = "UPDATE autotestplat_app_testcase set autotestplat_app_testcase.app_testcase_result=%s,autotestplat_app_testcase.app_testcase_stepresult=%s,autotestplat_app_testcase.run_time=%s where autotestplat_app_testcase.product_id=%s"
    param = (result, result, now, user_product_id)
    print('app autotest result init is ' + result.decode())
    coon = pymysql.connect(user='root', passwd='test123456', db='autotestplat', port=3306, host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql, param)
    coon.commit()
    cursor.close()
    coon.close()

def readRes(res, res_check):
    res = res.replace('":"', "=").replace('":', "=")
    res_check = res_check.split(';')
    for s in res_check:
        if s in res:
            pass
        else:
            return '错误，返回参数和预期结果不一致' + s
    return 'pass'

def waitForElementByName(evelement, Driver):
    try:
        wait = WebDriverWait(driver, 30).until(EC.presence_of_element_located((By.NAME, evelement)))
        print(wait)
        if (None == wait):
            result = "failed";
        else:
            result = "pass";
    except:
        result = "failed";
        print(result);
    finally:
        return result;


def waitForElementById(evelement, Driver):
    try:
        wait = WebDriverWait(driver, 30).until(EC.presence_of_element_located((By.ID, evelement)))
        if (None == wait):
            result = "failed";
        else:
            result = "pass";
    except:
        result = "failed";
        print(result);
    finally:
        return result;


def waitForElementByXpath(evelement, Driver):
    try:
        wait = WebDriverWait(driver, 30).until(EC.presence_of_element_located((By.XPATH, evelement)))
        if (None == wait):
            result = "failed";
        else:
            result = "pass";
    except:
        result = "failed";
        print(result);
    finally:
        return result;
