# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
from django.db import models

# Create your models here.

class Product(models.Model):
    productname = models.CharField('产品名称',max_length=64)  # 产品名称
    productdesc = models.CharField('产品描述',max_length=200)    # 产品描述
    producter = models.CharField('产品负责人',max_length=200,null=True)    # 产品负责人
    create_time = models.DateTimeField('创建时间',auto_now=True)  # 创建时间-自动获取当前时间
    class Meta:
        verbose_name = '产品管理'
        verbose_name_plural = '产品管理'
    def __str__(self):
        return self.productname
