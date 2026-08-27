@echo off
REM 切换到项目根目录
cd /d D:\AutoTestProjects\Autotestplat

REM 删除旧的 pid 文件（如果存在）
if exist "celerybeat.pid" (
    echo [INFO] Removing old celerybeat.pid file...
    del /f /q "celerybeat.pid"
    echo [INFO] Old pid file removed.
)

python manage.py celery beat
pause