# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.0
############################################
import re,time,random,json
from .models import *
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from .views_user import *
from django.contrib.auth import get_user_model

def productView(request):
    '''
    :return:
    auther: fin
    '''
    return render(request, "product.html")

@csrf_exempt
def loadProduct(request):
    '''
    :return:
    auther: fin
    '''
    items = AutotestplatProduct.objects.all().values_list().order_by('id')
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
    '''
    :return:
    auther: fin
    '''
    product_name = request.POST.get('product_name')
    product_type = request.POST.get('product_type')
    product_introduction = request.POST.get('product_introduction')
    charger = request.POST.get('charger')
    product_name_exist = AutotestplatProduct.objects.filter(product_name=product_name).first()
    if product_name_exist:
        return HttpResponse(f'产品”{product_name}“已存在，请重新填写')
    AutotestplatProduct.objects.create(product_name=product_name, product_type=product_type, product_introduction=product_introduction,charger=charger)
    return HttpResponse('200')

@csrf_exempt
def deleteProduct(request):
    '''
    :return:
    auther: fin
    '''
    id = request.POST.get('id')
    AutotestplatProduct.objects.filter(id=id).delete()
    return HttpResponse('200')

@csrf_exempt
def updateProduct(request):
    '''
    :return:
    auther: fin
    '''
    id = request.POST.get('id')
    product_name = request.POST.get('product_name')
    product_type = request.POST.get('product_type')
    product_introduction = request.POST.get('product_introduction')
    charger = request.POST.get('charger')
    if AutotestplatProduct.objects.exclude(id=id).filter(product_name=product_name).exists():
        return HttpResponse(f'产品”{product_name}“重复，请重新填写')
    AutotestplatProduct.objects.filter(id=id).update(id=id,product_name=product_name,product_type=product_type,product_introduction=product_introduction,charger=charger)
    return HttpResponse('200')
