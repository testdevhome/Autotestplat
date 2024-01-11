# -*- coding: utf-8 -*-
import datetime
import codecs
import os

current_dir = os.getcwd()
jmxfile = os.path.join(current_dir, 'apache-jmeter-5.6.2/bin', 'apitest.jmx')
usersfile = os.path.join(current_dir, 'autotest', 'users.txt')
usersfile = usersfile.replace('\\', '/')

def body_request(jid,jname,jhost,jport,jpath,jscheme,jbody,jhead,jassert):
    ss =    '      <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="'+jname+'" enabled="true">\n' \
            '        <boolProp name="HTTPSampler.postBodyRaw">true</boolProp>\n' \
            '        <elementProp name="HTTPsampler.Arguments" elementType="Arguments">\n' \
            '          <collectionProp name="Arguments.arguments">\n' \
            '            <elementProp name="" elementType="HTTPArgument">\n' \
            '              <boolProp name="HTTPArgument.always_encode">false</boolProp>\n' \
            '              <stringProp name="Argument.value">'+jbody+'</stringProp>\n'\
            '              <stringProp name="Argument.metadata">=</stringProp>\n' \
            '            </elementProp>\n' \
            '          </collectionProp>\n' \
            '        </elementProp>\n' \
            '        <stringProp name="HTTPSampler.domain">'+jhost+'</stringProp>\n' \
            '        <stringProp name="HTTPSampler.port">'+jport+'</stringProp>\n' \
            '        <stringProp name="HTTPSampler.connect_timeout"></stringProp>\n' \
            '        <stringProp name="HTTPSampler.response_timeout"></stringProp>\n' \
            '        <stringProp name="HTTPSampler.protocol">'+jscheme+'</stringProp>\n' \
            '        <stringProp name="HTTPSampler.contentEncoding">UTF-8</stringProp>\n' \
            '        <stringProp name="HTTPSampler.path">'+jpath+'</stringProp>\n' \
            '        <stringProp name="HTTPSampler.method">POST</stringProp>\n' \
            '        <boolProp name="HTTPSampler.follow_redirects">false</boolProp>\n' \
            '        <boolProp name="HTTPSampler.auto_redirects">true</boolProp>\n' \
            '        <boolProp name="HTTPSampler.use_keepalive">false</boolProp>\n' \
            '        <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>\n' \
            '        <stringProp name="HTTPSampler.implementation">Java</stringProp>\n' \
            '        <boolProp name="HTTPSampler.monitor">false</boolProp>\n' \
            '        <stringProp name="HTTPSampler.embedded_url_re"></stringProp>\n' \
            '      </HTTPSamplerProxy>\n' \
            '    <hashTree>\n'+body_httpheader(jhead)+body_reg()+body_assert(jassert)+'      <hashTree/>\n'\
            +body_result() + '     <hashTree/>\n'\
            '     </hashTree>\n'
    return ss

def body_request2(jid,jname,jhost,jport,jpath,jscheme,jbody,jcookie,jhead,jassert,):
    ss =    '      <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="'+jname+'" enabled="true">\n' \
            '        <boolProp name="HTTPSampler.postBodyRaw">true</boolProp>\n' \
            '        <elementProp name="HTTPsampler.Arguments" elementType="Arguments">\n' \
            '          <collectionProp name="Arguments.arguments">\n' \
            '            <elementProp name="" elementType="HTTPArgument">\n' \
            '              <boolProp name="HTTPArgument.always_encode">false</boolProp>\n' \
            '              <stringProp name="Argument.value">'+jbody+'</stringProp>\n'\
            '              <stringProp name="Argument.metadata">=</stringProp>\n' \
            '            </elementProp>\n' \
            '          </collectionProp>\n' \
            '        </elementProp>\n' \
            '        <stringProp name="HTTPSampler.domain">'+jhost+'</stringProp>\n' \
            '        <stringProp name="HTTPSampler.port">'+jport+'</stringProp>\n' \
            '        <stringProp name="HTTPSampler.connect_timeout"></stringProp>\n' \
            '        <stringProp name="HTTPSampler.response_timeout"></stringProp>\n' \
            '        <stringProp name="HTTPSampler.protocol">'+jscheme+'</stringProp>\n' \
            '        <stringProp name="HTTPSampler.contentEncoding">UTF-8</stringProp>\n' \
            '        <stringProp name="HTTPSampler.path">'+jpath+'</stringProp>\n' \
            '        <stringProp name="HTTPSampler.method">POST</stringProp>\n' \
            '        <boolProp name="HTTPSampler.follow_redirects">false</boolProp>\n' \
            '        <boolProp name="HTTPSampler.auto_redirects">true</boolProp>\n' \
            '        <boolProp name="HTTPSampler.use_keepalive">false</boolProp>\n' \
            '        <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>\n' \
            '        <stringProp name="HTTPSampler.implementation">Java</stringProp>\n' \
            '        <boolProp name="HTTPSampler.monitor">false</boolProp>\n' \
            '        <stringProp name="HTTPSampler.embedded_url_re"></stringProp>\n' \
            '      </HTTPSamplerProxy>\n' \
            '    <hashTree>\n'+body_httpcookie(jcookie)+body_httpheader(jhead)+body_reg()+body_assert(jassert)+'      <hashTree/>\n'\
            '     </hashTree>\n'
    return ss

