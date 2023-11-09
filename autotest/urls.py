# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.0
############################################
from django.urls import path
from . import views, views_index, views_periodictask
from . import views_user
from . import views_product
from . import views_interface
from . import views_systemsettings
from . import views_interfacetestplan
from . import views_interfacereport

urlpatterns = [
    path('index/', views_index.indexView, name='index'),
    path('user/', views_user.userView, name='user'),
    path('user/getSearchSelect/', views_user.loadUserRoleSearch),
    path('user/getAddSelect/', views_user.loadAddOptions),
    path('user/getSelect/', views_user.loadOptions),
    path('user/getTableData/', views_user.loadUser),
    path('user/add/', views_user.addUser),
    path('user/mod/', views_user.updateUser),
    path('user/del/', views_user.deleteUser),
    path('login/', views_user.loginView, name='login'),
    path('login/identify/', views_user.login),
    path('login/last/', views_user.lastLogin),
    path('logout/', views_user.logout),
    path('systemsettings/', views_systemsettings.show_system_settings, name='parasettings'),
    path('systemsettings/getTableData/', views_systemsettings.loadSystemSettings),
    path('systemsettings/add/', views_systemsettings.add_settings_para),
    path('systemsettings/del/', views_systemsettings.del_settings_para),
    path('systemsettings/mod/', views_systemsettings.save_settings_para),
    path('systemsettings/getSearchSelect/', views_systemsettings.loadParaTypeSearch),
    path('systemsettings/getSelect/', views_systemsettings.loadParaOption),
    path('product/', views_product.productView, name='product'),
    path('product/getTableData/', views_product.loadProduct),
    path('product/add/', views_product.addProduct),
    path('product/mod/', views_product.updateProduct),
    path('product/del/', views_product.deleteProduct),
    path('apitestcase/', views_interface.api_testcase,name='apitestcase'),
    path('apitestcase/show_add_window/', views_interface.show_add_window),
    path('apitestcase/add/', views_interface.add_interfaces),
    path('apitestcase/format_body/', views_interface.format_body),
    path('apitestcase/search/', views_interface.search_interface),
    path('apitestcase/show_edit_interface/<str:edit_id>/<str:action>/', views_interface.show_edit_interface),
    path('apitestcase/save_edit_interface/<str:edit_id>/', views_interface.save_edit_interface),
    path('apitestcase/save_copy_interface/<str:edit_id>/', views_interface.save_copy_interface),
    path('apitestcase/del/', views_interface.del_interface),
    path('apitestcase/run/', views_interface.start_interface_test),
    path('apitestcase/show_request_data/', views_interface.show_request_data),
    path('apitestplan/', views_interfacetestplan.interface_testplan,name='apitestplan'),
    path('apitestplan/add/', views_interfacetestplan.add_testplan),
    path('apitestplan/show_edit_testplan/', views_interfacetestplan.show_edit_testplan),
    path('apitestplan/mod/', views_interfacetestplan.save_edit_testplan),
    path('apitestplan/del_row/', views_interfacetestplan.del_row),
    path('apitestplan/del_row_edit/', views_interfacetestplan.del_row_edit),
    path('apitestplan/del/', views_interfacetestplan.del_testplan),
    path('apitestplan/search/', views_interfacetestplan.search_testplan),
    path('apitestplan/apitestcase/search/', views_interfacetestplan.search_testplan_apitestcase),
    path('apitestplan/show_edit_testplan_interface/<str:para>/', views_interfacetestplan.show_edit_testplan_interface),
    path('apitestplan/save_edit_testplan_para/', views_interfacetestplan.save_edit_testplan_para),
    path('apitestplan/run/', views_interfacetestplan.start_interface_testplan),
    path('periodictask/', views_periodictask.periodic_task, name='periodictask'),
    path('periodictask/getTableData/', views_periodictask.loadPeriodicTask),
    path('periodictask/getSelect/', views_periodictask.loadOptions),
    path('periodictask/run/<str:suit_id>/<str:task_id>', views_periodictask.runPeriodictask),
    path('periodictask/task_open/<int:id>/', views_periodictask.task_open, name='task_open'),
    path('periodictask/search/', views_periodictask.tasksearch),
    path('periodictask/add/', views_periodictask.addPeriodictask),
    path('periodictask/mod/', views_periodictask.updatePeriodictask),
    path('periodictask/del/', views_periodictask.deletePeriodictask),
    path('report/', views_interfacereport.reportView, name='apireport'),
    path('report/getTableData/', views_interfacereport.loadReport),
    path('report/getReportDetail/<str:report_id>/', views_interfacereport.getReportDetail, name='reportdetail'),
    path('report/del/', views_interfacereport.deleteReport),
]