# -*- coding:utf-8 -*-
############################################
#Auther:：Fin
#Version：Autotestplat-V2.0
############################################
import json,traceback,re,copy,os,requests,hashlib,redis,random,time
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

current_dir = os.getcwd()
logfile = os.path.join(current_dir, 'autotest', 'test_out.log')
codefile= os.path.join(current_dir, 'autotest', 'code.jpg')
cache = redis.Redis(host='localhost', port=6379, db=0)
session = requests.Session()

def api_testcase(req):
    interfaces = AutotestplatInterfaceTestcase.objects.filter().order_by('-id').all()
    product_all = AutotestplatProduct.objects.all()
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
    public_list = AutotestplatParameter.objects.exclude(type='con')
    env_para = AutotestplatParameter.objects.filter(type="env")
    product_all = AutotestplatProduct.objects.all()
    c = csrf(req)
    c.update({'head_json': head_json,'public_list': public_list,"env_paras":env_para,"product_alls":product_all})
    return render_to_response("interface_add.html",c)

def loadInterface(request):
    '''
    :return:
    auther: fin
    '''
    items = AutotestplatInterfaceTestcase.objects.all().values_list().order_by('id')
    rst = []
    for item in items:
        arr = []
        for j in item:
            arr.append(j)
        rst.append(arr)
    realRst = {'data': rst}
    return JsonResponse(realRst)

def add_interfaces(req):
    if req.method == "POST":
        add_name = req.POST.get('add_name','')
        add_url_host = req.POST.get('add_url_host', '')
        add_url = req.POST.get('add_url','')
        add_product_name = req.POST.get('add_product_name', '')
        formated_dict = req.POST.get('formated_dict','')
        add_creator = req.POST.get('add_creator','')
        add_head = req.POST.get('head','')
        add_mode = req.POST.get('mode','')
        add_cookie = req.POST.get('add_cookie','')
        body_format = req.POST.get('body_format','')
        assert_keywords_old = req.POST.get('assert_keywords_old', '')
        resp_add_name = req.POST.getlist('resp_add_name','')
        if('Error' not in formated_dict and formated_dict != ''):
            add_head = eval(add_head)
            add_body = formated_dict.replace('null','None')
            base_info1 = AutotestplatInterfaceTestcase(name=add_name,url_host=add_url_host,url=add_url,head=add_head,body=add_body,body_format=body_format,mode=add_mode,charger=add_creator,product_name=add_product_name,update_cookie=add_cookie,assert_keywords='',assert_keywords_is_contain='1',assert_use_new='',assert_keywords_old=assert_keywords_old)
            base_info1.save()
            if(resp_add_name != ['']):
                resp_add_keywords = req.POST.getlist('resp_add_keywords','')
                resp_add_left = req.POST.getlist('resp_add_left','')
                resp_add_right = req.POST.getlist('resp_add_right','')
                resp_add_index = req.POST.getlist('resp_add_index','')
                tmp_list = AutotestplatInterfaceTestcase.objects.aggregate(Max('id'))
                max_id = tmp_list['id__max']
                for i in range(len(resp_add_name)):
                    resp_info1 = AutotestplatParameter(name=resp_add_name[i],keywords=resp_add_keywords[i],value='',left=resp_add_left[i],right=resp_add_right[i],index=resp_add_index[i],product_name=add_product_name,module_id=max_id,type='res')
                    resp_info1.save()
            return HttpResponseRedirect('/autotest/apitestcase/')
        else:
            return HttpResponse(u'您没有点击”格式化"参数或参数错误，请点击浏览器【后退】按钮继续编辑！')

def show_edit_interface(req,edit_id,action):
    interface_list_tmp = AutotestplatInterfaceTestcase.objects.filter(id=edit_id)
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
    para_dict = json.dumps(eval(interface_list.body), sort_keys=True).encode().decode('raw_unicode_escape')
    para_str = json.dumps(eval(interface_list.body), sort_keys=True, indent=8).encode().decode('raw_unicode_escape')
    head = json.dumps(tmp_head, sort_keys=True, indent=8).encode().decode('raw_unicode_escape')
    body_format = interface_list.body_format
    if(body_format == ''):
        body_format = 'false'
    product_all = AutotestplatProduct.objects.all()
    public_list_resp = AutotestplatParameter.objects.filter(module_id=int(edit_id)).filter(type='res')
    flag_resp = 'false'
    if(list(public_list_resp) != []):
        flag_resp = 'true'
    env_para = AutotestplatParameter.objects.filter(type="env")
    c = csrf(req)
    c.update({'edit_id': edit_id,'mode': mode,'body_format': body_format,'update_cookie': update_cookie,'interface_list_tmp': interface_list_tmp,'head': head,'para_dict': para_dict,'para_str': para_str,'public_list_resp': public_list_resp,'flag_resp': flag_resp,'action': action,'env_paras': env_para,'product_alls':product_all})
    return render_to_response("interface_edit.html",c)