def body_testplan():
    ss ='    <TestPlan guiclass="TestPlanGui" testclass="TestPlan" testname="测试计划" enabled="true">\n' \
                   '      <stringProp name="TestPlan.comments"></stringProp>\n' \
                   '      <boolProp name="TestPlan.functional_mode">false</boolProp>\n' \
                   '      <boolProp name="TestPlan.tearDown_on_shutdown">true</boolProp>\n' \
                   '      <boolProp name="TestPlan.serialize_threadgroups">false</boolProp>\n' \
                   '      <elementProp name="TestPlan.user_defined_variables" elementType="Arguments" guiclass="ArgumentsPanel" testclass="Arguments" testname="用户定义的变量" enabled="true">\n' \
                   '        <collectionProp name="Arguments.arguments"/>\n' \
                   '      </elementProp>\n' \
                   '      <stringProp name="TestPlan.user_define_classpath"></stringProp>\n'\
                   '    </TestPlan>\n' \
                   '    <hashTree>\n'
    return  ss

def body_thread(jid,numbf,numxh):
    ss =    '    <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="线程组-登录" enabled="true">\n'\
            '      <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>\n' \
            '      <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="循环控制器" enabled="true">\n' \
            '        <boolProp name="LoopController.continue_forever">false</boolProp>\n' \
            '        <stringProp name="LoopController.loops">'+numxh+'</stringProp>\n' \
            '      </elementProp>\n' \
            '      <stringProp name="ThreadGroup.num_threads">'+numbf+'</stringProp>\n' \
            '      <stringProp name="ThreadGroup.ramp_time">1</stringProp>\n' \
            '      <longProp name="ThreadGroup.start_time">1450158187000</longProp>\n' \
            '      <longProp name="ThreadGroup.end_time">1450158187000</longProp>\n' \
            '      <boolProp name="ThreadGroup.scheduler">true</boolProp>\n' \
            '      <stringProp name="ThreadGroup.duration">60</stringProp>\n' \
            '      <stringProp name="ThreadGroup.delay"></stringProp>\n' \
            '    </ThreadGroup>\n' \
            '    <hashTree>\n'
    return  ss

def body_thread2(jid,numbf,numxh,numsj):
    ss =    '     <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="线程组" enabled="true">\n'\
            '      <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>\n' \
            '      <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="循环控制器" enabled="true">\n' \
            '        <boolProp name="LoopController.continue_forever">false</boolProp>\n' \
            '        <stringProp name="LoopController.loops">'+numxh+'</stringProp>\n' \
            '      </elementProp>\n' \
            '      <stringProp name="ThreadGroup.num_threads">'+numbf+'</stringProp>\n' \
            '      <stringProp name="ThreadGroup.ramp_time">1</stringProp>\n' \
            '      <longProp name="ThreadGroup.start_time">1450158187000</longProp>\n' \
            '      <longProp name="ThreadGroup.end_time">1450158187000</longProp>\n' \
            '      <boolProp name="ThreadGroup.scheduler">true</boolProp>\n' \
            '      <stringProp name="ThreadGroup.duration">'+numsj+'</stringProp>\n' \
            '      <stringProp name="ThreadGroup.delay"></stringProp>\n' \
            '    </ThreadGroup>\n' \
            '    <hashTree>\n'
    return  ss

