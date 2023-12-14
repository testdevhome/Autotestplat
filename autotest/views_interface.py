# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.6
############################################
import json,traceback,re,copy,os,requests,hashlib,redis,random,time,string,ast
from django.http import HttpResponseRedirect
from django.shortcuts import render_to_response
from django.db import connection
from django.db.models import Q
from django.db.models import Max
from django.core.cache import cache
from django.template.context_processors import csrf
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from .models import *
from datetime import datetime
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from faker import Faker
from hashlib import md5
import hashlib
import requests
import hashlib,string

current_dir = os.getcwd()
logfile = os.path.join(current_dir, 'autotest', 'test_out.log')
codefile= os.path.join(current_dir, 'autotest', 'code.jpg')
cache = redis.Redis(host='localhost', port=6379, db=0)
session = requests.Session()
fake = Faker("zh_CN")

@login_required
def api_testcase(req):
    username = req.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser==1:
        interfaces = AutotestplatInterfaceTestcase.objects.filter().order_by('-id').all()
        product_all = AutotestplatProduct.objects.all()
    else:
        user_product_id = AuthUser.objects.filter(username=username).first().last_name
        try:
            interfaces = AutotestplatInterfaceTestcase.objects.filter(product_id=user_product_id).order_by('-id').all()
        except:
            interfaces = AutotestplatInterfaceTestcase.objects.filter().order_by('-id').all()
        product_id = AuthUser.objects.filter(username=username).first().last_name
        product_all = AutotestplatProduct.objects.filter(id=product_id).all()
    for i in interfaces:
        tmp_ids = AutotestplatProduct.objects.all().values_list().order_by('id')
        tmp = []
        for tmp_id in tmp_ids:
            tmp.append(tmp_id[0])
        if (i.product_id == None):
            count = 0
        else:
            count = tmp.count(int(i.product_id))
        if count > 0:
            product_name = AutotestplatProduct.objects.filter(id=int(i.product_id)).first().product_name
            i.product_id=product_name
    paginator = Paginator(interfaces, 10)
    num = len(interfaces)
    page = req.GET.get('page', 1)
    try:
        page_list = paginator.page(page)
    except PageNotAnInteger:
        page_list = paginator.page(1)
    except EmptyPage:
        page_list = paginator.page(paginator.num_pages)
    c = csrf(req)
    c.update({'page_list': page_list, 'interfaces': interfaces, 'type': type,'num':num,"product_alls":product_all})
    return render_to_response("interface_testcase.html",c)

def show_add_window(req):
    head_dict = {'Cookie':'','Accept':'','Content-Type':'application/json; charset=utf-8'}
    head_json = json.dumps(head_dict, sort_keys=True, indent=8).encode().decode('raw_unicode_escape')
    public_list = AutotestplatParameter.objects.all()
    username = req.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        product_all = AutotestplatProduct.objects.all()
        env_para = AutotestplatParameter.objects.filter(type="env")
        auth_para = AutotestplatParameter.objects.filter(type="auth")
    else:
        product_id = AuthUser.objects.filter(username=username).first().last_name
        product_all = AutotestplatProduct.objects.filter(id=product_id).all()
        env_para = AutotestplatParameter.objects.filter(product_id=product_id,type="env")
        auth_para = AutotestplatParameter.objects.filter(product_id=product_id,type="auth")
    c = csrf(req)
    c.update({'head_json': head_json,'public_list': public_list,"env_paras":env_para,"auth_paras":auth_para,"product_alls":product_all})
    return render_to_response("interface_add.html",c)

def add_interfaces(req):
    if req.method == "POST":
        add_name = req.POST.get('add_name','')
        add_url_host = req.POST.get('add_url_host', '')
        add_url = req.POST.get('add_url','')
        add_product_name = req.POST.get('add_product_id', '')
        add_product_id = AutotestplatProduct.objects.filter(product_name=add_product_name).first().id
        formated_dict = req.POST.get('formated_dict','')
        add_creator = req.session.get('user', '')
        add_head_key = req.POST.getlist('head_key','')
        add_params_key = req.POST.getlist('params_key','')
        add_mode = req.POST.get('mode','')
        add_cookie = req.POST.get('add_cookie','')
        # body_format = req.POST.get('body_format','')
        assert_keywords_old = req.POST.get('assert_keywords_old', '')
        resp_add_name = req.POST.getlist('resp_add_name','')
        if(add_head_key != ['']):
            add_head_value = req.POST.getlist('head_value','')
            add_head = {key: value for key, value in zip(add_head_key, add_head_value)}
            add_head = json.dumps(add_head)
        else:
            add_head = ''
        if (add_params_key != ['']):
            add_params_value = req.POST.getlist('params_value', '')
            add_params = {key: value for key, value in zip(add_params_key, add_params_value)}
            add_params = json.dumps(add_params)
        else:
            add_params =''
        if(add_params!='' and add_params!=None):
            body_format='FORM'
            formated_dict = add_params
        else:
            body_format="JSON"
        # add_head = eval(str(add_head))
        add_body = formated_dict.replace('null','None')
        base_info1 = AutotestplatInterfaceTestcase(name=add_name,url_host=add_url_host,url=add_url,head=add_head,body=add_body,body_format=body_format,mode=add_mode,charger=add_creator,product_id=add_product_id,update_cookie=add_cookie,assert_keywords='',assert_keywords_is_contain='1',assert_use_new='',assert_keywords_old=assert_keywords_old)
        base_info1.save()
        if(resp_add_name != ['']):
            resp_add_keywords = req.POST.getlist('resp_add_keywords','')
            resp_add_left = req.POST.getlist('resp_add_left','')
            resp_add_right = req.POST.getlist('resp_add_right','')
            resp_add_index = req.POST.getlist('resp_add_index','')
            tmp_list = AutotestplatInterfaceTestcase.objects.aggregate(Max('id'))
            max_id = tmp_list['id__max']
            for i in range(len(resp_add_name)):
                resp_info1 = AutotestplatParameter(name=resp_add_name[i],keywords=resp_add_keywords[i],value='',left=resp_add_left[i],right=resp_add_right[i],index=resp_add_index[i],product_id=add_product_id,module_id=max_id,type='res')
                resp_info1.save()
        return HttpResponseRedirect('/autotest/apitestcase/')

