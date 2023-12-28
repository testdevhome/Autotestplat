# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.3
############################################
from __future__ import absolute_import
import os
from celery import Celery
import django
from django.conf import settings

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'Autotestplat.settings')
django.setup()

app = Celery('Autotestplat')

app.config_from_object('django.conf:settings')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)

app.conf.enable_utc = True
app.conf.timezone = "Asia/Shanghai"

@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))