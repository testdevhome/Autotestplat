@echo off
python manage.py celery worker -c 6 -l debug
pause