def save_edit_interface(req,edit_id):
    if req.method == "POST":
        edit_name = req.POST.get('edit_name','')
        edit_url_host = req.POST.get('edit_url_host', '')
        edit_url = req.POST.get('edit_url','')
        edit_product_name = req.POST.get('edit_product_name', '')
        formated_dict = req.POST.get('formated_dict','')
        edit_creator = req.POST.get('edit_creator','')
        edit_head = req.POST.get('head','')
        edit_mode = req.POST.get('mode','')
        body_format = req.POST.get('body_format','')
        assert_keywords_old = req.POST.get('assert_keywords_old', '')
        resp_edit_name = req.POST.getlist('resp_edit_name','')
        if('Error' not in formated_dict and formated_dict != ''):
            edit_head = eval(edit_head)
            edit_body = formated_dict.replace('null','None')
            AutotestplatInterfaceTestcase.objects.filter(id=edit_id).update(name=edit_name,url_host=edit_url_host,url=edit_url,charger=edit_creator,body=edit_body,head=edit_head,mode=edit_mode,product_name=edit_product_name,assert_keywords_old=assert_keywords_old,body_format=body_format)
            AutotestplatParameter.objects.filter(module_id=int(edit_id)).exclude(product_name='suit').delete()
            if(resp_edit_name != ['']):
                resp_edit_keywords = req.POST.getlist('resp_edit_keywords','')
                resp_edit_left = req.POST.getlist('resp_edit_left','')
                resp_edit_right = req.POST.getlist('resp_edit_right','')
                resp_edit_index = req.POST.getlist('resp_edit_index','')
                for i in range(len(resp_edit_name)):
                    resp_info1 = AutotestplatParameter(name=resp_edit_name[i],keywords=resp_edit_keywords[i],value='',left=resp_edit_left[i],right=resp_edit_right[i],index=resp_edit_index[i],product_name=edit_product_name,module_id=edit_id,type='res')
                    resp_info1.save()
            return HttpResponseRedirect('/autotest/apitestcase/show_edit_interface/'+edit_id+'/edit/')
        else:
            return HttpResponse(u'您没有点击”格式化"参数或参数错误，请点击浏览器【后退】按钮继续编辑！')

def save_copy_interface(req,edit_id):
    if req.method == "POST":
        edit_name = req.POST.get('edit_name','')
        edit_url_host = req.POST.get('edit_url_host', '')
        edit_url = req.POST.get('edit_url','')
        edit_product_name = req.POST.get('edit_product_name', '')
        formated_dict = req.POST.get('formated_dict','')
        edit_creator = req.POST.get('edit_creator','')
        edit_head = req.POST.get('head','')
        edit_mode = req.POST.get('mode','')
        body_format = req.POST.get('body_format','')
        assert_keywords_old = req.POST.get('assert_keywords_old', '')
        resp_edit_name = req.POST.getlist('resp_edit_name','')
        if('Error' not in formated_dict and formated_dict != ''):
            edit_head = eval(edit_head)
            edit_body = formated_dict.replace('null','None')
            interface_info1 = AutotestplatInterfaceTestcase(name=edit_name,url_host=edit_url_host,url=edit_url,charger=edit_creator,body=edit_body,head=edit_head,mode=edit_mode,product_name=edit_product_name,assert_keywords_old=assert_keywords_old,body_format=body_format,assert_keywords='',assert_keywords_is_contain='1',assert_use_new='')
            interface_info1.save()
            if(resp_edit_name != ['']):
                resp_edit_keywords = req.POST.getlist('resp_edit_keywords','')
                resp_edit_left = req.POST.getlist('resp_edit_left','')
                resp_edit_right = req.POST.getlist('resp_edit_right','')
                resp_edit_index = req.POST.getlist('resp_edit_index','')
                tmp_list = AutotestplatInterfaceTestcase.objects.aggregate(Max('id'))
                max_id = tmp_list['id__max']
                for i in range(len(resp_edit_name)):
                    resp_info1 = AutotestplatParameter(name=resp_edit_name[i],keywords=resp_edit_keywords[i],value='',left=resp_edit_left[i],right=resp_edit_right[i],index=resp_edit_index[i],product_name=edit_product_name,module_id=max_id,type='res')
                    resp_info1.save()
            return HttpResponseRedirect('/autotest/apitestcase')
        else:
            return HttpResponse(u'您没有点击”格式化"参数或参数错误，请点击浏览器【后退】按钮继续编辑！')

