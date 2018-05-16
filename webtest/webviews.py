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
from webtest.models import Webcase,Webcasestep
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger 

# Create your views here.
 

# web用例管理


@login_required


def webcase_manage(request):
    
    webcase_list = Webcase.objects.all()
    webcase_count = Webcase.objects.all().count()  #统计产品数
    
    username = request.session.get('user', '') # 读取浏览器登录session
    
    paginator = Paginator(webcase_list, 8)  #生成paginator对象,设置每页显示8条记录
    
    page = request.GET.get('page',1)  #获取当前的页码数,默认为第1页
    
    currentPage=int(page)  #把获取的当前页码数转换成整数类型
    
    try:
        webcase_list = paginator.page(page)#获取当前页码数的记录列表
    
    except PageNotAnInteger:
        webcase_list = paginator.page(1)#如果输入的页数不是整数则显示第1页的内容
    
    except EmptyPage:
        webcase_list = paginator.page(paginator.num_pages)#如果输入的页数不在系统的页数中则显示最后一页
    
    return render(request, "webcase_manage.html", {"user": username,"webcases":webcase_list,"webcasecounts": webcase_count})



# web用例测试步聚
@login_required
def webcasestep_manage(request):

    
    username = request.session.get('user', '')

        
    webcaseid = request.GET.get('webcase.id',None)  
    webcase = Webcase.objects.get(id=webcaseid)        
    webcasestep_list = Webcasestep.objects.all()
    return render(request, "webcasestep_manage.html", {"user": username,"webcase": webcase,"webcasesteps": webcasestep_list}) 

# 搜索功能

@login_required

def websearch(request):
    
    username = request.session.get('user', '') # 读取浏览器登录session
    
    search_webcasename = request.GET.get("webcasename", "")
    
    webcase_list = Webcase.objects.filter(webcasename__icontains=search_webcasename) 
    
    return render(request,'webcase_manage.html', {"user": username,"webcases":webcase_list})



# 搜索功能
@login_required

def webstepsearch(request):
    
    username = request.session.get('user', '') # 读取浏览器登录session
    
    search_webcasename = request.GET.get("webcasename", "")
    
    webcasestep_list = Webcasestep.objects.filter(webcasename__icontains=search_webcasename) 
    
    return render(request,'webcasestep_manage.html', {"user": username,"webcasesteps":webcasestep_list})
# web测试报告


@login_required

def webtest_report(request):
    
    username = request.session.get('user', '')
    
    return render(request, "webtest_report.html")
