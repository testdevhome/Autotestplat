# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
from django.shortcuts import render
from product.models import Product
from django.http import HttpResponse,HttpResponseRedirect
from django.contrib.auth.decorators import login_required
from django.contrib import auth
from django.contrib.auth import authenticate, login
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger 

# Create your views here.

#产品管理
@login_required
def product_manage(request):
    username = request.session.get('user', '')
    product_list = Product.objects.all()
    product_count = Product.objects.all().count()
    paginator = Paginator(product_list, 8)  #生成paginator对象,设置每页显示5条记录
    page = request.GET.get('page',1)  #获取当前的页码数,默认为第1页
    currentPage=int(page)  #把获取的当前页码数转换成整数类型
    try:
        product_list = paginator.page(page)#获取当前页码数的记录列表
    except PageNotAnInteger:
        product_list = paginator.page(1)#如果输入的页数不是整数则显示第1页的内容
    except EmptyPage:
        product_list = paginator.page(paginator.num_pages)#如果输入的页数不在系统的页数中则显示最后一页的内容
    return render(request, "product_manage.html", {"user": username,"products": product_list,"productcounts": product_count})

# 搜索功能
@login_required
def productsearch(request):
    username = request.session.get('user', '') # 读取浏览器登录session
    search_productname = request.GET.get("productname", "")
    product_list = Product.objects.filter(productname__icontains=search_productname) 
    return render(request,'product_manage.html', {"user": username,"products":product_list})
