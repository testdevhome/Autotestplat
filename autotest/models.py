# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.6
############################################
from django.db import models

class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'

class AutotestplatProduct(models.Model):
    product_name = models.CharField(max_length=255, blank=True, null=True)
    product_type = models.CharField(max_length=255, blank=True, null=True)
    product_introduction = models.CharField(max_length=255, blank=True, null=True)
    charger = models.CharField(max_length=20, null=True)
    delete_flag = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'autotestplat_product'

class AutotestplatParameter(models.Model):
    name = models.CharField(max_length=100,null=True)
    keywords = models.CharField(max_length=100,null=True)
    value = models.TextField(null=True)
    left = models.TextField(null=True)
    right = models.TextField(null=True)
    index = models.CharField(max_length=20,null=True)
    product_id = models.CharField(max_length=20,null=True)
    module_id = models.CharField(max_length=20, null=True)
    type = models.CharField(max_length=20,null=True)
    login_account = models.CharField(max_length=20, null=True)
    login_password = models.CharField(max_length=20, null=True)

    def toJSON(self):
        import json
        return json.dumps(dict([(attr, getattr(self, attr)) for attr in [f.name for f in self._meta.fields]]))

    class Meta:
        managed = True
        db_table = 'autotestplat_parameter'

class AutotestplatInterfaceTestcase(models.Model):
    name = models.CharField(max_length=100,null=True)
    url_host = models.TextField(null=True)
    url = models.TextField(null=True)
    head = models.TextField(null=True)
    body_format = models.CharField(max_length=20,null=True)
    body = models.TextField(null=True)
    mode = models.CharField(max_length=30,null=True)
    charger = models.CharField(max_length=20,null=True)
    order = models.IntegerField(null=True)
    product_id = models.CharField(max_length=30,null=True)
    update_cookie = models.CharField(max_length=30,null=True)
    assert_use_new = models.CharField(max_length=10,null=True)
    assert_keywords_old = models.TextField(null=True)
    assert_keywords = models.TextField(null=True)
    assert_keywords_is_contain = models.CharField(max_length=10,null=True)

    class Meta:
        managed = True
        db_table = 'autotestplat_interface_testcase'

class AutotestplatTestplan(models.Model):
    suit_name = models.CharField(max_length=100,null=True)
    url_host = models.CharField(max_length=100, null=True)
    interface_name = models.TextField(null=True)
    interface_name_display = models.TextField(null=True)
    charger = models.CharField(max_length=20,null=True)
    product_id = models.IntegerField(null=True)
    task_id = models.IntegerField(null=True)
    task_progress = models.IntegerField(null=True)
    interface_num = models.IntegerField(null=True)
    run_time = models.CharField(max_length=20, null=True)
    class Meta:
        managed = True
        db_table = 'autotestplat_testplan'

class AutotestplatTestplanInterface(models.Model):
    suit_id = models.IntegerField(null=True)
    suit_name = models.CharField(max_length=100,null=True)
    interface_id = models.IntegerField(null=True)
    interface_name = models.CharField(max_length=200,null=True)
    url = models.TextField(null=True)
    head = models.TextField(null=True)
    body_format = models.CharField(max_length=20,null=True)
    body = models.TextField(null=True)
    mode = models.CharField(max_length=10,null=True)
    update_cookie = models.CharField(max_length=30,null=True)
    assert_use_new = models.CharField(max_length=10,null=True)
    assert_keywords_old = models.TextField(null=True)
    assert_keywords = models.TextField(null=True)
    assert_keywords_is_contain = models.CharField(max_length=10,null=True)

    class Meta:
        managed = True
        db_table = 'autotestplat_testplan_interface'

class AutotestplatTestplanInterfaceResult(models.Model):
    report_id = models.CharField(max_length=20,null=True)
    product_id = models.IntegerField(null=True)
    product_name = models.CharField(max_length=255, blank=True, null=True)
    suit_id = models.IntegerField(null=True)
    suit_name = models.CharField(max_length=100, null=True)
    suit_interface_id = models.IntegerField(null=True)
    interface_name = models.CharField(max_length=200,null=True)
    url = models.CharField(max_length=100,null=True)
    body = models.CharField(max_length=200,null=True)
    mode = models.CharField(max_length=20,null=True)
    assert_keywords_old = models.CharField(max_length=20,null=True)
    task_mode = models.CharField(max_length=20,null=True)
    response = models.TextField(null=True)
    response_time = models.TextField(null=True)
    result = models.CharField(max_length=20,null=True)
    pass_pers = models.CharField(max_length=20, null=True)
    date_time = models.CharField(max_length=20,null=True)

    class Meta:
        managed = True
        db_table = 'autotestplat_testplan_interface_result'

class AutotestplatTestplanInterfaceOrder(models.Model):
    suit_id = models.IntegerField( null=True)
    interface_id = models.IntegerField(null=True)

    class Meta:
        managed = True
        db_table = 'autotestplat_testplan_interface_order'


class PaginatorTask:
    def __init__(self,obj_count=1,obj_perpage=1,pagetag_current=1,pagetag_dsp_count=1):
        self.obj_count=obj_count
        self.obj_perpage=obj_perpage
        try:
            pagetag_current=int(pagetag_current)
            if pagetag_current < 1:
                pagetag_current=1
            self.pagetag_current=pagetag_current
        except Exception as e:
            self.pagetag_current=1
        self.pagetag_dsp_count=pagetag_dsp_count
        self.pagetag_all_count=self.last_page

    @property
    def obj_slice_start(self):
        return (self.pagetag_current-1)*self.obj_perpage

    @property
    def obj_slice_end(self):
        return self.pagetag_current* self.obj_perpage

    @property
    def has_prev_page(self):
        return False if self.pagetag_current <= self.first_page else True

    @property
    def has_next_page(self):
        return False if self.pagetag_current >= self.last_page else True

    @property
    def prev_page(self):
        if self.pagetag_current==1:
            return 1
        elif self.pagetag_current > self.pagetag_all_count:
            return self.pagetag_all_count
        else:
            return self.pagetag_current-1

    @property
    def next_page(self):
        if self.pagetag_current >= self.pagetag_all_count:
            return self.pagetag_all_count
        else:
            return self.pagetag_current+1

    @property
    def first_page(self):
        return 1

    @property
    def last_page(self):
        if self.obj_count % self.obj_perpage == 0:
            pagecount=int(self.obj_count / self.obj_perpage)
        else:
            pagecount = int(self.obj_count / self.obj_perpage)+1
        return pagecount

    @property
    def pagetag_range(self):
        if self.pagetag_dsp_count%2==1:
            before=int(self.pagetag_dsp_count/2)
            after=before
        else:
            before=int(self.pagetag_dsp_count/2)
            after=before-1
        if self.pagetag_all_count < self.pagetag_dsp_count:
            start=1
            end=self.pagetag_all_count+1
        elif self.pagetag_current <= before:
            start=1
            end=self.pagetag_dsp_count+1
        elif self.pagetag_current >= self.pagetag_all_count - after:
            start=self.pagetag_all_count - self.pagetag_dsp_count +1
            end=self.pagetag_all_count+1
        else:
            start=self.pagetag_current - before
            end=self.pagetag_current + after +1
        return range(start, end)

