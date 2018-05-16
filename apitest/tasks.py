# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
import requests, time, sys, re
import urllib, zlib 
import pymysql 

import unittest
from trace import CoverageResults
import json
from idlelib.rpc import response_queue
from apitest.celery import app

from time import sleep

import os
from selenium import webdriver
#from appium import webdriver

PATH=lambda p:os.path.abspath(
os.path.join(os.path.dirname(__file__),p)                           
)

global driver

@app.task
def hello_world():
    print('已运行')

@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))
 
@app.task   
def apisauto_testcase():                             
    sql="SELECT id,`apiname`,apiurl,apimethod,apiparamvalue,apiresult,`apistatus` from apitest_apis " 
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    aa=cursor.execute(sql)
    info = cursor.fetchmany(aa)
    print (info)
    for ii in info:   
        case_list = []
        case_list.append(ii)
        interfaceTest1(case_list)  
    coon.commit()
    cursor.close()
    coon.close()
   
def interfaceTest1(case_list):
    res_flags = []
    request_urls = []
    responses = []
    strinfo = re.compile('{seturl}')
    for case in case_list:
        try:   
            case_id = case[0]
            interface_name = case[1] 
            method = case[3]
            url = case[2]
            param = case[4]
            res_check = case[5]
        except Exception as e:
            return '测试用例格式不正确！%s'%e
        if param== '':
            new_url = 'http://'+url
        elif param== 'null':
            url = strinfo.sub(str(seturl('seturl')),url)  
            new_url = 'http://'+ url
        else:
            url = strinfo.sub(str(seturl('seturl')),url)         
            new_url = 'http://'+url
            request_urls.append(new_url)
        if method.upper() == 'GET':
            headers = {'Authorization':'', 'Content-Type': 'application/json' }
            if "=" in urlParam(param):
                data = None
                print (str(case_id)+' request  is get' +new_url.encode('utf-8')+'?'+urlParam(param).encode('utf-8'))
                results = requests.get(new_url+'?'+urlParam(param),data,headers=headers).text
                print ('   response is get'+results.encode('utf-8'))
                responses.append(results)
                res = readRes(results,'')
            else:               
                print (' request  is get ' +new_url+'   body is '+urlParam(param))  
                data = None
                req = urllib.request.Request(url=new_url,data=data,headers=headers,method="GET")
                try:
                    results = urllib.request.urlopen(req).read()
                    print ('   response is get1 ')
                    print(results)
                except Exception as e:
                    return caseWriteResult1(case_id,results,'0')
                res = readRes(results,res_check)
                print(res) 
                if 'pass' == res:                
                    res_flags.append('pass') 
                    caseWriteResult1(case_id,results,'1')
                else:
                    res_flags.append('fail')
                    caseWriteResult1(case_id,results,'0')
                    writeBug(case_id,interface_name,new_url,results,res_check)
        if  method.upper()=='PUT':
            headers = {'Host':HOSTNAME, 'Connection':'keep-alive',  'CredentialId':id, 'Content-Type': 'application/json'}
            body_data=param
            results = requests.put(url=url,data=body_data,headers=headers) 
            responses.append(results)
            res = readRes(results,res_check)
            if 'pass' == res:
       #         writeResult(case_id,'pass')
                res_flags.append('pass') 
            else:
                res_flags.append('fail')
          #     writeResult(case_id,'fail')
                writeBug(case_id,interface_name,new_url,results,res_check)
        if method.upper()=="PATCH":
            headers = {'Authorization':'Credential '+id, 'Content-Type': 'application/json' }
            data = None
            results = requests.patch(new_url+'?'+urlParam(param),data,headers=headers).text
            responses.append(results)
            res = readRes(results,res_check)
            if 'pass' == res:
           #     writeResult(case_id,'pass')
                res_flags.append('pass') 
            else:
                res_flags.append('fail')
          #      writeResult(case_id,'fail')
                writeBug(case_id,interface_name,new_url,results,res_check)
                
        if method.upper()=="POST":
            headers = {'Authorization':'', 'Content-Type': 'application/json' }
            if "=" in urlParam(param):
                data = None
                print (str(case_id)+' request  is get' +new_url.encode('utf-8')+'?'+urlParam(param).encode('utf-8'))
                results = requests.get(new_url+'?'+urlParam(param),data,headers=headers).text
                print ('   response is get'+results.encode('utf-8'))
                responses.append(results)
                res = readRes(results,'')
            else:               
                print (' request  is get ' +new_url+'   body is '+urlParam(param))  
                data = None
                req = urllib.request.Request(url=new_url,data=data,headers=headers,method="POST")
                try:
                    results = urllib.request.urlopen(req).read()
                    print ('   response is get1 ')
                    print(results)
                except Exception as e:
                    return caseWriteResult1(case_id,results,'0')
                res = readRes(results,res_check)
                print(res) 
                if 'pass' == res:                
                    res_flags.append('pass') 
                    caseWriteResult1(case_id,results,'1')
                else:
                    res_flags.append('fail')
                    caseWriteResult1(case_id,results,'0')
                    writeBug(case_id,interface_name,new_url,results,res_check)
                                                   
