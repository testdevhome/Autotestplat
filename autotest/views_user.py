# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.6
############################################
import json,time
from .models import *
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from django.contrib.auth import login
from django.contrib import auth
from django.contrib.auth.hashers import make_password

def loginView(request):
    return render(request, 'login.html')

@csrf_exempt
def login(request):
    if request.method == "POST":
        username = request.POST.get('user', '')
        password = request.POST.get('pwd', '')
        user = auth.authenticate(username=username, password=password)
        if user is not None and user.is_active:
            auth.login(request, user)
            request.session['user'] = username
            return HttpResponse(f'登录成功')
        else:
            return HttpResponse(f'用户名或密码输入不正确')
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
    items = AuthUser.objects.all().values_list().order_by('id')
    rst = []
    for item in items:
        arr = []
        tmp_ids =AutotestplatProduct.objects.all().values_list().order_by('id')
        tmp = []
        for tmp_id in tmp_ids:
            tmp.append(tmp_id[0])
        if(item[6]==None or item[6]==''):
            count=0
        else:
            count = tmp.count(int(item[6]))
        if count>0:
            product_name=AutotestplatProduct.objects.filter(id=item[6]).first().product_name
            item_list = list(item)
            item_list[6] = product_name
            item = tuple(item_list)
        for j in item:
            arr.append(j)
        rst.append(arr)
    realRst = {'data': rst}
    return JsonResponse(realRst)

@csrf_exempt
def loadUserRoleSearch(request):
    role_name = []
    items = AuthUser.objects.filter().values('is_superuser').order_by('is_superuser').distinct()
    for item in items:
        if (item['is_superuser'] == 1):
            item['is_superuser'] = '管理员'
            role_name.append(item['is_superuser'])
        elif (item['is_superuser'] == 0):
            item['is_superuser'] = '普通用户'
            role_name.append(item['is_superuser'])
    rst = [role_name]
    return JsonResponse(rst, safe=False)


@csrf_exempt
def loadAddOptions(request):
    product_id = []
    items = AutotestplatProduct.objects.exclude(delete_flag='Y').values('product_name').order_by('id').distinct()
    for item in items:
        product_id.append(item['product_name'])
    rst = [product_id]
    return JsonResponse(rst, safe=False)

@csrf_exempt
def loadOptions(request):
    role_name = []
    items = AuthUser.objects.filter().values('is_superuser').order_by('is_superuser').distinct()
    for item in items:
        if (item['is_superuser'] == 1):
            item['is_superuser'] = '管理员'
            role_name.append(item['is_superuser'])
        elif (item['is_superuser'] == 0):
            item['is_superuser'] = '普通用户'
            role_name.append(item['is_superuser'])
    product_id = []
    items = AutotestplatProduct.objects.filter().values('product_name').order_by('id').distinct()
    for item in items:
        product_id.append(item['product_name'])
    rst = [role_name,product_id]
    return JsonResponse(rst, safe=False)

@csrf_exempt
def addUser(request):
    user_name = request.POST.get('username')
    user_pwd = request.POST.get('password')
    make_user_pwd = make_password(user_pwd)
    contact = request.POST.get('email')
    role_name = request.POST.get('is_superuser')
    if (role_name == '管理员'):
        role_name = 1
    elif (role_name == '普通用户'):
        role_name = 0
    product_name = request.POST.get('last_name')
    print(product_name)
    product_id = AutotestplatProduct.objects.filter(product_name=product_name).first().id
    is_staff = 1
    is_active = 1
    create_date = str(time.strftime("%Y-%m-%d"))
    user = AuthUser.objects.filter(username=user_name)
    if user:
        return HttpResponse(f'用户"{user_name}"已存在，请重新填写')
    AuthUser.objects.create(username=user_name,password=make_user_pwd,email=contact,is_superuser=role_name,last_name=product_id,is_staff=is_staff,is_active=is_active,date_joined=create_date)
    return HttpResponse('200')

@csrf_exempt
def deleteUser(request):
    id = request.POST.get('id')
    AuthUser.objects.filter(id=id).delete()
    return HttpResponse('200')

@csrf_exempt
def updateUser(request):
    id = request.POST.get('id')
    user_name = request.POST.get('username')
    user_pwd = request.POST.get('password')
    if user_pwd == "undefined":
        make_user_pwd=AuthUser.objects.filter(id=id).first().password
    else:
        make_user_pwd = make_password(user_pwd)
    contact = request.POST.get('email')
    role_name = request.POST.get('is_superuser')
    if (role_name == '管理员'):
        role_name = 1
    elif (role_name == '普通用户'):
        role_name = 0
    product_name= request.POST.get('last_name')
    product_id = AutotestplatProduct.objects.filter(product_name=product_name).first().id
    if AuthUser.objects.exclude(id=id).filter(username=user_name).exists():
        return HttpResponse(f'用户”{user_name}“已存在，请重新填写')
    AuthUser.objects.filter(id=id).update(username=user_name,password=make_user_pwd,email=contact,is_superuser=role_name,last_name=product_id)
    return HttpResponse('200')
