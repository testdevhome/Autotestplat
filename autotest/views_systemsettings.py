# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.7
############################################
import json,time,random
from .models import *
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from django.db.models import Q
from django.template.context_processors import csrf
from django.shortcuts import render_to_response
from django.contrib.auth.decorators import login_required
from faker import Faker
from hashlib import md5
import hashlib
import requests
import hashlib,string
from django.http import HttpResponseBadRequest, HttpResponseRedirect

fake = Faker("zh_CN")

@login_required
def showSystemSettings(request):
    username = request.session.get('user', '')
    user_product_id = AuthUser.objects.filter(username=username).first().last_name
    try:
        para_list = AutotestplatParameter.objects.filter(Q(product_id=user_product_id),~Q(type='res')).order_by('-id').all()
    except:
        para_list = AutotestplatParameter.objects.filter(~Q(type='res'))
    product_name = AutotestplatProduct.objects.all()
    c = csrf(request)
    c.update({'para_list': para_list,"product_names":product_name})
    return render_to_response("system_setting.html",c)

@csrf_exempt
@login_required
def loadSystemSettings(request):
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        items = AutotestplatParameter.objects.filter(~Q(type='res')).values_list().order_by('id')
    else:
        user_product_id = AuthUser.objects.filter(username=username).first().last_name
        try:
            items = AutotestplatParameter.objects.filter(Q(product_id=user_product_id), ~Q(type='res')).values_list().order_by('id')
        except:
            items = AutotestplatParameter.objects.filter(~Q(type='res')).values_list().order_by('id')
    rst = []
    for item in items:
        arr = []
        tmp_ids = AutotestplatProduct.objects.all().values_list().order_by('id')
        tmp = []
        for tmp_id in tmp_ids:
            tmp.append(tmp_id[0])
        if (item[7] == None):
            count = 0
        else:
            count = tmp.count(int(item[7]))
        if count > 0:
            product_name = AutotestplatProduct.objects.filter(id=int(item[7])).first().product_name
            item_list = list(item)
            item_list[7] = product_name
            item = tuple(item_list)
        for j in item:
            arr.append(j)
        rst.append(arr)
    realRst = {'data': rst}
    return JsonResponse(realRst)

@csrf_exempt
def loadParaTypeSearch(request):
    para_type = []
    items = AutotestplatParameter.objects.filter().values('type').order_by('type').distinct()
    for item in items:
        if (item['type']=='con'):
            item['type']='常量'
            para_type.append(item['type'])
        elif(item['type']=='var'):
            item['type']='变量'
            para_type.append(item['type'])
        elif(item['type']=='env'):
            item['type']='环境设置'
            para_type.append(item['type'])
        elif (item['type'] == 'auth'):
            item['type'] = '认证'
            para_type.append(item['type'])
        elif (item['type'] == 'app'):
            item['type'] = 'App设置'
            para_type.append(item['type'])
        elif (item['type'] == 'web'):
            item['type'] = 'Web设置'
            para_type.append(item['type'])
        else:
            pass
    rst = [para_type]
    return JsonResponse(rst, safe=False)

@csrf_exempt
def loadParaOption(request):
    username = request.session.get('user', '')
    product_name = []
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        items = AutotestplatProduct.objects.filter().values('product_name').order_by('product_name').distinct()
    else:
        product_id = AuthUser.objects.filter(username=username).first().last_name
        items = AutotestplatProduct.objects.filter(id=product_id).values('product_name').order_by('product_name').distinct()
    for item in items:
        product_name.append(item['product_name'])
    para_type = ['常量','变量','环境设置','认证','App设置','Web设置']
    rst = [product_name,para_type]
    return JsonResponse(rst, safe=False)

def addSettingsPara(request):
    product_name = request.POST.get('product_id')
    product_id = AutotestplatProduct.objects.filter(product_name=product_name).first().id
    type = request.POST.get('type')
    if(type=='常量'):
        type='con'
    elif(type=='变量'):
        type='var'
    elif(type=='环境设置'):
        type='env'
    elif (type == '认证'):
        type = 'auth'
    elif (type == 'App设置'):
        type = 'app'
    elif (type == 'Web设置'):
        type = 'web'
    name = request.POST.get('name')
    keywords = request.POST.get('keywords')
    value = request.POST.get('value')
    login_account = request.POST.get('login_account')
    login_password = request.POST.get('login_password')
    left = request.POST.get('left')
    right = request.POST.get('right')
    keywords_exist = AutotestplatParameter.objects.filter(keywords=keywords).first()
    if keywords_exist:
        return HttpResponse(f'关键字"{keywords}"在当前产品或其他产品中已存在，请重新填写')
    AutotestplatParameter.objects.create(product_id=product_id, type=type, name=name, keywords=keywords, value=value,login_account=login_account,login_password=login_password,left=left,right=right)
    return HttpResponse('200')

def delSettingsPara(request):
    if request.method == "POST":
        id = request.POST.get('id')
        AutotestplatParameter.objects.filter(id=id).delete()
        return HttpResponse('200')


def showModSettingsPara(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        id = raw_data['id1']
        para_infos = AutotestplatParameter.objects.filter(id=id)
        loginUserName = para_infos.first().login_account
        loginPassword = para_infos.first().login_password
        left = para_infos.first().left
        right = para_infos.first().right
        para_info = {'id': id,
                     'loginUserName': loginUserName,
                     'loginPassword':loginPassword,
                     'left':left,
                     'right':right,
                    }
        return HttpResponse(json.dumps(para_info), content_type='application/json')


def saveModSettingsPara(request):
    id = request.POST.get('id')
    product_name = request.POST.get('product_id')
    product_id = AutotestplatProduct.objects.filter(product_name=product_name).first().id
    type = request.POST.get('type')
    name = request.POST.get('name')
    keywords = request.POST.get('keywords')
    value = request.POST.get('value')
    login_account = request.POST.get('login_account')
    login_password = request.POST.get('login_password')
    left = request.POST.get('left')
    right = request.POST.get('right')
    if (type == '常量'):
        type = 'con'
    elif (type == '变量'):
        type = 'var'
    elif (type == '环境设置'):
        type = 'env'
    elif (type == '认证'):
        type = 'auth'
    elif (type == 'App设置'):
        type = 'app'
    elif (type == 'Web设置'):
        type = 'web'
    if AutotestplatParameter.objects.exclude(id=id).filter(keywords=keywords).exists():
        return HttpResponse(f'关键字”{keywords}“已存在，请重新填写')
    AutotestplatParameter.objects.filter(id=id).update(id=id, product_id=product_id,type=type,name=name,keywords=keywords,value=value,login_account=login_account,login_password=login_password,left=left,right=right)
    return HttpResponse('200')
