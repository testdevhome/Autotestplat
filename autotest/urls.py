
from django.contrib import admin
from django.urls import path
from apitest import views
from apptest import appviews
from webtest import webviews
from product import proviews
from set import setviews
from bug import bugviews

urlpatterns = [
    path('admin/', admin.site.urls),
  #  path('test/', views.test),
    path('task_apis/', views.task_apis),
    path('task_apitest/', views.task_apitest),
    path('task_webtest/', views.task_webtest),
    path('task_webtest2/', views.task_webtest2),
    path('task_apptest/', views.task_apptest),
    path('task_apptest2/', views.task_apptest2),
    path('login/', views.login),
    path('', views.login),
    path('logout/', views.logout),
    path('home/', views.home),
    path ('welcome/', views.welcome),
    path('product_manage/', proviews.product_manage),
    path('productsearch/', proviews.productsearch),
    path('apitest_manage/', views.apitest_manage),
    path('apistep_manage/', views.apistep_manage,name='apistep_manage'),
    path('left/', views.left),
    path('apisearch/', views.apisearch),
    path('apistepsearch/', views.apistepsearch),
    path('apissearch/', views.apissearch),
    path('apis_manage/', views.apis_manage),
    path('periodic_task/', views.periodic_task), 
    path('tasksearch/', views.tasksearch), 
    path('appcase_manage/', appviews.appcase_manage),
    path('appcasestep_manage/', appviews.appcasestep_manage,name='appcasestep_manage'),
    path('appsearch/', appviews.appsearch),
    path('appstepsearch/', appviews.appstepsearch),
    path('webcase_manage/', webviews.webcase_manage),
    path('webcasestep_manage/', webviews.webcasestep_manage,name='webcasestep_manage'),
    path('websearch/', webviews.websearch),
    path('webstepsearch/', webviews.webstepsearch),
    path('webtest_report/', webviews.webtest_report),
    path('apitest_report/', views.apitest_report),
    path('apptest_report/', appviews.apptest_report),
    path('test_report/', views.test_report),
    path('set_manage/', setviews.set_manage),
    path ('setsearch/', setviews.setsearch),
    path ('usersearch/', setviews.usersearch),
    path('user/', setviews.set_user),
    path('bug_manage/', bugviews.bug_manage),
    path ('bugsearch/', bugviews.bugsearch),

]
