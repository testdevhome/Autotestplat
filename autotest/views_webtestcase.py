# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V5.0
############################################
import time,json,pymysql,os
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render
from django.http import JsonResponse, HttpResponse
from django.db.models import Count
from django.db.models import Q
from time import sleep
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
from selenium.webdriver import ActionChains
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from django.template.context_processors import csrf
from django.shortcuts import render_to_response
from .models import *

current_dir = os.getcwd()

def getWebView(request):
    user_name = request.session.get('user', '')
    product_all = AutotestplatProduct.objects.filter(delete_flag='N')
    product_id = AuthUser.objects.filter(username=user_name).first().last_name
    product_name = AutotestplatProduct.objects.filter(id=product_id).first().product_name
    c = csrf(request)
    c.update({"product_name":product_name,"product_alls":product_all})
    return render_to_response("web_testcase.html",c)

@csrf_exempt
def loadWebTestcaseTable(request):
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        items = AutotestplatWebTestcase.objects.all().values_list('web_testcase_code','web_testcase_name','web_testcase_result','tester','run_time','product_id','delete_flag','web_testcase_code_order').annotate(Count('id')).order_by('web_testcase_code_order')
    else:
        user_product_id = AuthUser.objects.filter(username=username).first().last_name
        if user_product_id:
            items = AutotestplatWebTestcase.objects.filter(Q(product_id=user_product_id)).values_list('web_testcase_code', 'web_testcase_name',
                                                                      'web_testcase_result', 'tester', 'run_time',
                                                                      'product_id', 'delete_flag','web_testcase_code_order').annotate(Count('id')).order_by('web_testcase_code_order')
        else:
            items = AutotestplatWebTestcase.objects.all().values_list('web_testcase_code', 'web_testcase_name',
                                                                      'web_testcase_result', 'tester', 'run_time',
                                                                      'product_id', 'delete_flag','web_testcase_code_order').annotate(Count('id')).order_by('web_testcase_code_order')
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
def addWebtestcase(request):
    web_testcase_code = str(int(time.time()))
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        product_id = ''
    else:
        product_id = AuthUser.objects.filter(username=username).first().last_name
    web_testcase_result = '未执行'
    create_time = str(time.strftime("%Y-%m-%d %H:%M:%S"))
    web_testcase_name = request.POST.get('web_testcase_name')
    web_testcase_step = request.POST.getlist('caseStepList[]')
    web_testcase_objname = request.POST.getlist('caseStepList_objname[]')
    web_testcase_findmethod = request.POST.getlist('caseStepList_findmethod[]')
    web_testcase_evelement = request.POST.getlist('caseStepList_evelement[]')
    web_testcase_optmethod = request.POST.getlist('caseStepList_optmethod[]')
    web_testcase_testdata = request.POST.getlist('caseStepList_testdata[]')
    web_testcase_assertdata = request.POST.getlist('caseStepList_assertdata[]')
    web_testcase_stepresult = request.POST.getlist('caseStepList_stepresult[]')
    delete_flag = 'N'
    max_id = AutotestplatWebTestcase.objects.order_by('-web_testcase_code_order')[0].web_testcase_code_order
    if max_id=='' or max_id==None:
        max_id=1
    else:
        max_id = max_id+1
    print(web_testcase_step)
    for i in range(len(web_testcase_step)):
       id = str(datetime.now().strftime("%Y%m%d%H%M%S%f"))
       testcase_step = web_testcase_step[i]
       testcase_objname = web_testcase_objname[i]
       testcase_findmethod = web_testcase_findmethod[i]
       testcase_evelement = web_testcase_evelement[i]
       testcase_optmethod = web_testcase_optmethod[i]
       testcase_testdata = web_testcase_testdata[i]
       testcase_assertdata = web_testcase_assertdata[i]
       testcase_stepresult = web_testcase_stepresult[i]
       time.sleep(2)
       AutotestplatWebTestcase.objects.create(id=id, web_testcase_code=web_testcase_code,web_testcase_name=web_testcase_name,web_testcase_result=web_testcase_result,tester=username,product_id=product_id,web_testcase_step=testcase_step,web_testcase_objname=testcase_objname,web_testcase_findmethod=testcase_findmethod,web_testcase_evelement=testcase_evelement,web_testcase_optmethod=testcase_optmethod,web_testcase_testdata=testcase_testdata,web_testcase_assertdata=testcase_assertdata,web_testcase_stepresult=testcase_stepresult,create_time=create_time,delete_flag=delete_flag,web_testcase_code_order=max_id)
    return HttpResponse('200')

