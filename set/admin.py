# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
from django.contrib import admin

from set.models import Set

class SetAdmin(admin.ModelAdmin):
    list_display = ['setname', 'setvalue','id']

admin.site.register(Set)  # 把系统设置模块注册到django admin后台并能显示
