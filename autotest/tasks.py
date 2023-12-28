# -*- coding:utf-8 -*-
from Autotestplat.celery import app

@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))
