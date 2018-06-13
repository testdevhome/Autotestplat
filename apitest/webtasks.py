# -*- coding:utf-8 -*-

from _ast import Assert
import requests, time, sys, re
import urllib, zlib 
import pymysql 
from lib2to3.tests.support import driver

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

global driver2

@app.task       
def webauto_testcase(self):            #流程 的 相关接口   
    self.driver2 =webdriver.Firefox()
    self.driver2.get("http://www.baidu.com")
    sql="SELECT b.id,b.webfindmethod,b.webevelement,b.weboptmethod,b.webtestdata,b.webassertdata,b.`webtestresult`,a.webcasename,b.webteststep from webtest_webcasestep as b,webtest_webcase as a where b.Webcase_id=a.id AND b.Webcase_id=1 ORDER BY id ASC " 
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    aa=cursor.execute(sql)
    info = cursor.fetchmany(aa)
    for ii in info:   
        case_list = []
        case_list.append(ii)
        webtestcase(self,case_list)
    coon.commit()
    cursor.close()
    coon.close()
    self.driver2.quit()

@app.task       
def webauto_testcase2(self):            #流程 的 相关接口   
    self.driver2 =webdriver.Firefox()
    self.driver2.get("http://www.baidu.com")
    sql="SELECT b.id,b.webfindmethod,b.webevelement,b.weboptmethod,b.webtestdata,b.webassertdata,b.`webtestresult`,a.webcasename,b.webteststep from webtest_webcasestep as b,webtest_webcase as a where b.Webcase_id=a.id AND b.Webcase_id=2 ORDER BY id ASC " 
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    aa=cursor.execute(sql)
    info = cursor.fetchmany(aa)
    for ii in info:   
        case_list = []
        case_list.append(ii)
        webtestcase(self,case_list)
    coon.commit()
    cursor.close()
    coon.close()
    self.driver2.quit()



def webtestcase(self,case_list):  
    for case in case_list:
        try:   
            case_id = case[0]
            findmethod = case[1] 
            evelement = case[2]
            optmethod = case[3]
            testdata = case[4]
            res_check = case[5]
            webcasename = case[7]
            webteststep = case[8]
        except Exception as e:
            return '测试用例格式不正确！%s'%e
        print (case)
        time.sleep(2)
        if optmethod=='sendkeys' and findmethod=='find_element_by_id':
            print (evelement)
            self.driver2.find_element_by_id(evelement).send_keys(testdata)
            result = self.driver2.find_element_by_name(evelement).text
            if result == '':
                result = "null"
                res =  readRes(result, res_check)
                print(res)   
                if 'pass' == res:                
                    caseWriteResult(case_id,'1')
                else:
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,webcasename,webteststep,result,res_check)
            else:
                res =  readRes(result, res_check)
                print(res)   
                if 'pass' == res:                
                    caseWriteResult(case_id,'1')
                else:
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,webcasename,webteststep,result,res_check)
        elif optmethod=='click' and findmethod=='find_element_by_name':
            print (evelement)
            self.driver2.find_element_by_name(evelement).click()
            result = self.driver2.find_element_by_name(evelement).text
            if result == '':
                result = "null"
                res =  readRes(result, res_check)
                print(res)   
                if 'pass' == res:                
                    caseWriteResult(case_id,'1')
                else:
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,webcasename,webteststep,result,res_check)
            else:
                res =  readRes(result, res_check)
                print(res)   
                if 'pass' == res:                
                    caseWriteResult(case_id,'1')
                else:
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,webcasename,webteststep,result,res_check)
        elif optmethod=='click' and findmethod=='find_element_by_id':
            print (evelement)
            self.driver2.find_element_by_id(evelement).click()
            result = self.driver2.find_element_by_id(evelement).text
            if result == '':
                result = "null"
                res =  readRes(result, res_check)
                print(res)   
                if 'pass' == res:                
                    caseWriteResult(case_id,'1')
                else:
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,webcasename,webteststep,result,res_check)
            else:
                res =  readRes(result, res_check)
                print(res)   
                if 'pass' == res:                
                    caseWriteResult(case_id,'1')
                else:
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,webcasename,webteststep,result,res_check)  
        elif optmethod=='click' and findmethod=='find_element_by_classname':
            print (evelement)
            self.driver2.find_element_by_class_name(evelement).click()
            result = self.driver2.find_element_by_class_name(evelement).text
            if result == '':
                result = "null"
                res =  readRes(result, res_check)
                print(res)   
                if 'pass' == res:                
                    caseWriteResult(case_id,'1')
                else:
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,webcasename,webteststep,result,res_check)
            else:
                res =  readRes(result, res_check)
                print(res)   
                if 'pass' == res:                
                    caseWriteResult(case_id,'1')
                else:
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,webcasename,webteststep,result,res_check)
        elif optmethod=='click' and findmethod=='find_element_by_xpath':
            print (evelement)
            self.driver2.find_element_by_xpath(evelement).click()  
            print(self.driver2.find_element_by_xpath(evelement).text)
            result = self.driver2.find_element_by_xpath(evelement).text
            if result == '':
                result = "null"
                res =  readRes(result, res_check)
                print(res)   
                if 'pass' == res:                
                    caseWriteResult(case_id,'1')
                else:
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,webcasename,webteststep,result,res_check)
            else:
                res =  readRes(result, res_check)
                print(res)   
                if 'pass' == res:                
                    caseWriteResult(case_id,'1')
                else:
                    caseWriteResult(case_id,'0')
                    writeBug(case_id,webcasename,webteststep,result,res_check)
           
def caseWriteResult(case_id,result):
    result = result.encode('utf-8')
    now = time.strftime("%Y-%m-%d %H:%M:%S")
    sql = "UPDATE webtest_webcasestep set webtest_webcasestep.webtestresult=%s,webtest_webcasestep.create_time=%s where webtest_webcasestep.id=%s;"
    param = (result,now,case_id)
    print ('api autotest result is '+result.decode())
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql,param)
    coon.commit()
    cursor.close()
    coon.close()  

def readRes(res,res_check):
    res = res.replace('":"',"=").replace('":',"=")
    res_check = res_check.split(';')
    for s in res_check:
        if s in res:
            pass
        else:
            return  '错误，返回参数和预期结果不一致'+s
    return 'pass'

def writeBug(bug_id,webcasename,webteststep,result,res_check):
    webcasename = webcasename.encode('utf-8')
    res_check = res_check.encode('utf-8')
    webteststep = webteststep.encode('utf-8')
    now = time.strftime("%Y-%m-%d %H:%M:%S")
    bugname = str(bug_id)+ '_' + webcasename.decode() + '_出错了'
    bugdetail = '[测试步聚]<br />'+str(webteststep)+'<br/>'+'[预期结果]<br/>'+str(res_check)+'<br/>'+'<br/>'+'[实际结果]<br />'+'<br/>'+str(result)
    print (bugdetail)
    sql = "INSERT INTO `bug_bug` ("\
    "`bugname`,`bugdetail`,`bugstatus`,`buglevel`, `bugcreater`, `bugassign`,`created_time`,`Product_id`)  "\
    "VALUES ('%s','%s','激活','3','test', 'test', '%s', '11');"%(bugname,pymysql.escape_string(bugdetail),now)
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    cursor.execute(sql)
    coon.commit()
    cursor.close()
    coon.close()
 