def body_cookie(key,value):
    ss =   '          <elementProp name="'+key+'" elementType="Cookie" testname="'+key+'">\n' \
           '            <stringProp name="Cookie.value">'+value+'</stringProp>\n' \
           '            <stringProp name="Cookie.domain">testone.0easy.com</stringProp>\n' \
           '            <stringProp name="Cookie.path"></stringProp>\n' \
           '            <boolProp name="Cookie.secure">false</boolProp>\n' \
           '            <longProp name="Cookie.expires">0</longProp>\n' \
           '            <boolProp name="Cookie.path_specified">true</boolProp>\n' \
           '            <boolProp name="Cookie.domain_specified">true</boolProp>\n' \
           '          </elementProp>\n'
    return ss

def body_httpcookie(cookie):
    ss =    '       <CookieManager guiclass="CookiePanel" testclass="CookieManager" testname="HTTP Cookie 管理器" enabled="true">\n' \
            '        <collectionProp name="CookieManager.cookies">\n' + cookie+\
            '        </collectionProp>\n' \
            '       <boolProp name="CookieManager.clearEachIteration">false</boolProp>\n'\
            '      </CookieManager>\n' \
            '      <hashTree/>\n'\

    return  ss

def body_head(key,value):
    ss =   '          <elementProp name="" elementType="Header">\n' \
           '            <stringProp name="Header.name">'+key+'</stringProp>\n' \
           '            <stringProp name="Header.value">'+value+'</stringProp>\n'\
           '          </elementProp>\n'
    return ss

def body_httpheader(head):
    ss =    '      <HeaderManager guiclass="HeaderPanel" testclass="HeaderManager" testname="HTTP信息头管理器" enabled="true">\n' \
            '        <collectionProp name="HeaderManager.headers">\n' + head+\
            '        </collectionProp>\n' \
            '      </HeaderManager>\n' \
            '      <hashTree/>\n'
    return  ss

def body_reg():
    ss =    '      <RegexExtractor guiclass="RegexExtractorGui" testclass="RegexExtractor" testname="正则表达式token" enabled="true">\n' \
            '        <stringProp name="RegexExtractor.useHeaders">false</stringProp>\n' \
            '        <stringProp name="RegexExtractor.refname">token</stringProp>\n' \
            '        <stringProp name="RegexExtractor.regex">&quot;token&quot;:&quot;(.+?)&quot;</stringProp>\n' \
            '        <stringProp name="RegexExtractor.template">$1$</stringProp>\n' \
            '        <stringProp name="RegexExtractor.default">null</stringProp>\n' \
            '        <stringProp name="RegexExtractor.match_number">0</stringProp>\n' \
            '      </RegexExtractor>\n'
    return  ss

def body_assert(jassert):
    ss =    '      <hashTree/>\n'\
            '      <ResponseAssertion guiclass="AssertionGui" testclass="ResponseAssertion" testname="响应断言" enabled="true">\n' \
            '        <collectionProp name="Asserion.test_strings">\n' \
            '          <stringProp name="67791721">'+jassert+'</stringProp>\n' \
            '        </collectionProp>\n' \
            '        <stringProp name="Assertion.test_field">Assertion.response_data</stringProp>\n' \
            '        <boolProp name="Assertion.assume_success">false</boolProp>\n' \
            '        <intProp name="Assertion.test_type">16</intProp>\n' \
            '      </ResponseAssertion>\n'
    return  ss

