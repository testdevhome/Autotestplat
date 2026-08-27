# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.6
############################################
import re,time,random,json
from .models import *
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from django.template.context_processors import csrf
from django.shortcuts import render_to_response
from .views_user import *
from django.contrib.auth import get_user_model

# def productView(request):
#     user_name = request.session.get('user', '')
#     product_all = AutotestplatProduct.objects.filter(delete_flag='N')
#     product_id = AuthUser.objects.filter(username=user_name).first().last_name
#     product_name = AutotestplatProduct.objects.filter(id=product_id).first().product_name
#     c = csrf(request)
#     c.update({"product_name":product_name,"product_alls":product_all})
#     return render_to_response("product.html",c)

def productView(request):
    user_name = request.session.get('user', '')

    # 检查用户是否登录
    if not user_name:
        # 用户未登录，重定向到登录页面或返回错误
        return redirect('/autotest/login/')

    # 获取用户对象并进行空值检查
    user = AuthUser.objects.filter(username=user_name).first()
    if user is None:
        # 用户不存在，返回错误
        return HttpResponse('用户不存在')

    product_all = AutotestplatProduct.objects.filter(delete_flag='N')
    product_id = user.last_name

    # 检查 product_id 是否存在
    if not product_id:
        # 用户没有关联产品，可能需要处理
        product_name = "未关联产品"
    else:
        product = AutotestplatProduct.objects.filter(id=product_id).first()
        if product is None:
            product_name = "产品不存在"
        else:
            product_name = product.product_name

    c = csrf(request)
    c.update({"product_name": product_name, "product_alls": product_all})
    return render_to_response("product.html", c)

@csrf_exempt
def loadProduct(request):
    items = AutotestplatProduct.objects.exclude(delete_flag='Y').values_list().order_by('id')
    rst = []
    for item in items:
        arr = []
        for j in item:
            arr.append(j)
        rst.append(arr)
    realRst = {'data': rst}
    return JsonResponse(realRst)

@csrf_exempt
def addProduct(request):
    product_name = request.POST.get('product_name')
    product_type = request.POST.get('product_type')
    product_introduction = request.POST.get('product_introduction')
    charger = request.session.get('user', '')
    delete_flag = 'N'
    if AutotestplatProduct.objects.filter(product_name=product_name,delete_flag='N').first() is not None:
        return HttpResponse(f'产品”{product_name}“已存在，请重新填写')
    AutotestplatProduct.objects.create(product_name=product_name, product_type=product_type, product_introduction=product_introduction,charger=charger,delete_flag=delete_flag)
    return HttpResponse('200')

@csrf_exempt
def deleteProduct(request):
    id = request.POST.get('id')
    delete_flag = 'Y'
    sn = AuthUser.objects.filter(last_name=id)
    if sn:
        return HttpResponse(f'在用户设置中，有人设置了默认正使用该产品，不能删除！')
    AutotestplatProduct.objects.filter(id=id).update(delete_flag=delete_flag)
    return HttpResponse('200')

@csrf_exempt
def updateProduct(request):
    id = request.POST.get('id')
    product_name = request.POST.get('product_name')
    product_type = request.POST.get('product_type')
    product_introduction = request.POST.get('product_introduction')
    if AutotestplatProduct.objects.exclude(id=id).filter(product_name=product_name).exists():
        return HttpResponse(f'产品”{product_name}“重复，请重新填写')
    AutotestplatProduct.objects.filter(id=id).update(id=id,product_name=product_name,product_type=product_type,product_introduction=product_introduction)
    return HttpResponse('200')
