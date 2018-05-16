# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
from django.shortcuts import render
from django.http import HttpResponse,HttpResponseRedirect
from django.contrib.auth.decorators import login_required
from django.contrib import auth
from django.contrib.auth import authenticate, login
from apitest.models import Apitest,Apistep,Apis

from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger 

import pymysql

from .tasks import hello_world
from .tasks import apisauto_testcase
from .tasks import apitest_testcase
from .webtasks import webauto_testcase
from .webtasks import webauto_testcase2
from .apptasks import appauto_testcase
from .apptasks import appauto_testcase2
from djcelery.models import PeriodicTask,CrontabSchedule,IntervalSchedule
# Create your views here.

def task_apis(request):
    hello_world.delay()
    apisauto_testcase.delay()
    return HttpResponse("已运行")

def task_apitest(request):
    hello_world.delay()
    apitest_testcase(request)
    return HttpResponse("已运行")

def task_webtest(request):
    webauto_testcase(request)
    return HttpResponse("已运行")

def task_webtest2(request):
    webauto_testcase2(request)
    return HttpResponse("已运行")

def task_apptest(request):
    appauto_testcase(request)
    return HttpResponse("已运行")

def task_apptest2(request):
    appauto_testcase2(request)
    return HttpResponse("已运行")


def welcome(request):
    return render(request,"welcome.html")

def home(request):
    return render(request,"home.html")

def left(request):
    return render(request,"left.html")

def login(request):
    if request.POST:
        username = password = ''
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = auth.authenticate(username=username, password=password)
        if user is not None and user.is_active:
            auth.login(request, user)
            request.session['user'] = username 
            response = HttpResponseRedirect('/home/')
            return response
          #  return redirect('/')
        else:
            return render(request,'login.html', {'error': 'username or password error'}) 
    
    return render(request,'login.html')


def logout(request):
    auth.logout(request)
    return render(request,'login.html')



# 流程接口管理
@login_required
def apitest_manage(request):
    apitest_list = Apitest.objects.all()      #获取所有接口测试用例
    apitest_count = Apitest.objects.all().count()  #统计产品数    
    username = request.session.get('user', '') # 读取浏览器登录session
    paginator = Paginator(apitest_list, 8)  #生成paginator对象,设置每页显示8条记录
    page = request.GET.get('page',1)  #获取当前的页码数,默认为第1页
    currentPage=int(page)  #把获取的当前页码数转换成整数类型
    try:
        apitest_list = paginator.page(page)#获取当前页码数的记录列表
    except PageNotAnInteger:
        apitest_list = paginator.page(1)#如果输入的页数不是整数则显示第1页的内容
    except EmptyPage:
        apitest_list = paginator.page(paginator.num_pages)#如果输入的页数不在系统的页数中则显示最后一页的内容
    return render(request, "apitest_manage.html", {"user": username,"apitests": apitest_list,"apitestcounts": apitest_count}) #把值赋给apitestcounts这个变量

		
# 接口步聚管理
@login_required
def apistep_manage(request):
    username = request.session.get('user', '')
    apitestid = request.GET.get('apitest.id',None)    
    apitest = Apitest.objects.get(id=apitestid)      #获取所有接口测试用例   
    apistep_list = Apistep.objects.all()
    return render(request, "apistep_manage.html",  {"user": username,"apitest": apitest,"apisteps": apistep_list})


# 单一接口管理
@login_required
def apis_manage(request):
    username = request.session.get('user', '')
    apis_list = Apis.objects.all()
    apis_count = Apis.objects.all().count()  #统计产品数
    paginator = Paginator(apis_list, 8)  #生成paginator对象,设置每页显示8条记录
    page = request.GET.get('page',1)  #获取当前的页码数,默认为第1页
    currentPage=int(page)  #把获取的当前页码数转换成整数类型
    try:
        apis_list = paginator.page(page)#获取当前页码数的记录列表
    except PageNotAnInteger:
        apis_list = paginator.page(1)#如果输入的页数不是整数则显示第1页的内容
    except EmptyPage:
        apis_list = paginator.page(paginator.num_pages)#如果输入的页数不在系统的页数中则显示最后一页的内容
    return render(request, "apis_manage.html", {"user": username,"apiss": apis_list,"apiscounts": apis_count}) #把值赋给apiscounts这个变量

