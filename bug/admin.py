# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
from django.contrib import admin
from bug.models import Bug

class BugAdmin(admin.ModelAdmin):
    list_display = ['bugname ', 'bugdetail ', ' bugstatus', ' buglevel', ' bugcreater', ' bugassign', 'create_time','id']

admin.site.register(Bug)  # 把bug管理模块注册到django admin后台并能显示