def show_edit_interface(req,edit_id,action):
    interface_list_tmp = AutotestplatInterfaceTestcase.objects.filter(id=edit_id)
    product_name = AutotestplatProduct.objects.filter(id=interface_list_tmp[0].product_id).first().product_name
    interface_list = interface_list_tmp[0]
    head1 = eval(interface_list.head)
    tmp_head = {'Accept':'','Content-Type':'','Cookie':''}
    tmp = ['Accept','Content-Type','Cookie']
    for rec in list(head1.keys()):
        if(rec not in tmp):
            tmp.append(rec)
    for rec in tmp:
        if(rec in list(head1.keys())):
            tmp_head[rec] = head1[rec]
    mode = interface_list.mode
    if(mode == ''):
        mode = 'false'
    update_cookie = interface_list.update_cookie
    if(interface_list.body !=''):
        para_dict = json.dumps(eval(interface_list.body), sort_keys=True).encode().decode('raw_unicode_escape')
        para_str = json.dumps(eval(interface_list.body), sort_keys=True, indent=8).encode().decode('raw_unicode_escape')
    else:
        para_dict=''
        para_str=''
    head = json.dumps(tmp_head, sort_keys=True, indent=8).encode().decode('raw_unicode_escape')
    body_format = interface_list.body_format
    if(body_format == ''):
        params = ''
        body_format = 'false'
    elif(body_format == 'FORM' or body_format=='form'):
        params = para_str
        para_str = ''
    else:
        params = ''
    username = req.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        product_all = AutotestplatProduct.objects.all()
        env_para = AutotestplatParameter.objects.filter(type="env")
        auth_para = AutotestplatParameter.objects.filter(type="auth")
    else:
        product_id = AuthUser.objects.filter(username=username).first().last_name
        product_all = AutotestplatProduct.objects.filter(id=product_id).all()
        env_para = AutotestplatParameter.objects.filter(product_id=product_id).filter(type="env")
        auth_para = AutotestplatParameter.objects.filter(product_id=product_id, type="auth")
    public_list_resp = AutotestplatParameter.objects.filter(module_id=int(edit_id)).filter(type='res')
    flag_resp = 'false'
    if(list(public_list_resp) != []):
        flag_resp = 'true'
    c = csrf(req)
    c.update({'edit_id': edit_id,'mode': mode,'body_format': body_format,'update_cookie': update_cookie,'interface_list_tmp': interface_list_tmp,'params':params,'head': head,'para_dict': para_dict,'para_str': para_str,'public_list_resp': public_list_resp,'flag_resp': flag_resp,'action': action,'env_paras': env_para,'auth_paras': auth_para,'product_alls':product_all,'product_name':product_name})
    return render_to_response("interface_edit.html",c)

