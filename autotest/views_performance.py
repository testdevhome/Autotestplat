import os,re,json,traceback,copy,random,string,time,redis,ast,requests,codecs,subprocess

import domain

from .views_jmeter import generate_jmx, body_request, body_request2, body_testplan, body_result, body_thread, body_thread2, body_head, body_cookie, body_httpcookie, generate_jmx2, body_request_form

from django.db import connection
from django.shortcuts import render
from django.shortcuts import render_to_response
from django.http import StreamingHttpResponse
from django.db.models import Q
from django.http import HttpResponse,HttpResponseRedirect
from django.template.context_processors import csrf
from urllib.parse import urlparse
from django.core.cache import cache
from django.conf import settings
from datetime import datetime,timedelta
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from .models import *

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
        product_all = AutotestplatProduct.objects.filter(delete_flag='N')
        product_name = ''
    else:
        user_product_id = AuthUser.objects.filter(username=username).first().last_name
        try:
            interfaces = AutotestplatInterfaceTestcase.objects.filter(product_id=user_product_id).order_by('-id').all()
        except:
            interfaces = AutotestplatInterfaceTestcase.objects.filter().order_by('-id').all()
        product_id = AuthUser.objects.filter(username=username).first().last_name
        product_name = AutotestplatProduct.objects.filter(id=product_id).first().product_name
        product_all = AutotestplatProduct.objects.filter(delete_flag='N')
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
            product_name_tmp = AutotestplatProduct.objects.filter(id=int(i.product_id)).first().product_name
            i.product_id = product_name_tmp
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
    c.update({'page_list': page_list, 'interfaces': interfaces, 'type': type,'num':num,"product_name":product_name,"product_alls":product_all,"progress":progress,"progress_total":progress_total})
    return render_to_response("interface_performance.html", c)

def report(request):
    # 指向 JMeter 生成的 index.html 文件
    output_index_path = os.path.join(current_dir, 'autotest', 'static', 'output', 'index.html')
    
    if os.path.exists(output_index_path):
        # 尝试多种编码方式读取，解决中文乱码问题
        content = None
        # JMeter 在 Windows 上通常使用 GBK 编码，先尝试 UTF-8，失败后尝试 GBK
        for encoding in ['utf-8', 'gbk', 'gb2312', 'gb18030']:
            try:
                with open(output_index_path, 'r', encoding=encoding) as f:
                    content = f.read()
                print(f"【SUCCESS】使用 {encoding} 编码成功读取 JMeter 报告")
                break
            except UnicodeDecodeError:
                continue
        
        if content is None:
            return HttpResponse('<h1>测试报告编码错误</h1><p>无法正确读取报告文件</p>')
        
        content = translate_jmeter_report(content)
        # 必须指定 content_type 为 text/html; charset=utf-8，确保浏览器使用 UTF-8 解码
        return HttpResponse(content, content_type='text/html; charset=utf-8')
    else:
        return HttpResponse('<h1>测试报告不存在</h1><p>请先执行性能测试</p>')


