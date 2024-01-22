# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.6
############################################
import re,time,random,json,os
from .models import *
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from .views_user import *
from django.contrib.auth import get_user_model
from django.db.models import Count
from djcelery.models import PeriodicTask
from django.conf import settings
from django.http import StreamingHttpResponse
from django.template.context_processors import csrf
from django.shortcuts import render_to_response
from pdfkit import from_url
import pdfkit
def reportView(request):
    user_name = request.session.get('user', '')
    product_all = AutotestplatProduct.objects.filter(delete_flag='N')
    product_id = AuthUser.objects.filter(username=user_name).first().last_name
    product_name = AutotestplatProduct.objects.filter(id=product_id).first().product_name
    c = csrf(request)
    c.update({"product_name":product_name,"product_alls":product_all})
    return render_to_response("interface_report.html",c)

@csrf_exempt
def loadReport(request):
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        items = AutotestplatTestplanInterfaceResult.objects.all().values_list('report_id','product_id','product_name', 'suit_name', 'date_time','task_mode','pass_pers').annotate(Count('id'))
    else:
        product_id = AuthUser.objects.filter(username=username).first().last_name
        items = []
        result = AutotestplatTestplanInterfaceResult.objects.filter(product_id=product_id).values_list('report_id','product_id','product_name', 'suit_name', 'date_time','task_mode','pass_pers').annotate(Count('id'))
        if result:
            items +=result
    rst = []
    for item in items:
        arr = []
        for j in item:
            arr.append(j)
        rst.append(arr)
    realRst = {'data': rst}
    return JsonResponse(realRst)

@csrf_exempt
def getReportDetail(request,report_id):
    items = AutotestplatTestplanInterfaceResult.objects.filter(report_id=report_id).all().order_by('id')
    testreport_id = report_id
    testplan_name = items.first().suit_name
    testplan_time = items.first().date_time
    product_name = items.first().product_name
    testcase_all_count = len(AutotestplatTestplanInterfaceResult.objects.filter(report_id=report_id).all().order_by('id'))
    testcase_pass_count = len(AutotestplatTestplanInterfaceResult.objects.filter(report_id=report_id).filter(result=0).order_by('id'))
    testcase_fail_count = len(AutotestplatTestplanInterfaceResult.objects.filter(report_id=report_id).filter(result=1).order_by('id'))
    testcase_norun_count = testcase_all_count-testcase_pass_count-testcase_fail_count
    testcase_pass_pers = '{:.0%}'.format(testcase_pass_count / testcase_all_count)
    return render(request, "interface_report_detail.html",{"test_result": items,"report_id":testreport_id,"testplan_name":testplan_name,"testcase_all_count":testcase_all_count,"testcase_pass_count":testcase_pass_count,"testcase_fail_count":testcase_fail_count,"testcase_norun_count":testcase_norun_count,"testcase_pass_pers":testcase_pass_pers,"testplan_time":testplan_time,'product_name':product_name})

@csrf_exempt
def deleteReport(request):
    id = request.POST.get('report_id')
    AutotestplatTestplanInterfaceResult.objects.filter(report_id=id).delete()
    return HttpResponse('200')