def body_result():
    ss =    '      <ResultCollector guiclass="ViewResultsFullVisualizer" testclass="ResultCollector" testname="察看结果树" enabled="true">\n' \
            '        <boolProp name="ResultCollector.error_logging">false</boolProp>\n' \
            '        <objProp>\n' \
            '          <name>saveConfig</name>\n' \
            '          <value class="SampleSaveConfiguration">\n' \
            '            <time>true</time>\n' \
            '            <latency>true</latency>\n' \
            '            <timestamp>true</timestamp>\n' \
            '            <success>true</success>\n' \
            '            <label>true</label>\n' \
            '            <code>true</code>\n' \
            '            <message>true</message>\n' \
            '            <threadName>true</threadName>\n' \
            '            <dataType>true</dataType>\n' \
            '            <encoding>false</encoding>\n' \
            '            <assertions>true</assertions>\n' \
            '            <subresults>true</subresults>\n' \
            '            <responseData>false</responseData>\n' \
            '            <samplerData>false</samplerData>\n' \
            '            <xml>false</xml>\n' \
            '            <fieldNames>false</fieldNames>\n' \
            '            <responseHeaders>false</responseHeaders>\n' \
            '            <requestHeaders>false</requestHeaders>\n' \
            '            <responseDataOnError>false</responseDataOnError>\n' \
            '            <saveAssertionResultsFailureMessage>false</saveAssertionResultsFailureMessage>\n' \
            '            <assertionsResultsToSave>0</assertionsResultsToSave>\n' \
            '            <bytes>true</bytes>\n' \
            '            <threadCounts>true</threadCounts>\n' \
            '          </value>\n' \
            '        </objProp>\n' \
            '        <stringProp name="filename"></stringProp>\n' \
            '       </ResultCollector>\n'
    return  ss

def body_users():
    ss = '  <CSVDataSet guiclass="TestBeanGUI" testclass="CSVDataSet" testname="CSV 数据文件设置" enabled="true">\n'\
         '    <stringProp name="filename">'+usersfile+'</stringProp>\n'\
         '      <stringProp name="fileEncoding"></stringProp>\n'\
         '      <stringProp name="variableNames">username,password</stringProp>\n'\
         '       <boolProp name="ignoreFirstLine">false</boolProp>\n'\
         '       <stringProp name="delimiter">,</stringProp>\n'\
         '       <boolProp name="quotedData">false</boolProp>\n'\
         '       <boolProp name="recycle">true</boolProp>\n'\
         '       <boolProp name="stopThread">false</boolProp>\n'\
         '       <stringProp name="shareMode">shareMode.all</stringProp>\n'\
         '     </CSVDataSet>\n'\
         '    <hashTree/>\n'
    return ss

def body_report():
    ss = '    <ResultCollector guiclass="StatVisualizer" testclass="ResultCollector" testname="聚合报告" enabled="true">\n' \
         '      <boolProp name="ResultCollector.error_logging">false</boolProp>\n' \
         '      <objProp>\n' \
         '        <name>saveConfig</name>\n' \
         '        <value class="SampleSaveConfiguration">\n' \
         '          <time>true</time>\n' \
         '          <latency>true</latency>\n' \
         '          <timestamp>true</timestamp>\n' \
         '          <success>true</success>\n' \
         '          <label>true</label>\n' \
         '          <code>true</code>\n' \
         '          <message>true</message>\n' \
         '          <threadName>true</threadName>\n' \
         '          <dataType>true</dataType>\n' \
         '          <encoding>false</encoding>\n' \
         '          <assertions>true</assertions>\n' \
         '          <subresults>true</subresults>\n' \
         '          <responseData>false</responseData>\n' \
         '          <samplerData>false</samplerData>\n' \
         '          <xml>false</xml>\n' \
         '          <fieldNames>true</fieldNames>\n' \
         '          <responseHeaders>false</responseHeaders>\n' \
         '          <requestHeaders>false</requestHeaders>\n' \
         '          <responseDataOnError>false</responseDataOnError>\n' \
         '          <saveAssertionResultsFailureMessage>true</saveAssertionResultsFailureMessage>\n' \
         '          <assertionsResultsToSave>0</assertionsResultsToSave>\n' \
         '          <bytes>true</bytes>\n' \
         '          <sentBytes>true</sentBytes>\n' \
         '          <threadCounts>true</threadCounts>\n' \
         '          <idleTime>true</idleTime>\n' \
         '          <connectTime>true</connectTime>\n' \
         '        </value>\n' \
         '       </objProp>\n' \
         '      <stringProp name="filename"></stringProp>\n'\
         '    </ResultCollector>\n'
    return  ss