def del_interface(req):
    if req.method == "POST":
        raw_data = req.body
        raw_data = json.loads(raw_data)
        id1 = raw_data['id1']
        AutotestplatInterfaceTestcase.objects.filter(id=id1).delete()
        AutotestplatParameter.objects.filter(module_id=int(id1)).exclude(product_name='testplan').delete()
        return HttpResponse('delete success!')

def format_body(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        original_body = raw_data['original_body']
        fomated_body = {}
        if('<' in original_body or '>' in original_body):
            original_body = eval(original_body)
            for rec in original_body.keys():
                if(isinstance(original_body[rec],str)):
                    if('<' in original_body[rec] or '>' in original_body[rec]):
                        original_body[rec] = original_body[rec].replace('<','[[').replace('>',']]')
            original_body = str(original_body)
        try:
            if('{' in original_body and '}' in original_body):
                original_body = original_body.replace('null','None')
                fomated_body = eval(original_body)
            elif('=' in original_body and '&' not in original_body):
                original_body = original_body.split('=')
                tmp_value = original_body[1]
                if(tmp_value == 'null'):
                    fomated_body[original_body[0]] = None
                else:
                    fomated_body[original_body[0]] = tmp_value
            elif('=' in original_body and '&' in original_body):
                original_body = original_body.strip('&').replace('&&','&')
                equal_num = original_body.count('=')
                if(equal_num > 1):
                    original_body = original_body.split('&')
                    print(original_body)
                    tmp_key_list = []
                    for rec in original_body:
                        tmp = rec.split('=')
                        tmp = [rec1.replace(' ','') for rec1 in tmp]
                        key = tmp[0].replace('"','').replace("'",'')
                        value = tmp[1].strip(',').replace('"','').replace("'",'')
                        if key in fomated_body:
                            if (isinstance(fomated_body[key], list)):
                                if(None in fomated_body[key]):
                                    for i in range(len(fomated_body[key])):
                                        if(fomated_body[key][i] == None):
                                            fomated_body[key][i] = 'null'
                                tmp_key_str = ','.join(fomated_body[key])
                            else:
                                tmp_key_str = fomated_body[key]
                            key_str = str(tmp_key_str) + ',' + value
                            tmp_value = key_str.split(',')
                            print(tmp_value,'!!!')
                            if('null' in tmp_value or 'None' in tmp_value):
                                for i in range(len(tmp_value)):
                                    if(tmp_value[i] == 'null' or tmp_value[i] == 'None'):
                                        tmp_value[i] = None
                                fomated_body[key] = tmp_value
                            else:
                                fomated_body[key] = tmp_value
                        else:
                            if(value == 'null'):
                                fomated_body[key] = None
                            else:
                                fomated_body[key] = value
                else:
                    original_body = original_body.split('=')
                    tmp_value = original_body[1]
                    if(tmp_value == 'null'):
                        fomated_body[original_body[0]] = None
                    else:
                        fomated_body[original_body[0]] = original_body[1]
            else:
                original_body = original_body.split('\n')
                print(len(original_body),original_body)
                if(':' in original_body):
                    print('【case4】')
                    colon_num = original_body.count(':')
                    if(colon_num >= 1):
                        original_body = [rec.replace(' ','') for rec in original_body]
                        tmp_key_list = []
                        for i in range(0,len(original_body),3):
                            key = original_body[i].replace('"','').replace("'",'')
                            value = original_body[i+2].strip(',').replace('"','').replace("'",'')  #去掉'或"，避免输出的内容有\"
                            if key in fomated_body:
                                if(isinstance(fomated_body[key],list)):
                                    if(None in fomated_body[key]):
                                        for i in range(len(fomated_body[key])):
                                            if(fomated_body[key][i] == None):
                                                fomated_body[key][i] = 'null'
                                    tmp_key_str = ','.join(fomated_body[key])
                                else:
                                    tmp_key_str = fomated_body[key]
                                key_str = str(tmp_key_str) + ',' + value
                                tmp_value = key_str.split(',')
                                if('null' in tmp_value or 'None' in tmp_value):
                                    for i in range(len(tmp_value)):
                                        if(tmp_value[i] == 'null' or tmp_value[i] == 'None'):
                                            tmp_value[i] = None
                                    fomated_body[key] = tmp_value
                                else:
                                    fomated_body[key] = tmp_value
                            else:
                                if(value == 'null'):
                                    fomated_body[key] = None
                                else:
                                    fomated_body[key] = value
                    else:
                        print('【case5】')
                        for rec in original_body:
                            tmp = rec.split(':')
                            tmp = [rec1.replace(' ','') for rec1 in tmp]
                            key = tmp[0].replace('"','').replace("'",'')
                            value = tmp[1].strip(',').replace('"','').replace("'",'')
                            if key in fomated_body:
                                if(isinstance(fomated_body[key],list)):
                                    if(None in fomated_body[key]):
                                        for i in range(len(fomated_body[key])):
                                            if(fomated_body[key][i] == None):
                                                fomated_body[key][i] = 'null'
                                    tmp_key_str = ','.join(fomated_body[key])
                                else:
                                    tmp_key_str = fomated_body[key]
                                key_str = str(tmp_key_str) + ',' + value
                                tmp_value = key_str.split(',')
                                if('null' in tmp_value or 'None' in tmp_value):
                                    for i in range(len(tmp_value)):
                                        if(tmp_value[i] == 'null' or tmp_value[i] == 'None'):
                                            tmp_value[i] = None
                                    fomated_body[key] = tmp_value
                                else:
                                    fomated_body[key] = tmp_value
                            else:
                                if(value == 'null'):
                                    fomated_body[key] = None
                                else:
                                    fomated_body[key] = value
                else:
                    for rec in original_body:
                        if(':' in rec):
                            tmp = rec.split(':')
                        elif('\t' in rec):
                            tmp = rec.split('\t')
                        elif('\r' in rec):
                            tmp = rec.split('\r')
                        elif(' ' in rec):
                            tmp = rec.split(' ')
                        else:
                            tmp = rec.split('   ')
                        tmp = [rec1.replace(' ', '') for rec1 in tmp]
                        key = tmp[0].replace('"','').replace("'",'')
                        value = tmp[1].strip(',').replace('"','').replace("'",'')
                        if key in fomated_body:
                            if(isinstance(fomated_body[key],list)):
                                if(None in fomated_body[key]):
                                    for i in range(len(fomated_body[key])):
                                        if(fomated_body[key][i] == None):
                                            fomated_body[key][i] = 'null'
                                tmp_key_str = ','.join(fomated_body[key])
                            else:
                                tmp_key_str = fomated_body[key]
                            key_str = str(tmp_key_str) + ',' + value
                            tmp_value = key_str.split(',')
                            if('null' in tmp_value or 'None' in tmp_value):
                                for i in range(len(tmp_value)):
                                    if(tmp_value[i] == 'null' or tmp_value[i] == 'None'):
                                        tmp_value[i] = None
                                fomated_body[key] = tmp_value
                            else:
                                fomated_body[key] = tmp_value
                        else:
                            if(value == 'null'):
                                fomated_body[key] = None
                            else:
                                fomated_body[key] = value
            fomated_body1 = json.dumps(fomated_body,sort_keys=True,indent=8)
            fomated_body_list = {"json_str": fomated_body1.encode().decode('raw_unicode_escape'),    #显示中文，只适用于json
                                 "json_dict":json.dumps(fomated_body,sort_keys=True).encode().decode('raw_unicode_escape')}  #显示中文，只适用于json
        except Exception:
            traceback.print_exc()
            fomated_body_list = {"json_str": '【Error】：您输入的数据格式有误！',
                                 "json_dict":'【Error】：您输入的数据格式有误！'}
        return HttpResponse(json.dumps(fomated_body_list), content_type='application/json')

def search_interface(req):
    key_words_product_name = req.GET.get('key_words_product_name', '')
    key_words_name = req.GET.get('key_words_name','')
    key_words_url = req.GET.get('key_words_url','')
    interfaces = AutotestplatInterfaceTestcase.objects.filter(Q(product_name__icontains=key_words_product_name),Q(name__icontains=key_words_name),Q(url__icontains=key_words_url)).order_by('order')
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

def sign_nb(para):
    del_key_list = []
    for rec in para.keys():
        if(para[rec] == "{SiGn_NB}" or para[rec] == None):
            del_key_list.append(rec)
    for rec in del_key_list:
        del para[rec]
    para_URI = ''
    for rec in para.keys():
        tmp = parse.quote(rec) + '=' + para[rec] + '&'
        para_URI += tmp
    para_URI += 'key=22222'
    print('para_URI = ',para_URI)
    hl = hashlib.md5()
    hl.update(para_URI.encode(encoding='utf-8'))
    sign = hl.hexdigest()
    print('sign = ',sign)
    return sign

def start_interface_test(req):
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
        public_list3 = AutotestplatParameter.objects.filter(Q(type='con'),Q(type='env'))
        keyword_list3 = ["{"+rec.keywords+"}" for rec in public_list3]
        public_dict3 = {}
        for rec in public_list3:
            public_dict3[rec.keywords] = rec.value
        public_dict = {}
        public_dict.update(public_dict1)
        public_dict.update(public_dict2)
        public_dict.update(public_dict4)
        public_dict.update(public_dict5)
        f_handler = open(logfile, 'w')
        f_handler.truncate()
        f_handler.close()
        interfaces = AutotestplatInterfaceTestcase.objects.filter(id=id1)[0]
        print_log('【接口名称】: ', ','), print_log(str(id1) + "_" , ','),print_log(interfaces.name)
        print_log('【请求方式】: ', ','), print_log(interfaces.mode)
        url_host = interfaces.url_host
        try:
            if("{" in url_host and "}" in url_host):
                end_index = url_host.find("}")
                key_url_host = url_host[:end_index+1]
                url_host = url_host.replace(key_url_host,public_dict[key_url_host.replace('{','').replace('}','').replace(' ','')])
        except:
            return HttpResponse('【ERROR】：url_host参数 ' + url_host + ' 有误，请重新修改 ')
        url = interfaces.url
        try:
           if("{" in url and "}" in url):
               end_index = url.find("}")
               start_index = url.find("{")
               key_url = url[start_index:end_index+1]
               url = url.replace(key_url,public_dict[key_url.replace('{','').replace('}','')])
        except:
            return HttpResponse('【ERROR】：url参数 ' + url + ' 有误，请重新修改 ')
        url = url_host+url
        head = eval(interfaces.head)
        for rec in head.keys():
            if(head[rec] in keyword_list1):
                head[rec] = public_dict[head[rec].replace('{','').replace('}','')]
            elif (head[rec] in keyword_list4):
                head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
            elif (head[rec] in keyword_list5):
                head[rec] = public_dict[head[rec].replace('{', '').replace('}', '')]
                head[rec] = str(eval(head[rec]))
            elif(head[rec] in keyword_list2):
                try:
                    head[rec] = cache.get(head[rec].replace('{','').replace('}',''))
                except Exception:
                    error_info = traceback.format_exc()
                    print(error_info)
                    return HttpResponse('【ERROR】：参数 '+head[rec]+' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 '+head[rec]+' 的前置接口，以及确认Redis是否已启动')
        is_login_api = False
        n = 0
        while (n < 5):
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
                    for rec5 in keyword_list5:
                        if (rec5 in body[rec]):
                            try:
                                body[rec] = body[rec].replace(rec5, public_dict[rec5.replace('{', '').replace('}', '')])
                                body[rec] = str(eval(body[rec]))
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
                            para = copy.deepcopy(body)
                            body[rec] = sign_nb(para)
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
            mode = interfaces.mode
            body_format = interfaces.body_format
            try:
                response,cookie = interface_test_start(url,body,head,mode,body_format,True)     #False，不打印日志；True，打印日志
            except:
                return HttpResponse('【ERROR】：' + url + ' 接口录入信息有误，请重新修改')
            update_cookie = interfaces.update_cookie
            public_resp = AutotestplatParameter.objects.filter(module_id=int(id1)).exclude(product_name='suit')
            if(str(public_resp) != '[]'):
                for rec in public_resp:
                    left = rec.left
                    right = rec.right
                    index = int(rec.index)
                    reg = left+'.+?'+right
                    result_all = re.findall(reg,response)
                    print(result_all)
                    try:
                        result_tmp = result_all[index]
                        start = len(left)
                        end = len(result_tmp) - len(right)
                        result = result_tmp[start:end]
                        cache.set(rec.keywords, result)
                        cache.expire(rec.keywords, 3600)
                        print_log('【响应关联参数】： {'+rec.keywords+'}，匹配的第'+str(index+1)+'个值为：'+result)
                    except Exception:
                        error_info = traceback.format_exc()
                        print(error_info)
                        print_log('【响应关联参数】： {' + rec.keywords +'} 在响应数据中未匹配到，请检测前置接口关键字配置，以及Redis是否已启动')
            assert_keywords_old = interfaces.assert_keywords_old
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

def Method_POST(url,body,head, body_format,is_out = True):
    starttime = datetime.now()
    r = request_post(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if(is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
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
        print_log('【请求参数】：',','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    if(is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log(str(r.reason))
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
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    if(is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log(str(r.reason))
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
            body_format1 = 'Form'
        else:
            body_format1 = 'Json'
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
