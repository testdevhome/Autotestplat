# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
from django.db import models

# Create your models here.

class Set(models.Model):
    setname = models.CharField('系统名称',max_length=64)  # 设置名称
    setvalue = models.CharField('系统设值',max_length=200)    # 设置值
    class Meta:
        verbose_name = '系统设置'
        verbose_name_plural = '系统设置'
    def __str__(self):
        return self.setname
