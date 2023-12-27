@echo off
del /q /s "E:\Autotestplat\celerybeat.pid"
python manage.py celery beat
pause
