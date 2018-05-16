# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from set.models import Set
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.contrib.auth.models import User

#设置管理
@login_required
def set_manage(request):
    username = request.session.get('user', '')
    set_list = Set.objects.all()
    paginator = Paginator(set_list, 8)  #生成paginator对象,设置每页显示8条记录
    page = request.GET.get('page',1)  #获取当前的页码数,默认为第1页
    currentPage=int(page)  #把获取的当前页码数转换成整数类型
    try:
        set_list = paginator.page(page)#获取当前页码数的记录列表
    except PageNotAnInteger:
        set_list = paginator.page(1)#如果输入的页数不是整数则显示第1页的内容
    except EmptyPage:
        set_list = paginator.page(paginator.num_pages)#如果输入的页数不在系统的页数中则显示最后一页的内容
    return render(request, "set_manage.html", {"user": username,"sets": set_list})

# 搜索功能
@login_required
def setsearch(request):
     username = request.session.get('user', '') # 读取浏览器登录session
     search_setname = request.GET.get("setname", "")
     set_list = Set.objects.filter(setname__icontains=search_setname) 
     return render(request,'set_manage.html', {"user": username,"sets":set_list})

#用户管理
def set_user(request):
    user_list = User.objects.all()
    username = request.session.get('user','')
    return render(request, "set_user.html", {"user": username,"users": user_list})


# 搜索功能
@login_required
def usersearch(request):
    username = request.session.get('user', '') # 读取浏览器登录session
    search_username = request.GET.get("username", "")
    user_list = User.objects.filter(username__icontains=search_username) 
    return render(request,'set_user.html', {"user": username,"users":user_list})