def body_para():
    ss ='      <Arguments guiclass="ArgumentsPanel" testclass="Arguments" testname="用户定义的变量" enabled="true">\n' \
            '        <collectionProp name="Arguments.arguments">\n' \
            '          <elementProp name="email" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">email</stringProp>\n' \
            '            <stringProp name="Argument.value">1234571@qq.com</stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '          <elementProp name="app_key" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">app_key</stringProp>\n' \
            '            <stringProp name="Argument.value"></stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '          <elementProp name="os" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">os</stringProp>\n' \
            '            <stringProp name="Argument.value">ios</stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '          <elementProp name="app_version" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">app_version</stringProp>\n' \
            '            <stringProp name="Argument.value">3.3</stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '          <elementProp name="ime" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">ime</stringProp>\n' \
            '            <stringProp name="Argument.value">359254061584926</stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '          <elementProp name="password" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">password</stringProp>\n' \
            '            <stringProp name="Argument.value">111111</stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '          <elementProp name="crc" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">crc</stringProp>\n' \
            '            <stringProp name="Argument.value"></stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '          <elementProp name="key" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">key</stringProp>\n' \
            '            <stringProp name="Argument.value"></stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '          <elementProp name="time" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">time</stringProp>\n' \
            '            <stringProp name="Argument.value">20151215134520</stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '          <elementProp name="orderId" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">orderId</stringProp>\n' \
            '            <stringProp name="Argument.value">${orderId}</stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '          <elementProp name="cardId" elementType="Argument">\n' \
            '            <stringProp name="Argument.name">cardId</stringProp>\n' \
            '            <stringProp name="Argument.value">${cardId}</stringProp>\n' \
            '            <stringProp name="Argument.metadata">=</stringProp>\n' \
            '          </elementProp>\n' \
            '        </collectionProp>\n' \
            '      </Arguments>\n'\
            '      <hashTree/>\n'
    return  ss

def body_tran():
    ss = '    <TransactionController guiclass="TransactionControllerGui" testclass="TransactionController" testname="事务控制器" enabled="true">\n'\
        '      <boolProp name="TransactionController.includeTimers">false</boolProp>\n'\
        '      <boolProp name="TransactionController.parent">false</boolProp>\n'\
        '     </TransactionController>\n'\
        '     <hashTree>\n'
    return  ss

def generate_jmx(jname,jhost,jport,jpath,jscheme,jbody):
    File = jmxfile
    File1 = open(File,'a')
    File1.truncate()
    File1.flush()
    File1.close()

    File2 = codecs.open(File,'r','ansi')
    bo_testplan = body_testplan()
    bo_report = body_report()

    body =  '<?xml version="1.0" encoding="UTF-8"?>\n'\
            '<jmeterTestPlan version="1.2" properties="5.0" jmeter="5.6.2">\n' \
            '  <hashTree>\n'  + bo_testplan + body_users() + jbody  + body_result() + \
            '   <hashTree/>\n' + bo_report + \
            '   <hashTree/>\n' \
            '   </hashTree>\n' \
            '  </hashTree>\n' \
            ' </hashTree>\n' \
            ' </hashTree>\n' \
            '</jmeterTestPlan>\n'\

    File2 = codecs.open(File,'w','utf-8')
    File2.write(body)
    File2.flush()
    File2.close()


def generate_jmx2(jname,jhost,jport,jpath,jscheme,jbody):
    File = jmxfile
    File1 = open(File,'a')
    File1.truncate()
    File1.flush()
    File1.close()

    File2 = codecs.open(File,'r','ansi')
    bo_testplan = body_testplan()
    bo_report = body_report()


    body =  '<?xml version="1.0" encoding="UTF-8"?>\n'\
            '<jmeterTestPlan version="1.2" properties="4.0" jmeter="4.0 r1823414">\n' \
            '  <hashTree>\n'  + bo_testplan + jbody  + body_result() + \
            '   <hashTree/>\n' + bo_report + \
            '     <hashTree/>\n' \
            '    </hashTree>\n' \
            '   </hashTree>\n' \
            '  </hashTree>\n' \
            ' </hashTree>\n' \
            '</jmeterTestPlan>\n'\

    File2 = codecs.open(File,'w','utf-8')
    File2.write(body)
    File2.flush()
    File2.close()


