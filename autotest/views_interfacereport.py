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
from django.db.models import Count
from djcelery.models import PeriodicTask

def reportView(request):
    return render(request, "interface_report.html")

@csrf_exempt
def loadReport(request):
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        items = AutotestplatTestplanInterfaceResult.objects.all().values_list('report_id','task_id', 'suit_id', 'date_time','task_mode','pass_pers').annotate(Count('id'))
    else:
        product_id = AuthUser.objects.filter(username=username).first().last_name
        suits = AutotestplatTestplan.objects.filter(product_id=product_id).all()
        items = []
        for suit in suits:
            result = AutotestplatTestplanInterfaceResult.objects.filter(suit_id=suit.id).values_list('report_id','task_id', 'suit_id', 'date_time','task_mode','pass_pers').annotate(Count('id'))
            if result:
                items +=result
    rst = []
    for item in items:
        arr = []
        tmp_ids = PeriodicTask.objects.all().values_list().order_by('id')
        tmp = []
        for tmp_id in tmp_ids:
            tmp.append(tmp_id[0])
        if (item[1] == None or item[1] == ''):
            count = 0
        else:
            count = tmp.count(int(item[1]))
        if count > 0:
            task_name = PeriodicTask.objects.filter(id=item[1]).first().name
            item_list = list(item)
            item_list[1] = task_name
            item = tuple(item_list)
        tmp_ids2 = AutotestplatTestplanInterface.objects.all().values_list().order_by('id')
        tmp2 = []
        for tmp_id2 in tmp_ids2:
            tmp2.append(tmp_id2[1])
        if (item[2] == None or item[2] == ''):
            count = 0
        else:
            count = tmp2.count(int(item[2]))
        if count > 0:
            suit_name = AutotestplatTestplanInterface.objects.filter(suit_id=item[2]).first().suit_name
            item_list = list(item)
            item_list[2] = suit_name
            item = tuple(item_list)
        for j in item:
            arr.append(j)
        rst.append(arr)
    realRst = {'data': rst}
    return JsonResponse(realRst)

@csrf_exempt
def getReportDetail(request,report_id):
    items = AutotestplatTestplanInterfaceResult.objects.filter(report_id=report_id).all().order_by('id')
    testreport_id = report_id
    testplan_id = items.first().suit_id
    testplan_name = AutotestplatTestplanInterface.objects.filter(suit_id=testplan_id).first().suit_name
    testplan_time = items.first().date_time
    testcase_all_count = len(AutotestplatTestplanInterfaceResult.objects.filter(report_id=report_id).all().order_by('id'))
    testcase_pass_count = len(AutotestplatTestplanInterfaceResult.objects.filter(report_id=report_id).filter(result=0).order_by('id'))
    testcase_fail_count = len(AutotestplatTestplanInterfaceResult.objects.filter(report_id=report_id).filter(result=1).order_by('id'))
    testcase_norun_count = testcase_all_count-testcase_pass_count-testcase_fail_count
    testcase_pass_pers = '{:.0%}'.format(testcase_pass_count / testcase_all_count)
    return render(request, "interface_report_detail.html",{"test_result": items,"report_id":testreport_id,"testplan_name":testplan_name,"testcase_all_count":testcase_all_count,"testcase_pass_count":testcase_pass_count,"testcase_fail_count":testcase_fail_count,"testcase_norun_count":testcase_norun_count,"testcase_pass_pers":testcase_pass_pers,"testplan_time":testplan_time})

@csrf_exempt
def deleteReport(request):
    id = request.POST.get('report_id')
    AutotestplatTestplanInterfaceResult.objects.filter(report_id=id).delete()
    return HttpResponse('200')


