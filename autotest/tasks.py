# -*- coding:utf-8 -*-
from Autotestplat.celery import app


@app.task
def hello_world():
    print('已运行')

@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))
