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
def webauto_testcase(self):            #流程 的 相关接口   
    self.driver2 =webdriver.Firefox()
    self.driver2.get("http://www.baidu.com")
    sql="SELECT id,webfindmethod,webevelement,weboptmethod,webtestdata,webassertdata,`webtestresult` from webtest_webcasestep where webtest_webcasestep.Webcase_id=1 ORDER BY id ASC " 
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
    sql="SELECT id,webfindmethod,webevelement,weboptmethod,webtestdata,webassertdata,`webtestresult` from webtest_webcasestep where webtest_webcasestep.Webcase_id=2 ORDER BY id ASC " 
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
        except Exception as e:
            return '测试用例格式不正确！%s'%e
        print (case)
        time.sleep(5)
        if optmethod=='sendkeys' and findmethod=='find_element_by_id':
            print (evelement)
            self.driver2.find_element_by_id(evelement).send_keys(testdata)
        elif optmethod=='click' and findmethod=='find_element_by_name':
            print (evelement)
            self.driver2.find_element_by_name(evelement).click()
        elif optmethod=='click' and findmethod=='find_element_by_id':
            print (evelement)
            self.driver2.find_element_by_id(evelement).click()  
    
