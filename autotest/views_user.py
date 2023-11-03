# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.0
############################################
import json,time
from .models import *
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from django.contrib.auth import login

def loginView(request):
    return render(request, 'login.html')

@csrf_exempt
def login(request):
    if request.method == "POST":
        username = request.POST.get('user', '')
        password = request.POST.get('pwd', '')
        if username and password:
            exist_user = AutotestplatUser.objects.filter(user_name = username).first()
            if exist_user:
                exist_user_password = exist_user.user_pwd
                if exist_user_password == password:
                    return HttpResponse(f'登录成功')
                else:
                    return HttpResponse(f'用户密码输入不正确')
            else:
                return HttpResponse(f'用户名输入不正确')
        else:
            return HttpResponse(f'请输入正确用户名和密码')

@csrf_exempt
def lastLogin(request):
    if request.POST.get('user') != '':
        return HttpResponse('200')
    return HttpResponse('400')

@csrf_exempt
def logout(request):
    return HttpResponse('logout')

def userView(request):
    return render(request, "user.html")

@csrf_exempt
def loadUser(request):
    items = AutotestplatUser.objects.all().values_list().order_by('id')
    rst = []
    for item in items:
        arr = []
        for j in item:
            arr.append(j)
        rst.append(arr)
    realRst = {'data': rst}
    return JsonResponse(realRst)

@csrf_exempt
def loadUserRoleSearch(request):
    role_name = []
    items = AutotestplatUser.objects.filter().values('role_name').order_by('role_name').distinct()
    for item in items:
        role_name.append(item['role_name'])
    rst = [role_name]
    return JsonResponse(rst, safe=False)

@csrf_exempt
def loadOptions(request):
    role_name = []
    items = AutotestplatUser.objects.filter().values('role_name').order_by('role_name').distinct()
    for item in items:
        role_name.append(item['role_name'])
    rst = [role_name]
    return JsonResponse(rst, safe=False)

@csrf_exempt
def addUser(request):
    user_name = request.POST.get('user_name')
    user_pwd = request.POST.get('user_pwd')
    contact = request.POST.get('contact')
    role_name = request.POST.get('role_name')
    create_date = str(time.strftime("%Y-%m-%d"))
    user = AutotestplatUser.objects.filter(user_name=user_name)
    if user:
        return HttpResponse(f'用户"{user_name}"已存在，请重新填写')
    AutotestplatUser.objects.create(user_name=user_name,user_pwd=user_pwd,contact=contact,role_name=role_name,create_date=create_date)
    return HttpResponse('200')

@csrf_exempt
def deleteUser(request):
    id = request.POST.get('id')
    AutotestplatUser.objects.filter(id=id).delete()
    return HttpResponse('200')

@csrf_exempt
def updateUser(request):
    id = request.POST.get('id')
    user_name = request.POST.get('user_name')
    user_pwd = request.POST.get('user_pwd')
    contact = request.POST.get('contact')
    role_name = request.POST.get('role_name')
    if AutotestplatUser.objects.exclude(id=id).filter(user_name=user_name).exists():
        return HttpResponse(f'用户”{user_name}“已存在，请重新填写')
    AutotestplatUser.objects.filter(id=id).update(user_name=user_name,user_pwd=user_pwd,contact=contact,role_name=role_name)
    return HttpResponse('200')