def readRes(res,res_check):
    res = res.decode().replace('":"',"=").replace('":',"=")
    res_check = res_check.split(';')
    for s in res_check:
        if s in res:
            pass
        else:
            return  '错误，返回参数和预期结果不一致'+s
    return 'pass'

def urlParam(param):
    param1=param.replace('&quot;','"')
    return param1
    
def CredentialId():
    global id 
    url = 'http://'+'api.test.com.cn'+'/api/Security/Authentication/Signin/web'    
    body_data= json.dumps({"Identity":'test',"Password":'test'})      
    headers = { 'Connection':'keep-alive','Content-Type': 'application/json'}
    response = requests.post(url=url,data=body_data,headers=headers)  
    data=response.text
    regx = '.*"CredentialId":"(.*)","Scene"'
    pm = re.search(regx, data)
    id = pm.group(1) 
 
def seturl(set):
    global setvalue
    sql = "SELECT `setname`,`setvalue` from set_set"
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    aa=cursor.execute(sql)
    info = cursor.fetchmany(aa)
    print  (info)
    coon.commit()
    cursor.close()
    coon.close()
    if info[0][0] == set:
        setvalue = info[0][1]
        print (setvalue)
    return setvalue

    
def caseWriteResult1(case_id,response,result):
    result = result.encode('utf-8')
    now = time.strftime("%Y-%m-%d %H:%M:%S")
    sql = "UPDATE apitest_apis set apitest_apis.apiresponse=%s,apitest_apis.apistatus=%s,apitest_apis.create_time=%s where apitest_apis.id=%s;"
    param = (response,result,now,case_id)
    print ('api autotest result is '+result.decode())
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql,param)
    coon.commit()
    cursor.close()
    coon.close()    

def writeBug(bug_id,interface_name,request,response,res_check):
    interface_name = interface_name.encode('utf-8')
    res_check = res_check.encode('utf-8')
    request = request.encode('utf-8')
    now = time.strftime("%Y-%m-%d %H:%M:%S")
    bugname = str(bug_id)+ '_' + interface_name.decode() + '_出错了'
    bugdetail = '[请求数据]<br />'+request.decode()+'<br/>'+'[预期结果]<br/>'+res_check.decode()+'<br/>'+'<br/>'+'[响应数据]<br />'+'<br/>'+response.decode()
    print (bugdetail)
    sql = "INSERT INTO `bug_bug` ("\
    "`bugname`,`bugdetail`,`bugstatus`,`buglevel`, `bugcreater`, `bugassign`,`created_time`,`Product_id`)  "\
    "VALUES ('%s','%s','激活','3','邹辉', '邹辉', '%s', '2');"%(bugname,pymysql.escape_string(bugdetail),now)
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql)
    coon.commit()
    cursor.close()
    coon.close()
        

@app.task
def apitest_testcase(self):           
    sql="SELECT id,`apiname`,apiurl,apimethod,apiparamvalue,apiresult,`apistatus` from apitest_apistep where apitest_apistep.Apitest_id=2 " 
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    aa=cursor.execute(sql)
    info = cursor.fetchmany(aa)
    print (info)
    for ii in info:   
        case_list = []
        case_list.append(ii)
    #   CredentialId()
        interfaceTest(case_list)  
    coon.commit()
    cursor.close()
    coon.close()
   
