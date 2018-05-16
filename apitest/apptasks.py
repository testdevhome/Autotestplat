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
from appium import webdriver

PATH=lambda p:os.path.abspath(
os.path.join(os.path.dirname(__file__),p)                           
)

global driver

@app.task    
def appauto_testcase(self):            #app例
    desired_caps = {}
    desired_caps['platformName'] = 'Android'
    desired_caps['platformVersion'] = '4.4'
    desired_caps['deviceName'] = 'emulator-5554'
    desired_caps['appPackage'] = 'com.android.calculator2'
    desired_caps['appActivity'] = '.Calculator'
    time.sleep(1)
    self.driver = webdriver.Remote('http://127.0.0.1:4723/wd/hub', desired_caps)
    time.sleep(1)
    sql="SELECT id,appfindmethod,appevelement,appoptmethod,appassertdata,`apptestresult` from apptest_appcasestep where apptest_appcasestep.Appcase_id=1 ORDER BY id ASC " 
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    aa=cursor.execute(sql)
    info = cursor.fetchmany(aa)
    for ii in info:   
        case_list = []
        case_list.append(ii)
        apptestcase(self,case_list)
    coon.commit()
    cursor.close()
    coon.close()
    self.driver.quit()


@app.task    
def appauto_testcase2(self):            #流程 的 相关接口
    desired_caps = {}
    desired_caps['platformName'] = 'Android'
    desired_caps['platformVersion'] = '4.4'
    desired_caps['deviceName'] = 'emulator-5554'
#   desired_caps['appPackage'] = 'com.android.calculator2'
#   desired_caps['appActivity'] = '.Calculator'
    desired_caps['app'] = PATH('csdn.apk')
    time.sleep(1)
    self.driver = webdriver.Remote('http://127.0.0.1:4723/wd/hub', desired_caps)
    time.sleep(1)
    sql="SELECT id,appfindmethod,appevelement,appoptmethod,appassertdata,`apptestresult` from apptest_appcasestep where apptest_appcasestep.Appcase_id=2 ORDER BY id ASC " 
    coon = pymysql.connect(user='root',passwd='test123456',db='autotest',port=3306,host='127.0.0.1',charset='utf8')
    cursor = coon.cursor()
    aa=cursor.execute(sql)
    info = cursor.fetchmany(aa)
    for ii in info:   
        case_list = []
        case_list.append(ii)
        apptestcase(self,case_list)
    coon.commit()
    cursor.close()
    coon.close()
    self.driver.quit()

def apptestcase(self,case_list):  
    for case in case_list:
        try:   
            case_id = case[0]
            findmethod = case[1] 
            evelement = case[2]
            optmethod = case[3]
        except Exception as e:
            return '测试用例格式不正确！%s'%e
        print (evelement)
        time.sleep(10)
        if optmethod== 'click' and findmethod=='find_element_by_id':
            self.driver.find_element_by_id(evelement).send_keys('test')
        elif optmethod== 'click' and findmethod=='find_element_by_name':
            self.driver.find_element_by_name(evelement).click()
        elif optmethod=='sendkey':
            self.driver.find_element_by_name(evelement).send_keys()