def translate_jmeter_report(content):
    translations = {
        'Test and Report information': '测试和报告信息',
        'Source file': '源文件',
        'Start Time': '开始时间',
        'End Time': '结束时间',
        'Filter for display': '显示过滤器',
        'APDEX (Application Performance Index)': 'APDEX (应用性能指数)',
        'Apdex': 'Apdex指数',
        'T (Toleration threshold)': 'T (容忍阈值)',
        'F (Frustration threshold)': 'F (挫折阈值)',
        'Label': '标签',
        'Requests Summary': '请求摘要',
        'Statistics': '统计信息',
        'Requests': '请求',
        'Executions': '执行情况',
        'Response Times (ms)': '响应时间 (毫秒)',
        'Throughput': '吞吐量',
        'Network (KB/sec)': '网络 (KB/秒)',
        '#Samples': '样本数',
        'FAIL': '失败',
        'Error %': '错误率',
        'Average': '平均值',
        'Min': '最小值',
        'Max': '最大值',
        'Median': '中位数',
        '90th pct': '90百分位',
        '95th pct': '95百分位',
        '99th pct': '99百分位',
        'Transactions/s': '事务/秒',
        'Received': '接收',
        'Sent': '发送',
        'Total': '总计',
        'Response Time Percentiles': '响应时间百分位',
        'Response Time Distribution': '响应时间分布',
        'Active Threads Over Time': '活跃线程数随时间变化',
        'Time VS Threads': '时间 VS 线程数',
        'Bytes Throughput Over Time': '字节吞吐量随时间变化',
        'Response Times Over Time': '响应时间随时间变化',
        'Response Time Percentiles Over Time (successful requests only)': '响应时间百分位随时间变化 (仅成功请求)',
        'Synthetic Response Times Distribution': '合成响应时间分布',
        'Latencies Over Time': '延迟随时间变化',
        'Connect Time Over Time': '连接时间随时间变化',
        'Response Time Vs Request': '响应时间 VS 请求数',
        'Latencies Vs Request': '延迟 VS 请求数',
        'Hits Per Second': '每秒点击数',
        'Codes Per Second': '状态码/秒',
        'Total Transactions Per Second': '每秒总事务数',
        'Transactions Per Second': '每秒事务数',
        'Customs Graphs': '自定义图表',
        'Dashboard': '仪表板',
        'Charts': '图表',
        'Over Time': '随时间变化',
        'Throughput': '吞吐量',
        'Response Times': '响应时间',
    }

    for english, chinese in translations.items():
        content = content.replace(f'>{english}<', f'>{chinese}<')
        content = content.replace(f'"{english}"', f'"{chinese}"')

    return content

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
        num_sj = str(int(num_sj) * 60)
        mode = raw_data['mode']
        deal_cookie = raw_data['deal_cookie']

        print(f'【INFO】开始生成JMeter文件')
        print(f'【INFO】登录接口列表: {id_list_login}')
        print(f'【INFO】业务接口列表: {id_list_not_login}')

        login_cookie_dict = {}

        print(f'【INFO】开始从Redis获取Cookie用于性能测试')
        try:
            import redis as redis_client
            # r = redis_client.Redis(host='127.0.0.1', port=6379, db=0, decode_responses=True)
            r = redis_client.Redis(
                host=os.getenv('REDIS_HOST', 'localhost'),
                port=int(os.getenv('REDIS_PORT', 6379)),
                db=0,
                decode_responses=True
            )
            cached_cookies = r.get('auto_cookies_all')
            print(f'【DEBUG】Redis中auto_cookies_all的原始值为: {cached_cookies}')
            print(f'【DEBUG】Redis中auto_cookies_all的类型为: {type(cached_cookies)}')

            if cached_cookies:
                try:
                    cookie_dict = None

                    if isinstance(cached_cookies, str):
                        cookie_dict = json.loads(cached_cookies)
                    elif isinstance(cached_cookies, dict):
                        cookie_dict = cached_cookies

                    print(f'【DEBUG】解析后的cookie_dict: {cookie_dict}')

                    if cookie_dict and isinstance(cookie_dict, dict) and len(cookie_dict) > 0:
                        for key, value in cookie_dict.items():
                            login_cookie_dict[key] = value
                            print(f'【SUCCESS】从Redis获取到Cookie: {key}={value}')
                    else:
                        print(f'【WARNING】cookie_dict为空或不是字典类型')
                except Exception as e:
                    print(f'【ERROR】解析Redis Cookie失败: {e}')

                    traceback.print_exc()

                    try:
                        cookie_dict = ast.literal_eval(str(cached_cookies))
                        if isinstance(cookie_dict, dict):
                            for key, value in cookie_dict.items():
                                login_cookie_dict[key] = value
                                print(f'【SUCCESS】通过ast解析从Redis获取到Cookie: {key}={value}')
                    except Exception as ae:
                        print(f'【ERROR】ast解析也失败: {ae}')
            else:
                print(f'【WARNING】Redis中auto_cookies_all为空，请先在接口用例中执行登录接口')
        except Exception as e:
            print(f'【ERROR】从Redis获取Cookie失败: {e}')

            traceback.print_exc()

        if login_cookie_dict:
            print(f'【SUCCESS】成功获取到 {len(login_cookie_dict)} 个Cookie: {login_cookie_dict}')
        else:
            print(f'【WARNING】未能从Redis获取到Cookie，后续接口将不带Cookie')

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
        id = ''
        name = ''
        host = ''
        for id in id_list_login:
            interface_list = AutotestplatInterfaceTestcase.objects.filter(id=str(id))
            for rec in interface_list:
                id = rec.id
                url = rec.url
                url2 = url.replace('?', '//%')
                try:
                    parabody_dict = eval(rec.body)
                    if not isinstance(parabody_dict, dict):
                        parabody_dict = {}
                except Exception:
                    parabody_dict = {}
                parsed_uri = urlparse(url2)
                name = rec.name
                head = rec.head
                assertkey = rec.assert_keywords_old
                url_host = rec.url_host
                try:
                    if ("{" in url_host and "}" in url_host):
                        end_index = url_host.find("}")
                        key_url_host = url_host[:end_index + 1]
                        url_host = url_host.replace(key_url_host, public_dict[
                            key_url_host.replace('{', '').replace('}', '').replace(' ', '')])
                except:
                    return HttpResponse('【ERROR】：url_host参数 ' + url_host + ' 有误，请重新修改 ')

                if url_host.lower().startswith('https://'):
                    scheme = 'https'
                    clean_host = url_host[8:]
                elif url_host.lower().startswith('http://'):
                    scheme = 'http'
                    clean_host = url_host[7:]
                else:
                    scheme = 'https'
                    clean_host = url_host

                if ':' in clean_host:
                    host = clean_host.split(':')[0]
                    port = clean_host.split(':')[1]
                else:
                    host = clean_host
                    port = '443' if scheme == 'https' else '80'
                path = '{uri.path}'.format(uri=parsed_uri)
                path2 = path.replace('//%', '?')

                head1 = eval(head)
                content_type = head1.get('Content-Type', '')

                has_content_type = any(k.lower() == 'content-type' for k in head1.keys())

                if 'application/json' in content_type.lower():
                    parabody_str = json.dumps(parabody_dict, ensure_ascii=False)
                    head_list1 = [body_head(k, v) for k, v in head1.items()]
                    body1 = body_request(str(id), name, host, port, path2, scheme, parabody_str, ''.join(head_list1),
                                         assertkey)
                else:
                    if not has_content_type:
                        head1['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
                    head_list1 = [body_head(k, v) for k, v in head1.items()]
                    body1 = body_request_form(str(id), name, host, port, path2, scheme, parabody_dict,
                                              ''.join(head_list1), assertkey)
                body_list.append(body1)
                update_cookie = rec.update_cookie
                update_cookie = update_cookie.replace('{', '').replace('}', '')
        if not host and id_list_not_login:
            first_interface = AutotestplatInterfaceTestcase.objects.filter(id=str(id_list_not_login[0])).first()
            if first_interface:
                url_host = first_interface.url_host
                try:
                    if ("{" in url_host and "}" in url_host):
                        end_index = url_host.find("}")
                        key_url_host = url_host[:end_index + 1]
                        url_host = url_host.replace(key_url_host, public_dict[
                            key_url_host.replace('{', '').replace('}', '').replace(' ', '')])
                except:
                    pass

                if url_host.startswith('http://') or url_host.startswith('https://'):
                    url_host = url_host.split('://')[1]

                if ':' in url_host:
                    host = url_host.split(':')[0]
                else:
                    host = url_host
                print(f'【INFO】从业务接口获取到域名: {host}')

        body1 = ''.join(body_list)
        body_thread1 = ''
        try:
            body_thread1 = body_thread(id, '1', '1')
        except Exception:
            pass
        cookie_xml = ''
        cookie_header_value = ''
        if login_cookie_dict:
            cookie_parts = []
            cookie_header_parts = []
            cookie_domain = host if host else ''
            for key, value in login_cookie_dict.items():
                cookie_parts.append(body_cookie(key, value, cookie_domain))
                cookie_header_parts.append(f'{key}={value}')
                print(f'【INFO】生成Cookie XML: {key}={value}, domain={cookie_domain}')
            cookie_xml = ''.join(cookie_parts)
            cookie_header_value = '; '.join(cookie_header_parts)
            print(f'【INFO】拼接后的Cookie XML长度: {len(cookie_xml)}')
            print(f'【INFO】拼接后的Cookie Header值: {cookie_header_value}')
            print(f'【INFO】最终Cookie字典: {login_cookie_dict}')
        else:
            print(f'【ERROR】login_cookie_dict为空，无法生成Cookie XML，性能测试将会失败！')

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
                        url_host = url_host.replace(key_url_host, public_dict[
                            key_url_host.replace('{', '').replace('}', '').replace(' ', '')])
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
                    if (isinstance(body[bodykey], str) or isinstance(body[bodykey], list) or isinstance(body[bodykey],
                                                                                                        dict)):
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
                                    print_log('【验证码】：', ',')
                                    print_log(yanzheng)

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
                                    return HttpResponse(
                                        '【ERROR】：参数 ' + rec2 + ' 没有参数值，请确认是否已执行返回 ' + rec2 + ' 的接口')
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

                if not scheme:
                    if url_host.lower().startswith('https://'):
                        scheme = 'https'
                    elif url_host.lower().startswith('http://'):
                        scheme = 'http'
                    else:
                        scheme = 'https'

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

                if not port:
                    port = '443' if scheme == 'https' else '80'

                head2 = eval(head)
                content_type = head2.get('Content-Type', '')
                head_list2 = []

                has_content_type = any(k.lower() == 'content-type' for k in head2.keys())
                has_cookie_header = any(k.lower() == 'cookie' for k in head2.keys())

                for item, value in head2.items():
                    item2 = item
                    value2 = value
                    if value2 == "{autotestplat}":
                        if cookie_xml:
                            head2 = body_head(item2, cookie_xml)
                            print(f'【INFO】为接口 {id2} 添加Cookie到Header: {item2}={cookie_xml}')
                        else:
                            head2 = body_head(item2, '')
                    else:
                        head2 = body_head(item2, value2)
                    head_list2.append(head2)

                if not has_content_type:
                    head_list2.append(body_head('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8'))

                if cookie_header_value and not has_cookie_header:
                    head_list2.append(body_head('Cookie', cookie_header_value))
                    print(f'【INFO】为接口 {id2} 添加Cookie Header: {cookie_header_value}')

                head2_str = ''.join(head_list2)

                if 'application/json' in content_type.lower():
                    body2 = body_request2(str(id2), name, host, port, path2, scheme, parabody, cookie_xml, head2_str,
                                          assertkey)
                else:
                    body2 = body_request_form(str(id2), name, host, port, path2, scheme, body, head2_str, assertkey,
                                              cookie_xml)

                body_list2.append(body2)
                islogin = False
        body2 = ''.join(body_list2)
        body_thread22 = ''
        if num_xh == '0':
            num_xh = '-1'
        else:
            num_xh = num_xh
        try:
            body_thread22 = body_thread2(id2, num_bf, num_xh, num_sj)
        except Exception:
            pass
        body3 = body_thread1 + str(body1) + '</hashTree>\n' + body_thread22 + str(body2)
        body4 = body_thread22 + str(body1) + str(body2)
        if mode == '多用户':
            generate_jmx(name, host, port, path2, scheme, body4, )
        else:
            generate_jmx2(name, host, port, path2, scheme, body3, )
        return HttpResponse("success")
    except Exception:
        traceback.print_exc()
        return HttpResponse("failed")


def prepareJmeter(request):
    try:
        bin_dir = os.path.join(current_dir, 'apache-jmeter-5.6.2', 'bin')
        test_log_file = os.path.join(bin_dir, 'testLogFile')
        output_dir = os.path.join(current_dir, 'autotest', 'static', 'output')
        
        # 删除测试日志文件（如果存在）
        if os.path.exists(test_log_file):
            try:
                os.remove(test_log_file)
            except:
                pass
        
        # 创建空的测试日志文件，避免 JMeter 找不到文件
        with open(test_log_file, 'w', encoding='utf-8') as f:
            pass
        
        # 删除旧的输出目录
        if os.path.exists(output_dir):
            try:
                import shutil
                shutil.rmtree(output_dir)
            except:
                pass
        
        # 必须重新创建空的输出目录，否则 serve 视图找不到根目录会报错
        os.makedirs(output_dir)
        
        return HttpResponse("success")
    except Exception:
        traceback.print_exc()
        return HttpResponse("failed")

def startTestJmeter(request):
    try:
        jmx_path = os.path.join(current_dir, 'apache-jmeter-5.6.2', 'bin', 'apitest.jmx')
        logfile_path = os.path.join(current_dir, 'apache-jmeter-5.6.2', 'bin', 'testLogFile')
        output_path = os.path.join(current_dir, 'autotest', 'static', 'output')
        apache_jmeter_jar = os.path.join(current_dir, 'apache-jmeter-5.6.2', 'bin', 'ApacheJMeter.jar')

        if not os.path.exists(apache_jmeter_jar):
            return HttpResponse("failed: JMeter核心jar包不存在")

        # --- 开始修改：显式指定 Java 路径 ---
        java_path = None
        
        # 1. 优先尝试读取环境变量 JAVA_HOME
        java_home = os.environ.get('JAVA_HOME')
        if java_home:
            candidate = os.path.join(java_home, 'bin', 'java.exe')
            if os.path.exists(candidate):
                java_path = candidate
                print(f"从环境变量找到 Java: {java_path}")
        
        # 2. 如果环境变量读取失败，使用截图中的路径作为兜底
        if not java_path:
            # 您截图中的实际路径
            candidate = r"C:\Program Files\Java\jdk1.8.0_202\bin\java.exe"
            if os.path.exists(candidate):
                java_path = candidate
                print(f"使用硬编码路径找到 Java: {java_path}")
        
        # 3. 如果以上都没找到，报错提示
        if not java_path:
            return HttpResponse("failed: 无法找到 Java 环境，请确认已安装 JDK 并配置了 JAVA_HOME。")
        
        if not os.path.exists(java_path):
             return HttpResponse(f"failed: 找不到 Java 可执行文件，请检查路径: {java_path}")
        # --- 结束修改 ---

        env = os.environ.copy()
        env['JMETER_HOME'] = os.path.join(current_dir, 'apache-jmeter-5.6.2')
        
        jmeter_cmd = [
            java_path,
            '-jar', apache_jmeter_jar,
            '-n',
            '-t', jmx_path,
            '-l', logfile_path,
            '-e',
            '-o', output_path,
            '-Jlanguage=zh_CN'
        ]

        # 【关键修改】：使用 subprocess.Popen 异步启动 JMeter，不阻塞请求
        # 这样可以立即返回响应，前端可以继续轮询真实状态
        pid_file = os.path.join(current_dir, 'autotest', 'jmeter.pid')
        
        # 启动 JMeter 进程
        process = subprocess.Popen(
            jmeter_cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            universal_newlines=True,
            cwd=current_dir,
            shell=False,
            env=env,
            creationflags=subprocess.CREATE_NEW_PROCESS_GROUP if os.name == 'nt' else 0  # Windows 下创建新进程组
        )
        
        # 保存进程 PID 到文件，便于后续查询状态
        with open(pid_file, 'w') as f:
            f.write(str(process.pid))
        
        print(f"JMeter 进程已启动，PID: {process.pid}")
        
        # 立即返回成功，不等待 JMeter 完成
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


def getJmeterStatus(request):
    """
    检查JMeter进程的真实运行状态
    返回: {"running": true/false, "progress": 当前进度秒数}
    """
    try:
        pid_file = os.path.join(current_dir, 'autotest', 'jmeter.pid')
        
        # 读取保存的PID
        if not os.path.exists(pid_file):
            return HttpResponse(json.dumps({"running": False, "progress": 0}), content_type='application/json')
        
        with open(pid_file, 'r') as f:
            pid = int(f.read().strip())
        
        # 检查进程是否还在运行
        import psutil
        try:
            process = psutil.Process(pid)
            if process.is_running() and process.status() != psutil.STATUS_ZOMBIE:
                # 进程还在运行，计算已经运行的时间
                create_time = process.create_time()
                import time
                elapsed_seconds = int(time.time() - create_time)
                return HttpResponse(json.dumps({
                    "running": True, 
                    "progress": elapsed_seconds,
                    "pid": pid
                }), content_type='application/json')
            else:
                # 进程已结束
                return HttpResponse(json.dumps({"running": False, "progress": 0}), content_type='application/json')
        except psutil.NoSuchProcess:
            # 进程不存在
            return HttpResponse(json.dumps({"running": False, "progress": 0}), content_type='application/json')
    except Exception as e:
        traceback.print_exc()
        # 如果psutil不可用或其他错误，返回未运行状态
        return HttpResponse(json.dumps({"running": False, "progress": 0, "error": str(e)}), content_type='application/json')


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
                        cursor = conne.cursor()
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
    try:
        if (body_format == 'JSON' or body_format == 'json'):
            # 检测是否为 JSON 数组
            if isinstance(body, list):
                body = json.dumps(body, ensure_ascii=False)  # 序列化 JSON 数组
            elif isinstance(body, dict):
                body = json.dumps(body, ensure_ascii=False)  # 序列化 JSON 对象
        else:
            # FORM 格式，不需要 json.dumps
            keys = body.keys()
            for rec in keys:
                if ('[{' in str(body[rec]) and '}]' in str(body[rec])):
                    body = json.dumps(body, ensure_ascii=False)
                    break
    except Exception as e:
        print_log(f'【ERROR】请求体序列化失败：{e}')
        print_log(f'body_format: {body_format}, body type: {type(body)}')
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