# 搜索功能
@login_required
def apisearch(request):
    username = request.session.get('user', '') # 读取浏览器登录session
    search_apitestname = request.GET.get("apitestname", "")
    apitest_list = Apitest.objects.filter(apitestname__icontains=search_apitestname) 
    return render(request,'apitest_manage.html', {"user": username,"apitests":apitest_list})

# 搜索功能
@login_required
def apistepsearch(request):
    username = request.session.get('user', '') # 读取浏览器登录session
    search_apiname = request.GET.get("apiname", "")
    apistep_list = Apistep.objects.filter(apiname__icontains=search_apiname) 
    return render(request,'apistep_manage.html', {"user": username,"apisteps":apistep_list})

# 搜索功能
@login_required
def apissearch(request):
    username = request.session.get('user', '') # 读取浏览器登录session
    search_apiname = request.GET.get("apiname", "")
    apis_list = Apis.objects.filter(apiname__icontains=search_apiname) 
    return render(request,'apis_manage.html', {"user": username,"apiss":apis_list})

# 测试报告
@login_required
def test_report(request):
    username = request.session.get('user', '')
    apis_list = Apis.objects.all()
    apis_count = Apis.objects.all().count()  #统计接口数
    db = pymysql.connect(user='root', db='autotest', passwd='test123456', host='127.0.0.1')
    cursor = db.cursor()
    sql1 = 'SELECT count(id) FROM apitest_apis WHERE apitest_apis.apistatus=1'
    aa=cursor.execute(sql1)
    apis_pass_count = [row[0] for row in cursor.fetchmany(aa)][0]
    sql2 = 'SELECT count(id) FROM apitest_apis WHERE apitest_apis.apistatus=0'
    bb=cursor.execute(sql2)
    apis_fail_count = [row[0] for row in cursor.fetchmany(bb)][0]
    db.close()
    return render(request, "report.html", {"user": username,"apiss": apis_list,"apiscounts": apis_count,"apis_pass_counts": apis_pass_count,"apis_fail_counts": apis_fail_count}) #把值赋给apiscounts这个变量
   
# 测试报告
@login_required
def apitest_report(request):
    username = request.session.get('user', '')
    return render(request, "apitest_report.html")


# 任务计划
@login_required
def periodic_task(request):
    username = request.session.get('user', '')
    task_list = PeriodicTask.objects.all()
    task_count = PeriodicTask.objects.all().count()  #统计数
    periodic_list = IntervalSchedule.objects.all()  # 周期任务 （如：每隔1小时执行1次）
    crontab_list = CrontabSchedule.objects.all()    # 定时任务 （如：某年月日的某时，每天的某时）
    paginator = Paginator(task_list, 8)  #生成paginator对象,设置每页显示8条记录
    page = request.GET.get('page',1)  #获取当前的页码数,默认为第1页
    currentPage=int(page)  #把获取的当前页码数转换成整数类型
    try:
        task_list = paginator.page(page)#获取当前页码数的记录列表
    except PageNotAnInteger:
        task_list = paginator.page(1)#如果输入的页数不是整数则显示第1页的内容
    except EmptyPage:
        task_list = paginator.page(paginator.num_pages)#如果输入的页数不在系统的页数中则显示最后一页的内容
    return render(request, "periodic_task.html", {"user": username,"tasks": task_list,"taskcounts": task_count, "periodics": periodic_list,"crontabs": crontab_list })

# 搜索功能
@login_required
def tasksearch(request):
    username = request.session.get('user', '') # 读取浏览器登录session
    search_name = request.GET.get("task", "")
    task_list = PeriodicTask.objects.filter(task__icontains=search_name) 
    periodic_list = IntervalSchedule.objects.all()  # 周期任务 （如：每隔1小时执行1次）
    crontab_list = CrontabSchedule.objects.all()    # 定时任务 （如：某年月日的某时，每天的某时）
    return render(request,'periodic_task.html', {"user": username,"tasks":task_list,"periodics": periodic_list,"crontabs": crontab_list })

