# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.0
############################################
import json,time
from django.db.models import Count
from .models import *
from datetime import datetime
from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from django.shortcuts import render_to_response
from django.http import HttpResponse,HttpResponseRedirect
from django.db import connection
def apitestreport(request):
    try:
        resent_time = AutotestplatTestplanInterfaceResult.objects.values('date_time').order_by('-date_time')[0]['date_time']
        cursor = connection.cursor()
        sql = 'select t1.id,t1.suit_name,t1.interface_name,t1.url,t1.head,t1.body,t1.`mode`,t1.assert_use_new,t1.assert_keywords,t1.assert_keywords_old,t2.response,t2.result,t2.date_time,t2.mode,t2.suit_id,t2.response_time from autotestplat_testplan_interface t1,autotestplat_testplan_interface_result t2 where t1.id=t2.suit_interface_id and t2.date_time="'+resent_time+'"'
        print(sql)
        cursor.execute(sql)
        test_result = cursor.fetchall()
        suit_id1 = test_result[0][14]
        apisuit_count = AutotestplatTestplanInterface.objects.filter(suit_id=suit_id1).count()
        pass_count = AutotestplatTestplanInterfaceResult.objects.filter(result="0",suit_id=suit_id1,date_time=resent_time).count()
        fail_count = AutotestplatTestplanInterfaceResult.objects.filter(result="1",suit_id=suit_id1,date_time=resent_time).count()
        ng_count = apisuit_count - pass_count - fail_count
        apis_pass_per = '{:.0%}'.format(pass_count / apisuit_count)
        apisuit_name = test_result[0][1]
        cursor.close()
        return render_to_response("interface_report.html", {'test_result': test_result, "apisuits_name":apisuit_name, "apisuit_counts": apisuit_count, 'pass_counts': pass_count, 'fail_counts': fail_count, 'ng_counts': ng_count, 'apis_pass_pers':apis_pass_per, 'resent_time':resent_time})
    except Exception:
        return render_to_response("interface_report.html")

def select_day(request):
    if request.method == "GET":
        input_day = request.GET.get('q','')
        tmp = AutotestplatTestplanInterfaceResult.objects.values('date_time').annotate(tt=Count('date_time')).order_by('-date_time')
        list_day = []
        for rec in tmp:
            day1 = rec['date_time'].split(' ')[0]
            if(day1 not in list_day):
                list_day.append(day1)
        day_list = []
        if(input_day == ''):
            for i in range(len(list_day)):
                day_list.append({'id':i+1,'text':list_day[i]})
        else:
            print(type(input_day),input_day)
            list_search = []
            for rec in list_day:
                if(input_day in rec):
                    list_search.append(rec)
            for i in range(len(list_search)):
                day_list.append({'id':i+1,'text':list_search[i]})
        return HttpResponse(json.dumps(day_list), content_type='application/json')

def select_time(request):
    if request.method == "GET":
        input_time = request.GET.get('q','')
        day1 = request.GET.get('day11','')
        tmp = AutotestplatTestplanInterfaceResult.objects.values('date_time').annotate(tt=Count('date_time')).order_by('-date_time')
        list_time = []
        for rec in tmp:
            day2 = rec['date_time'].split(' ')[0]
            if(day2 == day1):
                time1 = rec['date_time'].split(' ')[1]
                day_time = day1 + ' ' + time1
                suit_list = AutotestplatTestplanInterfaceResult.objects.filter(date_time=day_time).values('suit_id').annotate(tt=Count('suit_id')).order_by('-suit_id')
                suit_names = ''
                suit_id = suit_list[0]['suit_id']
                try:
                    tmp = AutotestplatTestplan.objects.filter(id=suit_id)[0].suit_name
                    suit_names += tmp + ','
                    suit_names = suit_names.rstrip(',')
                    list_time.append(time1+' 测试计划：'+suit_names)
                except Exception:
                    print('测试计划suit_id = ',suit_id,' 已被删除')
        time_list = []
        if(input_time == ''):
            for i in range(len(list_time)):
                time_list.append({'id':i+1,'text':list_time[i]})
        else:
            print(type(input_time),input_time)
            list_search = []
            for rec in list_time:
                if(input_time in rec):
                    list_search.append(rec)
            for i in range(len(list_search)):
                time_list.append({'id':i+1,'text':list_search[i]})
        return HttpResponse(json.dumps(time_list), content_type='application/json')

def reportsearch(request):
    try:
        day1 = request.GET.get('day1_input','')
        time1 = request.GET.get('time1_input','')
        time1 = time1.split(' ')[0]
        resent_time = day1 + ' ' + time1
        cursor = connection.cursor()
        sql = 'select t1.id,t1.suit_name,t1.interface_name,t1.url,t1.head,t1.body,t1.`mode`,t1.assert_use_new,t1.assert_keywords,t1.assert_keywords_old,t2.response,t2.result,t2.date_time,t2.mode,t2.suit_id,t2.response_time from autotestplat_testplan_interface t1,autotestplat_testplan_interface_result t2 where t1.id=t2.suit_interface_id and t2.date_time="'+resent_time+'"'
        cursor.execute(sql)
        test_result = cursor.fetchall()
        suit_id1 = test_result[0][14]
        apisuit_count = AutotestplatTestplanInterface.objects.filter(suit_id=suit_id1).count()
        pass_count = AutotestplatTestplanInterfaceResult.objects.filter(result="0",date_time=resent_time).count()
        fail_count = AutotestplatTestplanInterfaceResult.objects.filter(result="1",date_time=resent_time).count()
        ng_count = apisuit_count - pass_count - fail_count
        apis_pass_per = '{:.0%}'.format(pass_count / apisuit_count)
        apisuit_name = test_result[0][1]
        cursor.close()
        return render(request, 'interface_report.html',{'test_result': test_result,"apisuits_name":apisuit_name,"apisuit_counts": apisuit_count,'pass_counts': pass_count,'fail_counts': fail_count,'ng_counts': ng_count,'apis_pass_pers':apis_pass_per,'resent_time':resent_time})
    except Exception:
        print('【ERROR】：未查询到接口信息，接口可能被删除！')
        return HttpResponseRedirect("/autotest/apitestreport/")
