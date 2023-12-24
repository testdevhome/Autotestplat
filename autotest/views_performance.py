import os,re,json,traceback,copy,random,string,time,redis,ast,requests,codecs
from django.shortcuts import render
from django.shortcuts import render_to_response
from django.http import StreamingHttpResponse
from django.db.models import Q
from django.http import HttpResponse,HttpResponseRedirect
from django.template.context_processors import csrf
from urllib.parse import urlparse
from django.core.cache import cache
from django.conf import settings
from datetime import datetime
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from .models import *
from .views_jmeter import generate_jmx,body_request,body_request2,body_testplan,body_result,body_thread,body_thread2,body_head,body_cookie,generate_jmx2

current_dir = os.getcwd()
jmxfile = os.path.join(current_dir, 'apache-jmeter-5.6.2/bin', 'apitest.jmx')
logfile = os.path.join(current_dir, 'autotest', 'test_out.log')
codefile= os.path.join(current_dir, 'autotest', 'code.jpg')
session = requests.Session()

@login_required
def apiPerformance(request):
    username = request.session.get('user', '')
    if AuthUser.objects.filter(username=username).first().is_superuser == 1:
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
            i.product_id = product_name
    progress = AutotestplatInterfacePerformance.objects.filter(id=1).first().progress
    progress_total = AutotestplatInterfacePerformance.objects.filter(id=1).first().progress_total
    paginator = Paginator(interfaces, 10)
    num = len(interfaces)
    page = request.GET.get('page', 1)
    try:
        page_list = paginator.page(page)
    except PageNotAnInteger:
        page_list = paginator.page(1)
    except EmptyPage:
        page_list = paginator.page(paginator.num_pages)
    c = csrf(request)
    c.update({'page_list': page_list, 'interfaces': interfaces, 'type': type,'num':num,"product_alls":product_all,"progress":progress,"progress_total":progress_total})
    return render_to_response("interface_performance.html", c)

def report(request):
    return render_to_response("output/index.html")

