# -*- coding:utf-8 -*-
#####################################
#作者：邹辉《自动化平台测试开发》书
#日期：2018年1月
#版本：autotestplat V1.0
#####################################
from __future__ import absolute_import
import os
import django
from celery import Celery
from django.conf import settings

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'autotest.settings')
django.setup()

app = Celery('autotest')

app.config_from_object('django.conf:settings')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)