@csrf_exempt
def loadWebOptions(request):
    webcase_result = []
    results = AutotestplatWebTestcase.objects.values('web_testcase_result').distinct()
    for re in results:
        webcase_result.append(re['web_testcase_result'])
    rst = [webcase_result]
    return JsonResponse(rst, safe=False)

@csrf_exempt
def deleteWebtestcase(request):
    web_testcase_code = request.POST.get('web_testcase_code')
    AutotestplatWebTestcase.objects.filter(web_testcase_code=web_testcase_code).delete()
    return HttpResponse('200')

def showModWebTestcase(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        id = raw_data['id1']
        name = raw_data['name1']
        order = raw_data['order1']
        case_infos = AutotestplatWebTestcase.objects.filter(web_testcase_code=id)
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
                case_step_list += case.web_testcase_step
                objname +=case.web_testcase_objname
                findmethod +=case.web_testcase_findmethod
                evelement +=case.web_testcase_evelement
                optmethod +=case.web_testcase_optmethod
                testdata += case.web_testcase_testdata
                assertdata += case.web_testcase_assertdata
                stepresult += case.web_testcase_stepresult
            else:
                case_step_list += case.web_testcase_step + ','
                objname += case.web_testcase_objname + ','
                findmethod += case.web_testcase_findmethod + ','
                evelement += case.web_testcase_evelement + ','
                optmethod += case.web_testcase_optmethod + ','
                testdata += case.web_testcase_testdata + ','
                assertdata += case.web_testcase_assertdata + ','
                stepresult += case.web_testcase_stepresult + ','
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


def showCopyWebTestcase(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        id = raw_data['id1']
        name = raw_data['name1']
        case_infos = AutotestplatWebTestcase.objects.filter(web_testcase_code=id)
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
                case_step_list += case.web_testcase_step
                objname +=case.web_testcase_objname
                findmethod +=case.web_testcase_findmethod
                evelement +=case.web_testcase_evelement
                optmethod +=case.web_testcase_optmethod
                testdata += case.web_testcase_testdata
                assertdata += case.web_testcase_assertdata
                stepresult += case.web_testcase_stepresult
            else:
                case_step_list += case.web_testcase_step + ','
                objname += case.web_testcase_objname + ','
                findmethod += case.web_testcase_findmethod + ','
                evelement += case.web_testcase_evelement + ','
                optmethod += case.web_testcase_optmethod + ','
                testdata += case.web_testcase_testdata + ','
                assertdata += case.web_testcase_assertdata + ','
                stepresult += case.web_testcase_stepresult + ','

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
def modWebtestcase(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        print(raw_data)
        id = raw_data['moddataObj']['id1']
        web_testcase_code_order = raw_data['moddataObj']['order1']
        web_testcase_code = id
        username = request.session.get('user', '')
        if AuthUser.objects.filter(username=username).first().is_superuser == 1:
            product_id = ''
        else:
            product_id = AuthUser.objects.filter(username=username).first().last_name
        web_testcase_result = '未执行'
        create_time = str(time.strftime("%Y-%m-%d %H:%M:%S"))
        web_testcase_name = raw_data['moddataObj']['web_testcase_name']
        delete_flag = 'N'
        AutotestplatWebTestcase.objects.filter(web_testcase_code=web_testcase_code).delete()
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
            modWebTestcase = AutotestplatWebTestcase(id=id,web_testcase_code=web_testcase_code,web_testcase_name=web_testcase_name,
                                               web_testcase_result=web_testcase_result, tester=username,create_time=create_time,
                                               product_id=product_id, web_testcase_step=testcase_step,
                                               web_testcase_objname=testcase_objname,
                                               web_testcase_findmethod=testcase_findmethod,
                                               web_testcase_evelement=testcase_evelement,
                                               web_testcase_optmethod=testcase_optmethod,
                                               web_testcase_testdata=testcase_testdata,
                                               web_testcase_assertdata=testcase_assertdata,
                                               web_testcase_stepresult=testcase_stepresult,
                                               web_testcase_code_order=web_testcase_code_order,
                                               delete_flag=delete_flag)
            modWebTestcase.save()
        return HttpResponse('200')


@csrf_exempt
def copyWebtestcase(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        web_testcase_code = str(int(time.time()))
        username = request.session.get('user', '')
        if AuthUser.objects.filter(username=username).first().is_superuser == 1:
            product_id = ''
        else:
            product_id = AuthUser.objects.filter(username=username).first().last_name
        web_testcase_result = '未执行'
        create_time = str(time.strftime("%Y-%m-%d %H:%M:%S"))
        web_testcase_name = raw_data['copydataObj']['web_testcase_name']
        delete_flag = 'N'
        max_id = AutotestplatWebTestcase.objects.order_by('-web_testcase_code_order')[0].web_testcase_code_order
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
            copyWebTestcase = AutotestplatWebTestcase(id=id,web_testcase_code=web_testcase_code,web_testcase_name=web_testcase_name,
                                               web_testcase_result=web_testcase_result, tester=username,create_time=create_time,
                                               product_id=product_id, web_testcase_step=testcase_step,
                                               web_testcase_objname=testcase_objname,
                                               web_testcase_findmethod=testcase_findmethod,
                                               web_testcase_evelement=testcase_evelement,
                                               web_testcase_optmethod=testcase_optmethod,
                                               web_testcase_testdata=testcase_testdata,
                                               web_testcase_assertdata=testcase_assertdata,
                                               web_testcase_stepresult=testcase_stepresult,
                                               web_testcase_code_order=max_id,
                                               delete_flag=delete_flag)
            copyWebTestcase.save()
        return HttpResponse('200')

@csrf_exempt
def runWebtestcase(request,web_testcase_code):
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        user_product_id = ''
    else:
        user_product_id = AuthUser.objects.filter(username=username).first().last_name
    webset = AutotestplatParameter.objects.filter(type='web').filter(product_id=user_product_id)
    if webset:
        auto_framework=webset.first().value
        if('selenium' in auto_framework.lower()):
            testcase_template_selenium(user_product_id,web_testcase_code)
        elif('cypress' in auto_framework.lower()):
            testcase_template_cypress(user_product_id, web_testcase_code)
        elif('playwright' in auto_framework.lower()):
            testcase_template_playwright(user_product_id, web_testcase_code)
    else:
        testcase_template_selenium(user_product_id, web_testcase_code)
    return HttpResponse("运行完成。  该用例为：" + str(web_testcase_code) + "  " + "。" + "<input style='color:light blue' type='button'' name='Submit'' value='返回查看结果'' onclick='self.location=document.referrer;' />")

@csrf_exempt
def runAllTestcase(request):
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        user_product_id = ''
    else:
        user_product_id = AuthUser.objects.filter(username=username).first().last_name
    web_testcase_code = ''
    webset = AutotestplatParameter.objects.filter(type='web').filter(product_id=user_product_id)
    if webset:
        auto_framework = webset.first().value
        if ('selenium' in auto_framework.lower()):
            testcase_template_selenium(user_product_id, web_testcase_code)
        elif ('cypress' in auto_framework.lower()):
            testcase_template_cypress(user_product_id, web_testcase_code)
        elif ('playwright' in auto_framework.lower()):
            testcase_template_playwright(user_product_id, web_testcase_code)
    else:
        testcase_template_selenium(user_product_id, web_testcase_code)
    return HttpResponse("运行完成。  该用例为：" + str(web_testcase_code) + "  " + "。" + "<input style='color:light blue' type='button'' name='Submit'' value='返回查看结果'' onclick='self.location=document.referrer;' />")

def testcase_template_selenium(user_product_id,web_testcase_code):
    time.sleep(1)
    print("autotest case %s start..." % web_testcase_code)
    print("autotest product_id %s start..." % user_product_id )
    chrome_driver_path=r""+current_dir+"\chromedriver.exe"
    driver = webdriver.Chrome(executable_path=chrome_driver_path)
    if(web_testcase_code==''):
        sql = "SELECT id,web_testcase_findmethod,web_testcase_evelement,web_testcase_optmethod,web_testcase_testdata,web_testcase_assertdata,`web_testcase_stepresult`,web_testcase_code from autotestplat_web_testcase where autotestplat_web_testcase.product_id=" + str(user_product_id) + " ORDER BY web_testcase_code_order ASC "
        caseResultInit(user_product_id, '未执行')
    else:
        sql = "SELECT id,web_testcase_findmethod,web_testcase_evelement,web_testcase_optmethod,web_testcase_testdata,web_testcase_assertdata,`web_testcase_stepresult`,web_testcase_code from autotestplat_web_testcase where autotestplat_web_testcase.web_testcase_code=" + str(web_testcase_code) + " ORDER BY id ASC "
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
                web_testcase_code= case[7]
            except Exception as e:
                return '测试用例格式不正确！%s' % e
            if optmethod == 'web_start':
                try:
                    driver.implicitly_wait(10)
                    driver.maximize_window()
                    driver.get(evelement + testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_id':
                try:
                    driver.find_element_by_id(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_name':
                try:
                    driver.find_element_by_name(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_class':
                try:
                    driver.find_element_by_class(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_xpath':
                try:
                    driver.find_element_by_xpath(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_id':
                try:
                    driver.find_element_by_id(evelement).clear()
                    driver.find_element_by_id(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_name':
                try:
                    driver.find_element_by_name(evelement).clear()
                    driver.find_element_by_name(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_xpath':
                try:
                    driver.find_element_by_xpath(evelement).clear()
                    driver.find_element_by_xpath(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sleep':
                try:
                    sleep(int(testdata))
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
        stepresult_bycode = AutotestplatWebTestcase.objects.filter(web_testcase_code=web_testcase_code).values_list('web_testcase_stepresult')
        tmp = []
        for item in stepresult_bycode:
            tmp += [str(item[0])]
        if '未执行' in tmp:
            caseResult(web_testcase_code, '未执行')
        elif 'fail' in tmp:
            caseResult(web_testcase_code, 'failed')
        else:
            caseResult(web_testcase_code, 'pass')
    sleep(2)
    print("autotest case %s ...end" % web_testcase_code)
    coon.commit()
    cursor.close()
    coon.close()
    driver.quit()


def testcase_template_cypress(user_product_id,web_testcase_code):
    time.sleep(1)
    print("autotest case %s start..." % web_testcase_code)
    print("autotest product_id %s start..." % user_product_id)
    chrome_driver_path = r"" + current_dir + "\chromedriver.exe"
    driver = webdriver.Chrome(executable_path=chrome_driver_path)
    if (web_testcase_code == ''):
        sql = "SELECT id,web_testcase_findmethod,web_testcase_evelement,web_testcase_optmethod,web_testcase_testdata,web_testcase_assertdata,`web_testcase_stepresult`,web_testcase_code from autotestplat_web_testcase where autotestplat_web_testcase.product_id=" + str(
            user_product_id) + " ORDER BY web_testcase_code_order ASC "
        caseResultInit(user_product_id, '未执行')
    else:
        sql = "SELECT id,web_testcase_findmethod,web_testcase_evelement,web_testcase_optmethod,web_testcase_testdata,web_testcase_assertdata,`web_testcase_stepresult`,web_testcase_code from autotestplat_web_testcase where autotestplat_web_testcase.web_testcase_code=" + str(
            web_testcase_code) + " ORDER BY id ASC "
    coon = pymysql.connect(user='root', passwd='test123456', db='autotestplat', port=3306, host='127.0.0.1',
                           charset='utf8')
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
                web_testcase_code = case[7]
            except Exception as e:
                return '测试用例格式不正确！%s' % e
            if optmethod == 'web_start':
                try:
                    driver.implicitly_wait(10)
                    driver.maximize_window()
                    driver.get(evelement + testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_id':
                try:
                    driver.find_element_by_id(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_name':
                try:
                    driver.find_element_by_name(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_class':
                try:
                    driver.find_element_by_class(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_xpath':
                try:
                    driver.find_element_by_xpath(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_id':
                try:
                    driver.find_element_by_id(evelement).clear()
                    driver.find_element_by_id(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_name':
                try:
                    driver.find_element_by_name(evelement).clear()
                    driver.find_element_by_name(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_xpath':
                try:
                    driver.find_element_by_xpath(evelement).clear()
                    driver.find_element_by_xpath(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sleep':
                try:
                    sleep(int(testdata))
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
        stepresult_bycode = AutotestplatWebTestcase.objects.filter(web_testcase_code=web_testcase_code).values_list(
            'web_testcase_stepresult')
        tmp = []
        for item in stepresult_bycode:
            tmp += [str(item[0])]
        if '未执行' in tmp:
            caseResult(web_testcase_code, '未执行')
        elif 'fail' in tmp:
            caseResult(web_testcase_code, 'failed')
        else:
            caseResult(web_testcase_code, 'pass')
    sleep(2)
    print("autotest case %s ...end" % web_testcase_code)
    coon.commit()
    cursor.close()
    coon.close()
    driver.quit()


def testcase_template_playwright(user_product_id,web_testcase_code):
    time.sleep(1)
    print("autotest case %s start..." % web_testcase_code)
    print("autotest product_id %s start..." % user_product_id)
    chrome_driver_path = r"" + current_dir + "\chromedriver.exe"
    driver = webdriver.Chrome(executable_path=chrome_driver_path)
    if (web_testcase_code == ''):
        sql = "SELECT id,web_testcase_findmethod,web_testcase_evelement,web_testcase_optmethod,web_testcase_testdata,web_testcase_assertdata,`web_testcase_stepresult`,web_testcase_code from autotestplat_web_testcase where autotestplat_web_testcase.product_id=" + str(
            user_product_id) + " ORDER BY web_testcase_code_order ASC "
        caseResultInit(user_product_id, '未执行')
    else:
        sql = "SELECT id,web_testcase_findmethod,web_testcase_evelement,web_testcase_optmethod,web_testcase_testdata,web_testcase_assertdata,`web_testcase_stepresult`,web_testcase_code from autotestplat_web_testcase where autotestplat_web_testcase.web_testcase_code=" + str(
            web_testcase_code) + " ORDER BY id ASC "
    coon = pymysql.connect(user='root', passwd='test123456', db='autotestplat', port=3306, host='127.0.0.1',
                           charset='utf8')
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
                web_testcase_code = case[7]
            except Exception as e:
                return '测试用例格式不正确！%s' % e
            if optmethod == 'web_start':
                try:
                    driver.implicitly_wait(10)
                    driver.maximize_window()
                    driver.get(evelement + testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_id':
                try:
                    driver.find_element_by_id(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_name':
                try:
                    driver.find_element_by_name(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_class':
                try:
                    driver.find_element_by_class(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'click' and findmethod == 'find_element_by_xpath':
                try:
                    driver.find_element_by_xpath(evelement).click()
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_id':
                try:
                    driver.find_element_by_id(evelement).clear()
                    driver.find_element_by_id(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_name':
                try:
                    driver.find_element_by_name(evelement).clear()
                    driver.find_element_by_name(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sendkey' and findmethod == 'find_element_by_xpath':
                try:
                    driver.find_element_by_xpath(evelement).clear()
                    driver.find_element_by_xpath(evelement).send_keys(testdata)
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
            elif optmethod == 'sleep':
                try:
                    sleep(int(testdata))
                    casestepResult(case_id, 'pass')
                except:
                    casestepResult(case_id, 'fail')
        stepresult_bycode = AutotestplatWebTestcase.objects.filter(web_testcase_code=web_testcase_code).values_list(
            'web_testcase_stepresult')
        tmp = []
        for item in stepresult_bycode:
            tmp += [str(item[0])]
        if '未执行' in tmp:
            caseResult(web_testcase_code, '未执行')
        elif 'fail' in tmp:
            caseResult(web_testcase_code, 'failed')
        else:
            caseResult(web_testcase_code, 'pass')
    sleep(2)
    print("autotest case %s ...end" % web_testcase_code)
    coon.commit()
    cursor.close()
    coon.close()
    driver.quit()

def casestepResult(web_testcase_code, result):
    result = result.encode('utf-8')
    now = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    sql = "UPDATE autotestplat_web_testcase set autotestplat_web_testcase.web_testcase_stepresult=%s,autotestplat_web_testcase.run_time=%s where autotestplat_web_testcase.id=%s;"
    param = (result, now, web_testcase_code)
    coon = pymysql.connect(user='root', passwd='test123456', db='autotestplat', port=3306, host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql, param)
    coon.commit()
    cursor.close()
    coon.close()

def caseResult(web_testcase_code, result):
    result = result.encode('utf-8')
    now = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    sql = "UPDATE autotestplat_web_testcase set autotestplat_web_testcase.web_testcase_result=%s,autotestplat_web_testcase.run_time=%s where autotestplat_web_testcase.web_testcase_code=%s;"
    param = (result, now, web_testcase_code)
    print('web autotest result is ' + result.decode())
    coon = pymysql.connect(user='root', passwd='test123456', db='autotestplat', port=3306, host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql, param)
    coon.commit()
    cursor.close()
    coon.close()

def caseResultInit(user_product_id,result):
    result = result.encode('utf-8')
    now = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))
    sql = "UPDATE autotestplat_web_testcase set autotestplat_web_testcase.web_testcase_result=%s,autotestplat_web_testcase.web_testcase_stepresult=%s,autotestplat_web_testcase.run_time=%s where autotestplat_web_testcase.product_id=%s"
    param = (result, result, now, user_product_id)
    print('web autotest result init is ' + result.decode())
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