def save_edit_interface(req,edit_id):
    if req.method == "POST":
        edit_name = req.POST.get('edit_name','')
        edit_url_host = req.POST.get('edit_url_host', '')
        edit_url = req.POST.get('edit_url','')
        edit_product_name = req.POST.get('edit_product_id', '')
        edit_product_id = AutotestplatProduct.objects.filter(product_name=edit_product_name).first().id
        formated_dict = req.POST.get('formated_dict','')
        edit_head_key = req.POST.getlist('head_key','')
        edit_auth_key = req.POST.getlist('auth_key','')
        edit_mode = req.POST.get('mode','')
        edit_params_key = req.POST.getlist('params_key', '')
        assert_keywords_old = req.POST.get('assert_keywords_old', '')
        resp_edit_name = req.POST.getlist('resp_edit_name','')
        if (edit_head_key != ['']):
            edit_head_value = req.POST.getlist('head_value', '')
            edit_head = {key: value for key, value in zip(edit_head_key, edit_head_value)}
            if(edit_auth_key !=['']):
                edit_auth_value = req.POST.getlist('auth_value','')
                edit_auth =  {key: value for key, value in zip(edit_auth_key, edit_auth_value)}
                merged_dict = {}
                merged_dict.update(edit_head)
                merged_dict.update(edit_auth)
                edit_head = json.dumps(merged_dict)
            edit_head = json.dumps(edit_head)
        else:
            edit_head = ''
        if (edit_params_key != ['']):
            edit_params_value = req.POST.getlist('params_value', '')
            edit_params = {key: value for key, value in zip(edit_params_key, edit_params_value)}
            edit_params = json.dumps(edit_params)
        else:
            edit_params =''
        if (edit_params != {"": ""} and edit_params != '{"": ""}' and edit_params != '' and edit_params != None):
            body_format = 'FORM'
            formated_dict = edit_params
        else:
            body_format = "JSON"
        edit_head = eval(str(edit_head))
        edit_body = formated_dict.replace('null','None')
        AutotestplatInterfaceTestcase.objects.filter(id=edit_id).update(name=edit_name,url_host=edit_url_host,url=edit_url,body=edit_body,head=edit_head,mode=edit_mode,product_id=edit_product_id,assert_keywords_old=assert_keywords_old,body_format=body_format)
        AutotestplatParameter.objects.filter(module_id=int(edit_id)).exclude(product_id='testplan').delete()
        if(resp_edit_name != ['']):
            resp_edit_keywords = req.POST.getlist('resp_edit_keywords','')
            resp_edit_left = req.POST.getlist('resp_edit_left','')
            resp_edit_right = req.POST.getlist('resp_edit_right','')
            resp_edit_index = req.POST.getlist('resp_edit_index','')
            for i in range(len(resp_edit_name)):
                resp_info1 = AutotestplatParameter(name=resp_edit_name[i],keywords=resp_edit_keywords[i],value='',left=resp_edit_left[i],right=resp_edit_right[i],index=resp_edit_index[i],product_id=edit_product_id,module_id=edit_id,type='res')
                resp_info1.save()
        return HttpResponseRedirect('/autotest/apitestcase')

def save_copy_interface(req,edit_id):
    if req.method == "POST":
        edit_name = req.POST.get('copy_name','')
        edit_url_host = req.POST.get('copy_url_host', '')
        edit_url = req.POST.get('copy_url','')
        edit_product_name = req.POST.get('copy_product_id', '')
        edit_product_id = AutotestplatProduct.objects.filter(product_name=edit_product_name).first().id
        formated_dict = req.POST.get('formated_dict','')
        edit_creator = req.session.get('user', '')
        edit_head_key = req.POST.getlist('head_key','')
        edit_auth_key = req.POST.getlist('auth_key', '')
        edit_mode = req.POST.get('mode','')
        edit_params_key = req.POST.getlist('params_key', '')
        assert_keywords_old = req.POST.get('assert_keywords_old', '')
        resp_edit_name = req.POST.getlist('resp_edit_name', '')
        if (edit_head_key != ['']):
            edit_head_value = req.POST.getlist('head_value', '')
            edit_head = {key: value for key, value in zip(edit_head_key, edit_head_value)}
            if (edit_auth_key != ['']):
                edit_auth_value = req.POST.getlist('auth_value', '')
                edit_auth = {key: value for key, value in zip(edit_auth_key, edit_auth_value)}
                merged_dict = {}
                merged_dict.update(edit_head)
                merged_dict.update(edit_auth)
                edit_head = json.dumps(merged_dict)
            edit_head = json.dumps(edit_head)
        else:
            edit_head = ''
        if (edit_params_key != ['']):
            edit_params_value = req.POST.getlist('params_value', '')
            edit_params = {key: value for key, value in zip(edit_params_key, edit_params_value)}
            edit_params = json.dumps(edit_params)
        else:
            edit_params = ''
        if (edit_params != {"": ""} and edit_params != '{"": ""}' and edit_params != '' and edit_params != None):
            body_format = 'FORM'
            formated_dict = edit_params
        else:
            body_format = "JSON"
        edit_head = eval(str(edit_head))
        edit_body = formated_dict.replace('null','None')
        interface_info1 = AutotestplatInterfaceTestcase(name=edit_name,url_host=edit_url_host,url=edit_url,charger=edit_creator,body=edit_body,head=edit_head,mode=edit_mode,product_id=edit_product_id,assert_keywords_old=assert_keywords_old,body_format=body_format,assert_keywords='',assert_keywords_is_contain='1',assert_use_new='')
        interface_info1.save()
        if(resp_edit_name != ['']):
            resp_edit_keywords = req.POST.getlist('resp_edit_keywords','')
            resp_edit_left = req.POST.getlist('resp_edit_left','')
            resp_edit_right = req.POST.getlist('resp_edit_right','')
            resp_edit_index = req.POST.getlist('resp_edit_index','')
            tmp_list = AutotestplatInterfaceTestcase.objects.aggregate(Max('id'))
            max_id = tmp_list['id__max']
            for i in range(len(resp_edit_name)):
                resp_info1 = AutotestplatParameter(name=resp_edit_name[i],keywords=resp_edit_keywords[i],value='',left=resp_edit_left[i],right=resp_edit_right[i],index=resp_edit_index[i],product_id=edit_product_id,module_id=max_id,type='res')
                resp_info1.save()
        return HttpResponseRedirect('/autotest/apitestcase')

