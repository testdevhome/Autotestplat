# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
from django.db import models

from product.models import Product

# Create your models here.

class Apitest(models.Model):
    Product = models.ForeignKey('product.Product',on_delete=models.CASCADE,null=True)        # 关联产品id
    apitestname = models.CharField('流程接口名称',max_length=64)  # 流程接口 测试场景
    apitestdesc = models.CharField('描述',max_length=64,null=True)  # 流程接口 描述
    apitester = models.CharField('测试负责人',max_length=16)            # 执行人
    apitestresult = models.BooleanField('测试结果')                 # 流程接口测试结果
    create_time = models.DateTimeField('创建时间',auto_now=True)  # 创建时间-自动获取当前时间
    class Meta:
        verbose_name = '流程场景接口'
        verbose_name_plural = '流程场景接口'
    def __str__(self):
        return self.apitestname

class Apistep(models.Model):
    Apitest = models.ForeignKey('Apitest',on_delete=models.CASCADE,)        # 关联接口id
    apistep = models.CharField('测试步聚',max_length=100,null=True)         # 测试步聚
    apiname = models.CharField('接口名称',max_length=100)         # 接口名称描述
    apiurl = models.CharField('url地址',max_length=200)             # 地址
    REQUEST_METHOD = (('get', 'get'),('post', 'post'),('put', 'put'),('delete', 'delete'),('patch', 'patch'))
    apiparamvalue = models.CharField('请求参数和值',max_length=800)    # 参数和值
    apimethod = models.CharField(verbose_name='请求方法',choices = REQUEST_METHOD,default='get',max_length=200,null=True)  # 请求方法
    apiresult = models.CharField('预期结果',max_length=200)         # 预期结果
    apiresponse = models.CharField('响应数据',max_length=5000,null=True)    # 响应数据    
    apistatus = models.BooleanField('是否通过')                      # 测试结果
    create_time = models.DateTimeField('创建时间',auto_now=True)   # 创建时间-自动获取当前时间
    def __str__(self):
        return self.apistep

class Apis(models.Model):
    Product = models.ForeignKey('product.Product',on_delete=models.CASCADE,null=True)        # 关联产品id
    apiname = models.CharField('接口名称',max_length=100)         # 接口标题
    apiurl = models.CharField('url地址',max_length=200)             # 地址
    apiparamvalue = models.CharField('请求参数和值',max_length=800)    # 请求参数和值
    REQUEST_METHOD = (('get', 'get'),('post', 'post'),('put', 'put'),('delete', 'delete'),('patch', 'patch'))
    apimethod = models.CharField(verbose_name='请求方法',choices = REQUEST_METHOD,default='get',max_length=200,null=True)  # 请求方法
    apitester = models.CharField('测试负责人',max_length=16,null=True)            # 执行人    
    apiresult = models.CharField('预期结果',max_length=200)         # 预期结果
    apiresponse = models.CharField('响应数据',max_length=5000,null=True)    # 响应数据      
    apistatus = models.BooleanField('是否通过')                      # 测试结果
    create_time = models.DateTimeField('创建时间',auto_now=True)   # 创建时间-自动获取当前时间
    class Meta:
        verbose_name = '单一场景接口'
        verbose_name_plural = '单一场景接口'
    def __str__(self):
        return self.apiname