def interfaceTest(case_list):
    res_flags = []
    request_urls = []
    responses = []
    strinfo = re.compile('{seturl}')
    strinfo2 = re.compile('{TaskId}')
    tasknoinfo = re.compile('{taskno}')
 #   schemainfo = re.compile('{schema}')
    for case in case_list:
        try:   
            case_id = case[0]
            interface_name = case[1] 
            method = case[3]
            url = case[2]
            param = case[4]
            res_check = case[5]
        except Exception as e:
            return '测试用例格式不正确！%s'%e
        if param== '':
            new_url = 'http://'+'api.test.com.cn'+url
        elif param== 'null':
            url = strinfo.sub(str(seturl('seturl')),url)  
            new_url = 'http://'+url
        else:
          #  url = schemainfo.sub(mod_config.getConfig('project', "schema"),url)
            url = strinfo.sub(str(seturl('seturl')),url)  
          #  url = strinfo2.sub(TaskId,url)
            param = strinfo.sub(TaskId,param)
            param = tasknoinfo.sub(taskno,param)
            new_url = 'http://'+url
            request_urls.append(new_url)
        if method.upper() == 'GET':
          #  print str(case_id)+' ' +new_url
            headers = {'Authorization':'', 'Content-Type': 'application/json' }
            if "=" in urlParam(param):
                data = None
                print (str(case_id)+' request  is get' +new_url.encode('utf-8')+'?'+urlParam(param).encode('utf-8'))
                results = requests.get(new_url+'?'+urlParam(param),data,headers=headers).text
                print ('   response is get'+results.encode('utf-8'))
                responses.append(results)
                res = readRes(results,'')
            else:               
                print (' request  is get ' +new_url+'   body is '+urlParam(param))
              #  results = requests.get(new_url,headers=headers).text #data='',=urlParam(param)
                
                data = None
                req = urllib.request.Request(url=new_url,data=data,headers=headers,method="GET")
                results = urllib.request.urlopen(req).read()
                print ('   response is get ')
                print(results)
              #  responses.append(results)
                res = readRes(results,res_check)
            #print results
                if 'pass' == res:                
                    res_flags.append('pass') 
                    writeResult(case_id,results,'1')
                    caseWriteResult(case_id,'1')
                else:
                    res_flags.append('fail')
                    writeResult(case_id,results,'0')
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,interface_name,new_url,results,res_check)
        if  method.upper()=='PUT':
         #   print str(case_id)+'put'+' '+'http://'+'api.test.com.cn/api'+url
          #  print param
            headers = {'Host':HOSTNAME, 'Connection':'keep-alive',  'CredentialId':id, 'Content-Type': 'application/json'}
            body_data=param
            results = requests.put(url=url,data=body_data,headers=headers) 
            responses.append(results)
            res = readRes(results,res_check)
       #     print results
            if 'pass' == res:
                writeResult(case_id,'pass')
                res_flags.append('pass') 
            else:
                res_flags.append('fail')
                writeResult(case_id,'fail')
                writeBug(case_id,interface_name,new_url,results,res_check)
            try:
                preOrderSN(results)
            except:
                print ('ok')
        if method.upper()=="PATCH":
            headers = {'Authorization':'Credential '+id, 'Content-Type': 'application/json' }
            data = None
         #   print str(case_id)+' request  is ' +new_url+'?'+urlParam(param)
            results = requests.patch(new_url+'?'+urlParam(param),data,headers=headers).text
         #   print '   response is '+results
            responses.append(results)
            res = readRes(results,res_check)
            #print results
            if 'pass' == res:
                writeResult(case_id,'pass')
                res_flags.append('pass') 
            else:
                res_flags.append('fail')
                writeResult(case_id,'fail')
                writeBug(case_id,interface_name,new_url,results,res_check)
            try:
                preOrderSN(results)
            except:
                print ('ok')
        if method.upper()=="POST":
            headers = {'Authorization':'', 'Content-Type': 'application/json' }
            if "=" in urlParam(param):
                data = None
                print (str(case_id)+' request  is get' +new_url.encode('utf-8')+'?'+urlParam(param).encode('utf-8'))
                results = requests.get(new_url+'?'+urlParam(param),data,headers=headers).text
                print ('   response is get'+results.encode('utf-8'))
                responses.append(results)
                res = readRes(results,'')
            else:               
                print (' request  is get ' +new_url+'   body is '+urlParam(param))  
                data = None
                req = urllib.request.Request(url=new_url,data=data,headers=headers,method="POST")
                try:
                    results = urllib.request.urlopen(req).read()
                    print ('   response is get1 ')
                    print(results)
                except Exception as e:
                    return caseWriteResult1(case_id,results,'0')
                res = readRes(results,res_check)
                print(res) 
                if 'pass' == res:                
                    res_flags.append('pass') 
                    caseWriteResult1(case_id,results,'1')
                else:
                    res_flags.append('fail')
                    caseWriteResult1(case_id,results,'0')
                    writeBug(case_id,interface_name,new_url,results,res_check)
            try:
                TaskId(results)
            except:
                print ('ok1')
                                 