def searchPerformanceInterface(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        key_words_name = raw_data['key_words_name']
        key_words_url = raw_data['key_words_url']
        interface_list1 = AutotestplatInterfaceTestcase.objects.filter(Q(name__icontains=key_words_name),Q(url__icontains=key_words_url))
        id_list = []
        name_list = []
        url_list = []
        charger_list = []
        for rec in interface_list1:
            id_list.append(rec.id)
            name_list.append(rec.name)
            url_list.append(rec.url)
            charger_list.append(rec.charger)
        interface_list2 = {'id_list': id_list,
                         'name_list': name_list,
                         'url_list': url_list,
                         'charger_list': charger_list,}
        return HttpResponse(json.dumps(interface_list2), content_type='application/json')

def generateJmeterFile(request):
    try:
        raw_data = request.body
        raw_data = json.loads(raw_data)
        id_list_login = raw_data['id_list_login']
        id_list_not_login = raw_data['id_list_not_login']
        num_bf = raw_data['num_bf']
        num_xh = raw_data['num_xh']
        num_sj = raw_data['num_sj']
        num_sj = str(int(num_sj)*60)
        mode = raw_data['mode']
        deal_cookie = raw_data['deal_cookie']
        public_list = AutotestplatParameter.objects.filter()
        keyword_list = ["{" + rec.keywords + "}" for rec in public_list]
        public_list1 = AutotestplatParameter.objects.filter(Q(type='con'))
        keyword_list1 = ["{" + rec.keywords + "}" for rec in public_list1]
        public_dict1 = {}
        for rec in public_list1:
            public_dict1[rec.keywords] = rec.value
        public_list2 = AutotestplatParameter.objects.filter(type='res').exclude(type='testplan')
        keyword_list2 = ["{" + rec.keywords + "}" for rec in public_list2]
        public_dict2 = {}
        for rec in public_list2:
            public_dict2[rec.keywords] = str((rec.left, rec.right, rec.index))
        public_list3 = AutotestplatParameter.objects.filter(Q(type='auth'))
        keyword_list3 = ["{" + rec.keywords + "}" for rec in public_list3]
        public_dict3 = {}
        for rec in public_list3:
            public_dict3[rec.keywords] = rec.value
        public_list4 = AutotestplatParameter.objects.filter(Q(type='env'))
        keyword_list4 = ["{" + rec.keywords + "}" for rec in public_list4]
        public_dict4 = {}
        for rec in public_list4:
            public_dict4[rec.keywords] = rec.value
        public_list5 = AutotestplatParameter.objects.filter(Q(type='var'))
        keyword_list5 = ["{" + rec.keywords + "}" for rec in public_list5]
        public_dict5 = {}
        for rec in public_list5:
            public_dict5[rec.keywords] = rec.value
        public_dict = {}
        public_dict.update(public_dict1)
        public_dict.update(public_dict2)
        public_dict.update(public_dict3)
        public_dict.update(public_dict4)
        public_dict.update(public_dict5)
        body_list = []
        id=''
        name=''
        for id in id_list_login:
            interface_list = AutotestplatInterfaceTestcase.objects.filter(id=str(id))
            for rec in interface_list:
                id = rec.id
                url = rec.url
                url2= url.replace('?','//%')
                parabody = rec.body
                parsed_uri = urlparse(url2)
                name = rec.name
                head = rec.head
                assertkey = rec.assert_keywords_old
                url_host = rec.url_host
                try:
                    if ("{" in url_host and "}" in url_host):
                        end_index = url_host.find("}")
                        key_url_host = url_host[:end_index + 1]
                        url_host = url_host.replace(key_url_host, public_dict[key_url_host.replace('{', '').replace('}', '').replace(' ', '')])
                except:
                    return HttpResponse('【ERROR】：url_host参数 ' + url_host + ' 有误，请重新修改 ')

                scheme = '{uri.scheme}'.format(uri=parsed_uri)
                # domain = '{uri.netloc}'.format(uri=parsed_uri)
                domain = url_host
                path = '{uri.path}'.format(uri=parsed_uri)
                path2 = path.replace('//%','?')
                if url_host.startswith('http://') or url_host.startswith('https://'):
                    host = domain.split(':')[1].replace('//', '')
                    if len(domain.split(':')) > 2:
                        port = domain.split(':')[2]
                    else:
                        port = ''
                else:
                    host = domain.split(':')[0]
                    if len(domain.split(':')) > 1:
                        port = domain.split(':')[1]
                    else:
                        port = ''
                head1 = eval(head)
                head_list1 = []
                for item, value in head1.items():
                    item1 = item
                    value1 = value
                    head1 = body_head(item1, value1)
                    head_list1.append(head1)
                head1 = ''.join(head_list1)
                body1 = body_request(str(id),name,host, port, path2, scheme, parabody,head1,assertkey,)
                body_list.append(body1)
                islogin = True
                start_interface_login(id)
                update_cookie = rec.update_cookie
                update_cookie = update_cookie.replace('{', '').replace('}', '')
        body1 = ''.join(body_list)
        body_thread1=''
        try:
            body_thread1 = body_thread(id,'1','1')
        except Exception:
            pass
        cookie=''
        body_list2 = []
        for id2 in id_list_not_login:
            interface_list2 = AutotestplatInterfaceTestcase.objects.filter(id=str(id2))
            for rec in interface_list2:
                id2 = rec.id
                url_host = rec.url_host
                try:
                    if ("{" in url_host and "}" in url_host):
                        end_index = url_host.find("}")
                        key_url_host = url_host[:end_index + 1]
                        url_host = url_host.replace(key_url_host, public_dict[key_url_host.replace('{', '').replace('}', '').replace(' ', '')])
                except:
                    return HttpResponse('【ERROR】：url_host参数 ' + url_host + ' 有误，请重新修改 ')
                url = rec.url
                url2 = url.replace('?', '//%')
                if ("{" in url and "}" in url):
                    end_index = url.find("}")
                    key_url = url[:end_index + 1]
                    url = url.replace(key_url, public_dict[key_url.replace('{', '').replace('}', '')])
                body = eval(rec.body)
                for bodykey in body.keys():
                    if(isinstance(body[bodykey],str) or isinstance(body[bodykey],list) or isinstance(body[bodykey],dict)):
                        for rec1 in keyword_list1:
                            if (rec1 in body[bodykey]):
                                if ('captcha' not in rec1):
                                    body[bodykey] = body[bodykey].replace(rec1, public_dict[
                                        rec1.replace('{', '').replace('}', '')])
                                else:
                                    is_login_api = True
                                    yanzheng_url = public_dict[rec1.replace('{', '').replace('}', '')]
                                    haha = request_get(yanzheng_url, {}, {}, 0)
                                    with open(codefile, 'wb') as f:
                                        f.write(haha.content)
                                    yanzheng = getcaptcha()
                                    body[bodykey] = yanzheng
                                    print_detail('【验证码】：', ','), print_detail(yanzheng)
                        for rec5 in keyword_list5:
                            if (rec5 in str(body[bodykey])):
                                try:
                                    var_name = public_dict[rec5.replace('{', '').replace('}', '')]
                                    var_value = str(eval(var_name))
                                    body = str(body).replace(rec5, var_name)
                                    body = str(body).replace(var_name, var_value)
                                    body = ast.literal_eval(body)
                                except Exception:
                                    error_info = traceback.format_exc()
                                    print(error_info)
                                    return HttpResponse(
                                        '【ERROR】：参数 ' + rec5 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec5 + ' 的前置接口，以及确认Redis是否已启动')
                        for rec2 in keyword_list2:
                            if (rec2 in body[bodykey]):
                                try:
                                    body[bodykey] = body[bodykey].replace(rec2, cache.get(
                                        rec2.replace('{', '').replace('}', '')))
                                except Exception:
                                    error_info = traceback.format_exc()
                                    print(error_info)
                                    return HttpResponse('【ERROR】：参数 ' + rec2 + ' 没有参数值，请确认是否已执行返回 ' + rec2 + ' 的接口')
                        for rec3 in keyword_list3:
                            if (rec3 in body[bodykey]):
                                try:
                                    body[bodykey] = body[bodykey].replace(rec3, cache.get(
                                        rec3.replace('{', '').replace('}', '')).decode('utf-8'))
                                except Exception:
                                    error_info = traceback.format_exc()
                                    print(error_info)
                                    return HttpResponse(
                                        '【ERROR】：参数 ' + rec3 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec3 + ' 的前置接口，以及确认Redis是否已启动')
                        if ('select' in body[bodykey]):
                            try:
                                sql = body[bodykey]
                                cursor = connection.cursor()
                                cursor.execute(sql)
                                data = cursor.fetchall()
                                print(u'查询的结果为： ', data[0][0])
                                body[bodykey] = str(data[0][0])
                            except Exception:
                                body[bodykey] = '【ERROR】：查询结果为空！'
                parabody = str(body)
                parsed_uri = urlparse(url2)
                name = rec.name
                head = rec.head
                assertkey = rec.assert_keywords_old
                scheme = '{uri.scheme}'.format(uri=parsed_uri)
                domain = url_host
                path = '{uri.path}'.format(uri=parsed_uri)
                path2 = path.replace('//%', '?')
                if url_host.startswith('http://') or url_host.startswith('https://'):
                    host = domain.split(':')[1].replace('//', '')
                    if len(domain.split(':')) > 2:
                        port = domain.split(':')[2]
                    else:
                        port = ''
                else:
                    host = domain.split(':')[0]
                    if len(domain.split(':')) > 1:
                        port = domain.split(':')[1]
                    else:
                        port = ''
                head2 = eval(head)
                head_list2 = []
                for item,value in head2.items():
                    item2 = item
                    value2 = value
                    if value2 == "{autotestplat}":
                        head2 = body_head(item2,str(cookie))
                    else:
                        head2 = body_head(item2, value2)
                    head_list2.append(head2)
                head2 = ''.join(head_list2)
                if(cookie):
                    cookie = eval(cookie)
                    cookie_list = []
                    cookie1 = body_cookie(cookie[1][0],cookie[1][1])
                    cookie_list.append(cookie1)
                    cookie2 = body_cookie(cookie[2][0], cookie[2][1])
                    cookie_list.append(cookie2)
                    cookie3 = body_cookie(cookie[3][0], cookie[3][1])
                    cookie_list.append(cookie3)
                    for item, value in cookie[0].items():
                        item2 = item
                        value2 = value
                        cookie = body_cookie(item2,value2)
                        cookie_list.append(cookie)
                    cookie = ''.join(cookie_list)
                else:
                    cookie = ''
                body2 = body_request2(str(id2), name,host, port, path2, scheme, parabody, cookie,head2,assertkey)
                body_list2.append(body2)
                islogin = False
        body2 = ''.join(body_list2)
        body_thread22=''
        if num_xh == '0':
            num_xh = '-1'
        else:
            num_xh = num_xh
        try:
            body_thread22 = body_thread2(id2,num_bf,num_xh,num_sj)
        except Exception:
            pass
        body3 = body_thread1 + str(body1) + '</hashTree>\n' + body_thread22 + str(body2)
        body4 = body_thread22 + str(body1) + str(body2)
        if mode=='多用户':
            generate_jmx(name,host, port, path2, scheme, body4,)
        else:
            generate_jmx2(name,host, port, path2, scheme, body3,)
        return HttpResponse("success")
    except Exception:
        traceback.print_exc()
        return HttpResponse("failed")

def prepareJmeter(request):
    try:
        bin_file = "cd "+current_dir+"/apache-jmeter-5.6.2/bin && del testLogFile"
        rm_report_file = "rmdir /s/q "+current_dir.replace('/','\\')+"\\autotest\\static\\output\\ "
        os.system(bin_file)
        os.system(rm_report_file)
        return HttpResponse("success")
    except Exception:
        traceback.print_exc()
        return HttpResponse("failed")

def startTestJmeter(request):
    try:
        report_file = "cd "+current_dir+"/apache-jmeter-5.6.2/bin && jmeter -n -t "+current_dir+"/apache-jmeter-5.6.2/bin/apitest.jmx -l testLogFile -e -o "+current_dir+"/autotest/static/output"
        os.system(report_file)
        return HttpResponse("success")
    except Exception:
        traceback.print_exc()
        return HttpResponse("failed")


def showProgress(request):
    if request.method == "POST":
        raw_data = request.body
        raw_data = json.loads(raw_data)
        instance = AutotestplatInterfacePerformance.objects.filter(id=1)
        if instance:
            progress = raw_data['progress']
            progress_total = raw_data['progress_total']
        else:
            progress = 1
            progress_total = 1
        AutotestplatInterfacePerformance.objects.filter(id=1).update(progress=progress,progress_total=progress_total)
    return HttpResponse("success")


def start_interface_login(id1):
    public_list = AutotestplatParameter.objects.all()
    keyword_list = ["{"+rec.keywords+"}" for rec in public_list]
    public_list1 = AutotestplatParameter.objects.filter(Q(type='con'))
    keyword_list1 = ["{"+rec.keywords+"}" for rec in public_list1]
    public_dict1 = {}
    for rec in public_list1:
        public_dict1[rec.keywords] = rec.value
    public_list2 = AutotestplatParameter.objects.exclude(type='res').exclude(type='testplan')
    keyword_list2 = ["{"+rec.keywords+"}" for rec in public_list2]
    public_dict2 = {}
    for rec in public_list2:
        public_dict2[rec.keywords] = str((rec.left,rec.right,rec.index))
    public_list3 = AutotestplatParameter.objects.filter(Q(type='auth'))
    keyword_list3 = ["{"+rec.keywords+"}" for rec in public_list3]
    public_dict3 = {}
    for rec in public_list3:
        public_dict3[rec.keywords] = rec.value
    public_list4 = AutotestplatParameter.objects.filter(Q(type='env'))
    keyword_list4 = ["{" + rec.keywords + "}" for rec in public_list4]
    public_dict4 = {}
    for rec in public_list4:
        public_dict4[rec.keywords] = rec.value
    public_list5 = AutotestplatParameter.objects.filter(Q(type='var'))
    keyword_list5 = ["{" + rec.keywords + "}" for rec in public_list5]
    public_dict5 = {}
    for rec in public_list5:
        public_dict5[rec.keywords] = rec.value
    public_dict = {}
    public_dict.update(public_dict1)
    public_dict.update(public_dict2)
    public_dict.update(public_dict5)
    public_dict.update(public_dict4)
    f_handler = open(logfile, 'w')
    f_handler.truncate()
    f_handler.close()
    interfaces = AutotestplatInterfaceTestcase.objects.filter(id=id1)[0]
    url_host = interfaces.url_host
    try:
        if ("{" in url_host and "}" in url_host):
            end_index = url_host.find("}")
            key_url_host = url_host[:end_index + 1]
            url_host = url_host.replace(key_url_host,public_dict[key_url_host.replace('{', '').replace('}', '').replace(' ', '')])
    except:
        return HttpResponse('【ERROR】：url_host参数 ' + url_host + ' 有误，请重新修改 ')
    url = interfaces.url
    if("{" in url and "}" in url):
        end_index = url.find("}")
        key_url = url[:end_index+1]
        url = url.replace(key_url,public_dict[key_url.replace('{','').replace('}','')])
    url = url_host+url
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
                return HttpResponse('【ERROR】：参数 '+head[rec]+' 没有参数值，请确认是否已执行返回 '+head[rec]+' 的接口')
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
                            with open(logfile,'wb') as f:
                                f.write(haha.content)
                            yanzheng = getcaptcha()
                            body[rec] = yanzheng
                            print_detail('【验证码】：',','),print_detail(yanzheng)
                for rec5 in keyword_list5:
                    if (rec5 in str(body[rec])):
                        try:
                            var_name = public_dict[rec5.replace('{', '').replace('}', '')]
                            var_value = str(eval(var_name))
                            body = str(body).replace(rec5, var_name)
                            body = str(body).replace(var_name, var_value)
                            body = ast.literal_eval(body)
                        except Exception:
                            error_info = traceback.format_exc()
                            print(error_info)
                            return HttpResponse('【ERROR】：参数 ' + rec5 + ' 没有参数值，请确认系统参数设置是否正确，是否已执行返回 ' + rec5 + ' 的前置接口，以及确认Redis是否已启动')
                for rec2 in keyword_list2:
                    if(rec2 in body[rec]):
                        try:
                            body[rec] = body[rec].replace(rec2, cache.get(rec2.replace('{','').replace('}','')))
                        except Exception:
                            error_info = traceback.format_exc()
                            print(error_info)
                            return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认是否已执行返回 '+rec2+' 的接口')
                for rec3 in keyword_list3:
                    if(rec3 in body[rec]):
                        pass
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
        response,cookie = interface_test_start(url,body,head,mode,body_format,True)
        update_cookie = interfaces.update_cookie
        if('{' in update_cookie and '}' in update_cookie):
            for rec in keyword_list1:
                if(rec == update_cookie):
                    cookie_status1 = public_para1.objects.filter(keywords=rec.replace('{','').replace('}','')).update(value=cookie)
                    print(cookie_status1, ' update success!')
                    break
        public_resp = AutotestplatParameter.objects.filter(module_id=int(id1)).exclude(type='testplan')
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
                    print(rec.keywords,'匹配结果为：',result)
                    cache.set(rec.keywords, result, timeout=3600)
                    print_detail('\n接口返回关键字： '+rec.keywords+'，匹配第'+str(index+1)+'个        '+left+right+'       ，值为：'+result)
                except Exception:
                    error_info = traceback.format_exc()
                    print(error_info)
                    print((rec.keywords,left,right,index),' 在返回结果中未匹配到')
        is_new = interfaces.assert_use_new
        if(is_new == '1'):
            assert_body = eval(interfaces.assert_body)
            for rec in assert_body.keys():
                if(isinstance(assert_body[rec],str)):
                    for rec1 in keyword_list1:
                        if(rec1 in assert_body[rec]):
                            assert_body[rec] = assert_body[rec].replace(rec1, public_dict[rec1.replace('{','').replace('}','')])
                    for rec2 in keyword_list2:
                        if(rec2 in assert_body[rec]):
                            try:
                                assert_body[rec] = assert_body[rec].replace(rec2, cache.get(rec2.replace('{','').replace('}','')))
                            except Exception:
                                error_info = traceback.format_exc()
                                print(error_info)
                                return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认是否已执行返回 '+rec2+' 的接口')
                    for rec3 in keyword_list3:
                        if(rec3 in assert_body[rec]):
                            pass
                    if('select' in assert_body[rec]):
                        try:
                            sql = assert_body[rec]
                            cursor = connection.cursor()
                            cursor.execute(sql)
                            data = cursor.fetchall()
                            print(u'查询的结果为： ',data[0][0])
                            assert_body[rec] = data[0][0]
                        except Exception:
                            assert_body[rec] = '【ERROR】：查询结果为空！'
            assert_keywords = interfaces.assert_keywords
            for rec1 in keyword_list1:
                if(rec1 in assert_keywords):
                    assert_keywords = assert_keywords.replace(rec1, public_dict[rec1.replace('{','').replace('}','')])
            for rec2 in keyword_list2:
                if(rec2 in assert_keywords):
                    try:
                        assert_keywords = assert_keywords.replace(rec2, cache.get(rec2.replace('{','').replace('}','')))
                    except Exception:
                        error_info = traceback.format_exc()
                        print(error_info)
                        return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认是否已执行返回 '+rec2+' 的接口')
            if('select' in assert_keywords):
                sql = assert_keywords
                cursor = connection.cursor()
                cursor.execute(sql)
                data = cursor.fetchall()
                print(u'查询的结果为： ',data[0][0])
                assert_keywords = data[0][0]
            is_contain = interfaces.assert_keywords_is_contain
            assert_result = assert_test(assert_keywords,is_contain,assert_body_format,True)
        else:
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
                        return HttpResponse('【ERROR】：参数 '+rec2+' 没有参数值，请确认是否已执行返回 '+rec2+' 的接口')
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

def request_post(url, body, head, body_format):
    if (body_format == 'JSON'):
         body = json.dumps(body)
    else:
        keys = body.keys()
        for rec in keys:
            if ('[{' in str(body[rec]) and '}]' in str(body[rec])):
                body = json.dumps(body)
                break
    r = session.post(url, body, headers=head)
    return r

def request_get(url, body, head, body_format):
    if (body_format == 'JSON'):
        body = json.dumps(body)
    r = session.get(url, params=body, headers=head)
    return r

def request_put(url, body, head, body_format):
    if (body_format == 'JSON'):
        body = json.dumps(body)
    r = session.put(url, params=body, headers=head)
    return r

def request_delete(url, body, head, body_format):
    if (body_format == 'JSON'):
        body = json.dumps(body)
    r = session.delete(url, json=body, headers=head)
    return r

def request_patch(url, body, head, body_format):
    if (body_format == 'JSON'):
        body = json.dumps(body)
    r = session.patch(url, json=body, headers=head)
    return r

def request_head(url, body, head, body_format):
    if (body_format == 'JSON'):
        body = json.dumps(body)
    r = session.head(url, json=body, headers=head)
    return r

def request_options(url, body, head, body_format):
    if (body_format == 'JSON'):
        body = json.dumps(body)
    r = session.options(url, json=body, headers=head)
    return r

def Method_POST(url, body, head, body_format, is_out=True):
    starttime = datetime.now()
    r = request_post(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if (is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(
            json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if (is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    ' + str(r.reason))
        print_log('【响应数据】：', ','), print_log(str(response))
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒", ',')
    return response, cookie

def Method_GET(url, body, head, body_format, is_out=True):
    starttime = datetime.now()
    r = request_get(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if (is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(
            json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if (is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    ' + str(r.reason))
        print_log('【响应数据】：', ','), print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒", ',')
    return response, cookie

def Method_PUT(url, body, head, body_format, is_out=True):
    starttime = datetime.now()
    r = request_put(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if (is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if (is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    ' + str(r.reason))
        print_log('【响应数据】：', ','), print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒")
    return response, cookie

def Method_DELETE(url, body, head, body_format, is_out=True):
    starttime = datetime.now()
    r = request_delete(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if (is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if (is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    ' + str(r.reason))
        print_log('【响应数据】：', ','), print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒")
    return response, cookie

def Method_PATCH(url, body, head, body_format, is_out=True):
    starttime = datetime.now()
    r = request_patch(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if (is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if (is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    ' + str(r.reason))
        print_log('【响应数据】：', ','), print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒")
    return response, cookie

def Method_HEAD(url, body, head, body_format, is_out=True):
    starttime = datetime.now()
    r = request_head(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if (is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if (is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    ' + str(r.reason))
        print_log('【响应数据】：', ','), print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒")
    return response, cookie

def Method_OPTIONS(url, body, head, body_format, is_out=True):
    starttime = datetime.now()
    r = request_options(url, body, head, body_format)
    endtime = datetime.now()
    response_time = (endtime - starttime).total_seconds()
    if (is_out == True):
        print_log('【请求URL】：', ','), print_log(r.url)
        print_log('【请求head】：', ','), print_log(json.dumps(head, sort_keys=True).encode().decode('raw_unicode_escape'))
        print_log('【请求参数】：', ','), print_log(body)
    response = r.text
    cookie = '; '.join(['='.join(rec) for rec in session.cookies.items()])
    print_log('【Cookies】：', ','), print_log(cookie)
    if (is_out == True):
        print_log('\n【响应状态码】：', ','), print_log(str(r.status_code), ','), print_log('    ' + str(r.reason))
        print_log('【响应数据】：', ','), print_log(response)
        print_log('【响应时间】：', ','), print_log(str(response_time) + " 秒")
    return response, cookie


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

def print_log(var1, HH=True):
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