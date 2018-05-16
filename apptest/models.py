# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
from django.db import models
from product.models import Product
# Create your models here.

class Appcase(models.Model):
    Product = models.ForeignKey('product.Product',on_delete=models.CASCADE,null=True)        # 关联产品id
    appcasename = models.CharField('用例名称',max_length=200)       # 测试用例名称
    apptestresult = models.BooleanField('测试结果')                 # 测试结果
    apptester = models.CharField('测试负责人',max_length=16)        # 执行人
    create_time = models.DateTimeField('创建时间',auto_now=True)    # 创建时间-自动获取当前时间
    class Meta:
        verbose_name = 'app测试用例'
        verbose_name_plural = 'app测试用例'
    def __str__(self):
        return self.appcasename
	
class Appcasestep(models.Model):
    Appcase = models.ForeignKey('Appcase',on_delete=models.CASCADE)    # 关联接口id
    appteststep = models.CharField('测试步聚',max_length=200)        # 测试步聚
    apptestobjname = models.CharField('测试对象名称描述',max_length=200) # 测试对象名称描述
    appfindmethod = models.CharField('定位方式',max_length=200)      # 定位方式
    appevelement = models.CharField('控件元素',max_length=800)       # 控件元素
    appoptmethod = models.CharField('操作方法',max_length=200)       # 操作方法
    apptestdata = models.CharField('测试数据',max_length=200,null=True)       # 测试数据
    appassertdata = models.CharField('验证数据',max_length=200)      # 验证数据
    apptestresult = models.BooleanField('测试结果')                  # 测试结果
    create_time = models.DateTimeField('创建时间',auto_now=True)     # 创建时间-自动获取当前时间
    def __str__(self):
        return self.appteststep