def readRes(res,res_check):
    res = res.decode().replace('":"',"=").replace('":',"=")
    res_check = res_check.split(';')
    for s in res_check:
        if s in res:
            pass
        else:
            return  '错误，返回参数和预期结果不一致'+s
    return 'pass'

def urlParam(param):
    param1=param.replace('&quot;','"')
    return param1
    
def CredentialId():
    global id 
    url = 'http://'+'api.test.com.cn'+'/api/Security/Authentication/Signin/web'    
    body_data= json.dumps({"Identity":'test',"Password":'test'})      
    headers = { 'Connection':'keep-alive','Content-Type': 'application/json'}
    response = requests.post(url=url,data=body_data,headers=headers)  
    data=response.text
    regx = '.*"CredentialId":"(.*)","Scene"'
    pm = re.search(regx, data)
    id = pm.group(1) 
 
def seturl(set):
    global setvalue
    sql = "SELECT `setname`,`setvalue` from set_set"
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    aa=cursor.execute(sql)
    info = cursor.fetchmany(aa)
    print  (info)
    coon.commit()
    cursor.close()
    coon.close()
    if info[0][0] == set:
        setvalue = info[0][1]
        print (setvalue)
    return setvalue

def preOrderSN(results):
    global preOrderSN 
    regx = '.*"preOrderSN":"(.*)","toHome"'
    pm = re.search(regx, results)
    if pm:
        preOrderSN = pm.group(1).encode('utf-8')
        return preOrderSN
    return False

def TaskId(results):
    global TaskId 
    regx = '.*"TaskId":(.*),"PlanId"'
    pm = re.search(regx, results)
    if pm:
        TaskId = pm.group(1).encode('utf-8')
      #  print TaskId
        return TaskId
    return False

def taskno(param):
    global taskno
    a = int(time.time())
    taskno='task_'+str(a)
    return taskno

def writeResult(case_id,response,result):
    result = result.encode('utf-8')
    now = time.strftime("%Y-%m-%d %H:%M:%S")
    sql = "UPDATE apitest_apistep set apitest_apistep.apiresponse=%s,apitest_apistep.apistatus=%s,apitest_apistep.create_time=%s where apitest_apistep.id=%s;"
    param = (response,result,now,case_id)
    print ('api autotest result is '+result.decode())
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql,param)
    coon.commit()
    cursor.close()
    coon.close()
    
def caseWriteResult(case_id,result):
    result = result.encode('utf-8')
    now = time.strftime("%Y-%m-%d %H:%M:%S")
    sql = "UPDATE apitest_apitest set apitest_apitest.apitestresult=%s,apitest_apitest.create_time=%s where apitest_apitest.id=%s;"
    param = (result,now,case_id)
    print ('api autotest result is '+result.decode())
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql,param)
    coon.commit()
    cursor.close()
    coon.close()    

def writeBug(bug_id,interface_name,request,response,res_check):
    interface_name = interface_name.encode('utf-8')
    res_check = res_check.encode('utf-8')
    request = request.encode('utf-8')
    now = time.strftime("%Y-%m-%d %H:%M:%S")
    bugname = str(bug_id)+ '_' + interface_name.decode() + '_出错了'
    bugdetail = '[请求数据]<br />'+request.decode()+'<br/>'+'[预期结果]<br/>'+res_check.decode()+'<br/>'+'<br/>'+'[响应数据]<br />'+'<br/>'+response.decode()
    print (bugdetail)
    sql = "INSERT INTO `bug_bug` ("\
    "`bugname`,`bugdetail`,`bugstatus`,`buglevel`, `bugcreater`, `bugassign`,`created_time`,`Product_id`)  "\
    "VALUES ('%s','%s','激活','3','邹辉', '邹辉', '%s', '2');"%(bugname,pymysql.escape_string(bugdetail),now)
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql)
    coon.commit()
    cursor.close()
    coon.close()
        