def del_interface(req):
    if req.method == "POST":
        raw_data = req.body
        raw_data = json.loads(raw_data)
        id1 = raw_data['id1']
        AutotestplatInterfaceTestcase.objects.filter(id=id1).delete()
        AutotestplatParameter.objects.filter(module_id=int(id1)).exclude(product_id='testplan').delete()
        return HttpResponse('delete success!')

def search_interface(req):
    username = req.session.get('user', '')
    key_words_product_name = req.GET.get('key_words_product_name', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
        try:
            key_words_product_id = AutotestplatProduct.objects.filter(product_name=key_words_product_name).first().id
        except:
            key_words_product_id =''
    else:
        try:
            key_words_product_id = AutotestplatProduct.objects.filter(product_name=key_words_product_name).first().id
        except:
            key_words_product_id = AuthUser.objects.filter(username=username).first().last_name
    key_words_name = req.GET.get('key_words_name','')
    key_words_url = req.GET.get('key_words_url','')
    interfaces = AutotestplatInterfaceTestcase.objects.filter(Q(product_id__icontains=key_words_product_id),Q(name__icontains=key_words_name),Q(url__icontains=key_words_url)).order_by('order')
    for i in interfaces:
        tmp_ids = AutotestplatProduct.objects.all().values_list().order_by('id')
        tmp = []
        for tmp_id in tmp_ids:
            tmp.append(tmp_id[0])
        if (i.product_id == None):
            count = 0
        else:
            count = tmp.count(int(i.product_id))
        if count > 0:
            product_name = AutotestplatProduct.objects.filter(id=int(i.product_id)).first().product_name
            i.product_id=product_name
    paginator = Paginator(interfaces, 10)
    num = len(interfaces)
    page = req.GET.get('page', 1)
    try:
        page_list = paginator.page(page)
    except PageNotAnInteger:
        page_list = paginator.page(1)
    except EmptyPage:
        page_list = paginator.page(paginator.num_pages)
    c = csrf(req)
    c.update({'page_list': page_list, 'interfaces': interfaces, 'type': type, 'num': num})
    return render_to_response("interface_testcase.html",c)

def print_log(var1,HH = True):
    File = logfile
    File1 = open(File, 'a', encoding='utf-8')
    if (HH == ','):
        print(var1, )
        File1.write(var1)
    else:
        print(var1)
        File1.write(str(var1) + '\n')
    File1.close()
    pass

def assert_is_success(result,assert_keywords,is_contain,is_out = True):
    if(is_contain == '1'):
        print_log('\n【断言】： ' + assert_keywords)
        if(assert_keywords in result):
            if(is_out == True):
                print_log('【测试结果】： 测试通过')
            else:
                print_log('测试结果： 测试通过')
            return 0
        else:
            if(is_out == True):
                print_log('【测试结果】： 测试失败，断言不匹配')
            else:
                print_log('测试结果： 测试失败，断言不匹配')
            return 1
    elif(is_contain == '0'):
        print_log('\n【断言】： ' + assert_keywords)
        if(assert_keywords not in result):
            if(is_out == True):
                print_log('【测试结果】： 测试通过')
            else:
                print_log('测试结果： 测试通过')
            return 0
        else:
            if(is_out == True):
                print_log('【测试结果】： 测试失败，断言不匹配')
            else:
                print_log('测试结果： 测试失败，断言不匹配')
            return 1

def assert_test_old(response,assert_keywords_old,is_out):
    try:
        assert_keywords = assert_keywords_old.replace(' ','').replace('\n','').replace('\t','').replace('\r','')
        result = response.replace(' ','').replace('\n','').replace('\t','').replace('\r','')
        assert_result = assert_is_success(result,assert_keywords,'1',is_out)
        print_log('')
        return assert_result
    except Exception:
        error_info = traceback.format_exc()
        print_log(error_info)
        return 2

def start_interface_send(req):
    if req.method == "POST":
        raw_data = req.body
        raw_data = json.loads(raw_data)
        interface_name = raw_data['interface_name']
        public_list = AutotestplatParameter.objects.filter()
        keyword_list = ["{"+rec.keywords+"}" for rec in public_list]
        public_list1 = AutotestplatParameter.objects.filter(Q(type='con'))
        keyword_list1 = ["{"+rec.keywords+"}" for rec in public_list1]
        public_dict1 = {}
        for rec in public_list1:
            public_dict1[rec.keywords] = rec.value
        public_list4 = AutotestplatParameter.objects.filter(Q(type='env'))
        keyword_list4 = ["{"+rec.keywords+"}" for rec in public_list4]
        public_dict4 = {}
        for rec in public_list4:
            public_dict4[rec.keywords] = rec.value
        public_list5 = AutotestplatParameter.objects.filter(Q(type='var'))
        keyword_list5 = ["{"+rec.keywords+"}" for rec in public_list5]
        public_dict5 = {}
        for rec in public_list5:
            public_dict5[rec.keywords] = rec.value
        public_list2 = AutotestplatParameter.objects.filter(Q(type='res'))
        keyword_list2 = ["{"+rec.keywords+"}" for rec in public_list2]
        public_dict2 = {}
        for rec in public_list2:
            public_dict2[rec.keywords] = str((rec.left,rec.right,rec.index))
        public_list3 = AutotestplatParameter.objects.filter(Q(type='auth'))
        keyword_list3 = []
        for rec in public_list3:
            keyword_list3 = ["{"+rec.keywords+"}" for rec in public_list3]
        public_dict3 = {}
        for rec in public_list3:
            public_dict3[rec.keywords] = str((rec.name,rec.value,rec.login_account,rec.login_password,rec.left,rec.right,rec.keywords))
        public_dict = {}
        public_dict.update(public_dict1)
        public_dict.update(public_dict2)
        public_dict.update(public_dict4)
        public_dict.update(public_dict5)
        public_dict.update(public_dict3)
        f_handler = open(logfile, 'w')
        f_handler.truncate()
        f_handler.close()
        print_log('【接口名称】: ', ','), print_log(interface_name)
        print_log('【请求方式】: ', ','), print_log(raw_data['interface_mode'])
        url_host = raw_data['interface_env']
        try:
            if("{" in url_host and "}" in url_host):
                end_index = url_host.find("}")
                key_url_host = url_host[:end_index+1]
                url_host = url_host.replace(key_url_host,public_dict[key_url_host.replace('{','').replace('}','').replace(' ','')])
        except:
            return HttpResponse('【ERROR】：url_host参数 ' + url_host + ' 有误，请重新修改 ')
        url = raw_data['interface_url']
        try:
           if("{" in url and "}" in url):
               end_index = url.find("}")
               start_index = url.find("{")
               key_url = url[start_index:end_index+1]
               if (key_url in keyword_list1):
                   url = url.replace(key_url,public_dict[key_url.replace('{','').replace('}','')])
               elif (key_url in keyword_list5):
                   url_tmp = public_dict[key_url.replace('{', '').replace('}', '')]
                   url=url.replace(key_url,str(eval(url_tmp)))
               elif (key_url in keyword_list2):
                   try:
                       url = url.replace(key_url, cache.get(key_url.replace('{','').replace('}','')).decode('utf-8'))
                   except Exception:
                       error_info = traceback.format_exc()
                       print(error_info)
                       return HttpResponse(
                           '【ERROR】：参数 ' + url + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + url + ' 的前置接口，以及确认Redis是否已启动')
        except:
            return HttpResponse('【ERROR】：url参数 ' + url + ' 有误，请重新修改 ')
        url = url_host+url
        head_list = raw_data['interface_head']
        head=json.loads(json.dumps(head_list))
        head=eval(str(head))
        for rec in head.keys():
            head[rec]=head[rec].replace(" ","")
            if(head[rec] in keyword_list1):
                head[rec] = public_dict[head[rec].replace('{','').replace('}','')]
            elif (head[rec] in keyword_list4):
                head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
            elif (head[rec] in keyword_list5):
                head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                head[rec] = str(eval(head[rec]))
            elif (head[rec] in keyword_list3):
                head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                h = head[rec]
                h = ast.literal_eval(h)
                url_value = url_host+h[1]
                username_value = h[2]
                password_value = h[3]
                method_value = "post"
                left_value = h[4].replace('"','\\"')
                right_value = h[5].replace('"', '\\"')
                keywords_value = h[6]
                token_fun = rec+ '('+'"' +url_value +'"' + "," + '"' +method_value +'"' + "," + '"' +username_value +'"' + "," + '"' +password_value +'"' + "," +'"' +left_value +'"'+ "," +'"'+ right_value +'"'+ "," +'"' + keywords_value +'"' + ')'
                head[rec] = str(eval(token_fun))
            elif(head[rec] in keyword_list2):
                try:
                    head[rec] = cache.get(head[rec].replace('{','').replace('}','')).decode('utf-8')
                except Exception:
                    error_info = traceback.format_exc()
                    print(error_info)
                    return HttpResponse('【ERROR】：参数 '+head[rec]+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+head[rec]+' 的前置接口，以及确认Redis是否已启动')
        is_login_api = False
        n = 0
        while (n < 5):
            if (raw_data['interface_params'] != {'': ''} and raw_data['interface_params'] != '{"": ""}' and raw_data['interface_params'] != '' and raw_data['interface_params'] != None):
                body_format = 'FORM'
                body = raw_data['interface_params']
            else:
                body_format = 'JSON'
                if raw_data['interface_body'] != '':
                    try:
                        body = eval(raw_data['interface_body'])
                        if not isinstance(body, dict):
                            return HttpResponse('【ERROR】：' + raw_data['interface_body'] + ' 接口录入信息有误，请重新修改')
                    except:
                        return HttpResponse('【ERROR】：' + raw_data['interface_body'] + ' 接口录入信息有误，请重新修改')
                else:
                    body = {}
            for rec in body.keys():
                if(isinstance(body[rec],str) or isinstance(body[rec],list) or isinstance(body[rec],dict)):
                    for rec1 in keyword_list1:
                        if(rec1 in body[rec]):
                            if('captcha' not in rec1):
                                body[rec] = body[rec].replace(rec1, public_dict[rec1.replace('{','').replace('}','')])
                            else:
                                is_login_api = True
                                yanzheng_url = public_dict[rec1.replace('{','').replace('}','')]
                                haha = request_get(yanzheng_url,{},{},0)
                                with open(codefile,'wb') as f:
                                    f.write(haha.content)
                                yanzheng = getcaptcha()
                                body[rec] = yanzheng
                                print_log('【登录验证码】：',','),print_log(yanzheng)
                    for rec5 in keyword_list5:
                        if (rec5 in str(body[rec])):
                            try:
                                var_name = public_dict[rec5.replace('{', '').replace('}', '')]
                                var_value = str(eval(var_name))
                                body = str(body).replace(rec5, var_name)
                                body = str(body).replace(var_name,var_value)
                                body=ast.literal_eval(body)
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                return HttpResponse('【ERROR】：参数 ' + rec5 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec5 + ' 的前置接口，以及确认Redis是否已启动')
                    for rec2 in keyword_list2:
                        if(rec2 in body[rec]):
                            try:
                                body[rec] = body[rec].replace(rec2, cache.get(rec2.replace('{','').replace('}','')).decode('utf-8'))
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                    for rec3 in keyword_list3:
                        if(rec3 in body[rec]):
                            try:
                                body[rec] = body[rec].replace(rec3,cache.get(rec3.replace('{', '').replace('}', '')).decode('utf-8'))
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                return HttpResponse(
                                    '【ERROR】：参数 ' + rec3 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec3 + ' 的前置接口，以及确认Redis是否已启动')
                    if('select' in body[rec]):
                        try:
                            sql = body[rec]
                            cursor = connection.cursor()
                            cursor.execute(sql)
                            data = cursor.fetchall()
                            print(u'查询的结果为： ',data[0][0])
                            body[rec] = data[0][0]
                        except Exception:
                            body[rec] = '【ERROR】：查询结果为空！'
            mode = raw_data['interface_mode']
            try:
                response,cookie = interface_test_start(url,body,head,mode,body_format,True)
            except:
                return HttpResponse('【ERROR】：' + url + ' 接口录入信息有误，请重新修改')
            if(raw_data['interface_id']!=''):
                id1=raw_data['interface_id']
                public_resp = AutotestplatParameter.objects.filter(module_id=int(id1)).exclude(product_id='testplan')
                if(str(public_resp) != '[]'):
                    for rec in public_resp:
                        left = rec.left
                        right = rec.right
                        index = int(rec.index)
                        reg = left+'.+?'+right
                        result_all = re.findall(reg,response)
                        try:
                            result_tmp = result_all[index]
                            start = len(left)
                            end = len(result_tmp) - len(right)
                            result = result_tmp[start:end]
                            cache.set(rec.keywords, result)
                            cache.expire(rec.keywords, 3600)
                            print_log('【关联参数】： {'+rec.keywords+'}，匹配的第'+str(index+1)+'个值为：'+result)
                        except Exception:
                            error_info = traceback.format_exc()
                            print(error_info)
                            print_log('【关联参数】： {' + rec.keywords +'} 在响应数据中未匹配到，请检测前置接口关键字配置，以及Redis是否已启动')
            assert_keywords_old = raw_data['interface_assert']
            for rec1 in keyword_list1:
                if(rec1 in assert_keywords_old):
                    assert_keywords_old = assert_keywords_old.replace(rec1, public_dict[rec1.replace('{','').replace('}','')])
            for rec2 in keyword_list2:
                if(rec2 in assert_keywords_old):
                    try:
                        assert_keywords_old = assert_keywords_old.replace(rec2, cache.get(rec2.replace('{','').replace('}','')))
                    except Exception:
                        error_info = traceback.format_exc()
                        print(error_info)
                        return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                if('select' in assert_keywords_old):
                    sql = assert_keywords_old
                    cursor = connection.cursor()
                    cursor.execute(sql)
                    data = cursor.fetchall()
                    print(u'查询的结果为： ',data[0][0])
                    assert_keywords_old = data[0][0]
            assert_result = assert_test_old(response,assert_keywords_old,True)
            if(is_login_api == True):
                if(assert_result != 0):
                    n += 1
                elif(assert_result == 0):
                    break
            else:
                break
        File = logfile
        File1 = open(File,'r',encoding='utf-8')
        test_log = File1.readlines()
        test_log = str(test_log)
        test_log = test_log.replace('<','[').replace('>',"]")
        test_log = eval(test_log)
        return HttpResponse(test_log)


def interface_test_start(url,body,head,mode,body_format,is_out):
    try:
        if(mode == 'POST' or mode == 'post'):
            response,cookie = Method_POST(url,body,head,body_format,is_out)
        elif(mode == 'GET' or mode == 'get'):
            response,cookie = Method_GET(url,body,head,body_format,is_out)
        elif(mode == 'PUT' or mode == 'put'):
            response,cookie = Method_PUT(url,body,head,body_format,is_out)
        elif (mode == 'DELETE' or mode == 'delete'):
            response, cookie = Method_DELETE(url, body, head, body_format, is_out)
        elif (mode == 'PATCH' or mode == 'patch'):
            response, cookie = Method_PATCH(url, body, head, body_format, is_out)
        elif (mode == 'HEAD' or mode == 'head'):
            response, cookie = Method_HEAD(url, body, head, body_format, is_out)
        elif (mode == 'OPTIONS' or mode == 'options'):
            response, cookie = Method_OPTIONS(url, body, head, body_format, is_out)
        print_log('')
        return response,cookie
    except Exception:
        error_info = traceback.format_exc()
        print_log(error_info)
        return 1

def request_post(url,body,head,body_format):
    if(body_format == 'JSON'):
        body = json.dumps(body)
    else:
        keys = body.keys()
        for rec in keys:
            if('[{' in str(body[rec]) and '}]' in str(body[rec])):
                body = json.dumps(body)
                break
    r = session.post(url,body,headers = head)
    return r

def request_get(url,body,head,body_format):
    if(body_format == 'JSON'):
        body = json.dumps(body)
    r = session.get(url,params = body, headers=head)
    return r

def request_put(url,body,head,body_format):
    if(body_format == 'JSON'):
        body = json.dumps(body)
    r = session.put(url,params = body, headers=head)
    return r

def request_delete(url,body,head,body_format):
    if(body_format == 'JSON'):
        body = json.dumps(body)
    r = session.delete(url,json = body, headers=head)
    return r

def request_patch(url,body,head,body_format):
    if(body_format == 'JSON'):
        body = json.dumps(body)
    r = session.patch(url,json = body, headers=head)
    return r

def request_head(url,body,head,body_format):
    if(body_format == 'JSON'):
        body = json.dumps(body)
    r = session.head(url,json = body, headers=head)
    return r

def request_options(url,body,head,body_format):
    if(body_format == 'JSON'):
        body = json.dumps(body)
    r = session.options(url,json = body, headers=head)
    return r

def Method_POST(url,body,head, body_format,is_out = True):
    starttime = datetime.now()
    r = request_post(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if(is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if(is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    '+str(r.reason))
        print_log('【响应数据】：', ','), print_log(str(response))
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒", ',')
    return response,cookie

def Method_GET(url, body, head, body_format,is_out = True):
    starttime = datetime.now()
    r = request_get(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if(is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：',','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if(is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    '+str(r.reason))
        print_log('【响应数据】：', ','),print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒", ',')
    return response,cookie

def Method_PUT(url, body, head, body_format,is_out = True):
    starttime = datetime.now()
    r = request_put(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if(is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if(is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    '+str(r.reason))
        print_log('【响应数据】：', ','),print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒")
    return response,cookie

def Method_DELETE(url, body, head, body_format,is_out = True):
    starttime = datetime.now()
    r = request_delete(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if(is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if(is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    '+str(r.reason))
        print_log('【响应数据】：', ','),print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒")
    return response,cookie

def Method_PATCH(url, body, head, body_format,is_out = True):
    starttime = datetime.now()
    r = request_patch(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if(is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if(is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    '+str(r.reason))
        print_log('【响应数据】：', ','),print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒")
    return response,cookie

def Method_HEAD(url, body, head, body_format,is_out = True):
    starttime = datetime.now()
    r = request_head(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if(is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if(is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    '+str(r.reason))
        print_log('【响应数据】：', ','),print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒")
    return response,cookie

def Method_OPTIONS(url, body, head, body_format,is_out = True):
    starttime = datetime.now()
    r = request_options(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if(is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if(is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    '+str(r.reason))
        print_log('【响应数据】：', ','),print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒")
    return response,cookie

def show_request_data(req):
    if req.method == "POST":
        raw_data = req.body
        raw_data = json.loads(raw_data)
        id1 = raw_data['id1']
        public_list = AutotestplatParameter.objects.filter()
        keyword_list = ["{"+rec.keywords+"}" for rec in public_list]
        public_list1 = AutotestplatParameter.objects.filter(Q(type='con'))
        keyword_list1 = ["{"+rec.keywords+"}" for rec in public_list1]
        public_dict1 = {}
        for rec in public_list1:
            public_dict1[rec.keywords] = rec.value
        public_list2 = AutotestplatParameter.objects.filter(Q(type='res'))
        keyword_list2 = ["{"+rec.keywords+"}" for rec in public_list2]
        public_dict2 = {}
        for rec in public_list2:
            public_dict2[rec.keywords] = str((rec.left,rec.right,rec.index))
        public_dict = {}
        public_dict.update(public_dict1)
        public_dict.update(public_dict2)
        f_handler = open(logfile, 'w')
        f_handler.truncate()
        f_handler.close()
        interfaces = AutotestplatInterfaceTestcase.objects.filter(id=id1)[0]
        url = interfaces.url
        if("{" in url and "}" in url):
            end_index = url.find("}")
            key_url = url[:end_index+1]
            url = url.replace(key_url,public_dict[key_url.replace('{','').replace('}','')])
        head = eval(interfaces.head)
        for rec in head.keys():
            if(head[rec] in keyword_list1):
                head[rec] = public_dict[head[rec].replace('{','').replace('}','')]
            elif(head[rec] in keyword_list2):
                try:
                    head[rec] = cache.get(head[rec].replace('{','').replace('}',''))
                except Exception:
                    error_info = traceback.format_exc()
                    print(error_info)
                    return HttpResponse('【ERROR】：参数 '+head[rec]+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+head[rec]+' 的前置接口，以及确认Redis是否已启动')
        body = eval(interfaces.body)
        for rec in body.keys():
            if(isinstance(body[rec],str)):
                for rec1 in keyword_list1:
                    if(rec1 in body[rec]):
                        if('captcha' not in rec1):
                            body[rec] = body[rec].replace(rec1, public_dict[rec1.replace('{','').replace('}','')])
                        else:
                            is_login_api = True
                            yanzheng_url = public_dict[rec1.replace('{','').replace('}','')]
                            haha = request_get(yanzheng_url,{},{},0)
                            with open(codefile,'wb') as f:
                                f.write(haha.content)
                            yanzheng = getcaptcha()
                            body[rec] = yanzheng
                            print_log('【登录验证码】：',','),print_log(yanzheng)
                for rec2 in keyword_list2:
                    if(rec2 in body[rec]):
                        try:
                            body[rec] = body[rec].replace(rec2, cache.get(rec2.replace('{','').replace('}','')))
                        except Exception:
                            error_info = traceback.format_exc()
                            print(error_info)
                            return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+rec2+' 的前置接口，以及确认Redis是否已启动')
                if('select' in body[rec]):
                    sql = body[rec]
                    cursor = connection.cursor()
                    print(sql)
                    cursor.execute(sql)
                    data = cursor.fetchall()
                    print(u'查询的结果为： ',data[0][0])
                    body[rec] = data[0][0]
        mode = interfaces.mode
        name = interfaces.name
        body_format = interfaces.body_format
        if(body_format == '0'):
            body_format1 = 'FORM'
        else:
            body_format1 = 'JSON'
        print_log('【接口名称】：'), print_log(name), print_log('')
        print_log('【请求URL】：'), print_log(url), print_log('')
        print_log('【请求head】：'), print_log(json.dumps(head,sort_keys=True).encode().decode('raw_unicode_escape')), print_log('')
        print_log('【请求方式】：', ','), print_log(mode), print_log('')
        print_log('【请求参数格式】：', ','), print_log(body_format1), print_log('')
        print_log('【请求参数】：'), print_log(json.dumps(body,sort_keys=True).encode().decode('raw_unicode_escape')), print_log('')
        File = logfile
        File1 = open(File,'r',encoding='utf-8')
        test_log = File1.readlines()
        test_log = str(test_log)
        test_log = test_log.replace('<','[').replace('>',"]")
        test_log = eval(test_log)
        return HttpResponse(test_log)


def token(url_value,method_value,username_value,password_value,left_value,right_value,keywords_value):
    header = {
        "Content-Type": "application/json;charset=UTF-8",
        "Nonce": fake.pystr(min_chars=32, max_chars=32),
        "Timestamp": str(round(time.time() * 1000))
    }
    url_ = url_value
    password_md5 = md5()
    password_md5.update(password_value.encode(encoding='utf-8'))
    # password_hash = hashlib.sha256(password_value.encode(encoding='utf-8'))
    json_ = {"account":username_value,"password":password_md5.hexdigest(),"authCode":""}
    if(method_value=='post' or method_value=='POST'):
        response = requests.post(url=url_, json=json_, headers=header,verify=False)
    else:
        response = requests.get(url=url_, json=json_, headers=header,verify=False)
    left_value=left_value
    right_value = right_value
    left = left_value
    right = right_value
    reg = left + '.+?' + right
    result_all = re.findall(reg, response.text)
    try:
        result_tmp = result_all[0]
        start = len(left)
        end = len(result_tmp) - len(right)
        result = result_tmp[start:end]
        cache.set(keywords_value, result)
        cache.expire(keywords_value, 3600)
        print_log('【关联参数】： {' + keywords_value + '}，匹配的第' + str(1) + '个值为：' + result)
    except Exception:
        error_info = traceback.format_exc()
        result='error : token value is not found'
        print(error_info)
        print_log('【关联参数】： {' + keywords_value + '} 在响应数据中未匹配到，请检测前置接口关键字配置，以及Redis是否已启动')
    return result

