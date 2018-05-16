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
from apptest.models import Appcase,Appcasestep
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger 
# Create your views here.

# 流程接口管理
@login_required
def appcase_manage(request):
    appcase_list = Appcase.objects.all()
    appcase_count = Appcase.objects.all().count()  #统计产品数    
    username = request.session.get('user', '') # 读取浏览器登录session
    paginator = Paginator(appcase_list, 8)  #生成paginator对象,设置每页显示8条记录
    page = request.GET.get('page',1)  #获取当前的页码数,默认为第1页
    currentPage=int(page)  #把获取的当前页码数转换成整数类型
    try:
        appcase_list = paginator.page(page)#获取当前页码数的记录列表
    except PageNotAnInteger:
        appcase_list = paginator.page(1)#如果输入的页数不是整数则显示第1页的内容
    except EmptyPage:
        appcase_list = paginator.page(paginator.num_pages)#如果输入的页数不在系统的页数中则显示最后一页的内容
    return render(request, "appcase_manage.html", {"user": username,"appcases": appcase_list,"appcasecounts": appcase_count}) #把值赋给apitestcounts这个变量

	
# 接口步聚管理
@login_required
def appcasestep_manage(request):
    username = request.session.get('user', '')
    appcasestep_list = Appcasestep.objects.all()
    appcaseid = request.GET.get('appcase.id',None)    
    appcase = Appcase.objects.get(id=appcaseid)      #获取所有接口测试用例   
    appcasestep_list = Appcasestep.objects.all()
    return render(request, "appcasestep_manage.html", {"user": username,"appcase": appcase,"appcasesteps": appcasestep_list}) #把值赋给apitestcounts这个变量



# 搜索功能
@login_required
def appsearch(request):
    username = request.session.get('user', '') # 读取浏览器登录session
    search_appcasename = request.GET.get("appcasename", "")
    appcase_list = Appcase.objects.filter(appcasename__icontains=search_appcasename) 
    return render(request,'appcase_manage.html', {"user": username,"appcases":appcase_list})

# 搜索功能
@login_required
def appstepsearch(request):
    username = request.session.get('user', '') # 读取浏览器登录session
    search_appcasename = request.GET.get("appcasename", "")
    appcasestep_list = Appcasestep.objects.filter(appcasename__icontains=search_appcasename) 
    return render(request,'appcasestep_manage.html', {"user": username,"appcasesteps":appcasestep_list})

# app测试报告
@login_required
def apptest_report(request):
    username = request.session.get('user', '')
    return render(request, "apptest_report.html")
