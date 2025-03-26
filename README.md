# Autotestplat

目前版本已升级到6.0，接入了大模型，支持AI生成测试用例，是付费版本，如有需要请请联系作者购买！

AI+自动化测试平台系统
Autotestplat-v5.2.2版本

功能介绍：<br>
实现了接口自动化测试，产品/项目，用户，系统参数设置，接口测试用例，测试计划，定时任务，测试报告。<br>
实现了实时接口性能测试，生成测试脚本，执行测试，测试报告。<br>
实现了AppUI自动化设置，用例录入，单个用例运行，全部用例运行。<br>
实现了WebUI自动化设置，用例录入，单个用例执行，全部用例执行。
<br>

部署指南：
python3.6
django2.1.3
更高版本待后续更新...<br>
1、下载和安装python 3.6、git、mysql、redis等安装包https://github.com/testdevhome/installPackage<br>
2、git clone https://github.com/testdevhome/Autotestplat<br>
3、cd Autotestplat <br>
4、pip install -r requirements.txt<br>
5、创建和导入数据库<br>
创建数据库名autotestplat，导入autotestplat.sql
修改数据库连接配置文件 Autotestplat/settings.py 77行 DATABASES 
6、运行命令 python manage.py runserver 0.0.0.0:80 <br>
7、运行命令 redis-server redis.conf<br>
8、python manage.py celery worker -c 6 -l debug<br>
9、python manage.py celery beat<br>
10、访问 127.0.0.1/autotest/login<br>

操作手册：<br>
接口测试<br>
第一步、设置用户，设置产品/项目，用户设置默认产品，也就是当前正在进入使用的产品。<br>
第二步、在系统设置中设置参数，环境设置即设置host地址，常量即设置固定值作为参数，变量可以是时间戳，随机数字、字符等。<br>
第三步、在接口用例中进行接口用例录入调试，设置断言，通过正则表达式设置关联参数，执行；在接口中通过{关键字}设置参数。<br>
第四步、在测试计划中选择接口用例，定时设置，勾选用例调试。<br>
第五步、在测试报告中查看测试记录，报告的详情数据。<br>
性能测试<br>
第一步、选择接口，输入并发数，持续压测时间，点击生成jmeter脚本。<br>
第二步、点击测试开始。<br>
第三步、点击查看结果。<br>
AppUI测试<br>
第一步、系统设置App设置。<br>
第二步、启动weditor，连接手机，抓取App元素控件，录入用例。<br>
第三步、执行，查看用例结果。<br>
WebUI测试<br>
第一步、系统设置Web设置。<br>
第二步、安装谷歌浏览器版本100.0.4896.75 (正式版本) （32 位）。<br>
第三步、执行，查看用例结果。<br>

![image](https://github.com/testdevhome/Doc/blob/main/pic/userproduct.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/systemsetting.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/testcase.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/edittestcase.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/testplan.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/addapi.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/report.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/performance.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/appUI.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/webUI.png)


    欢迎关注我们的微信公众号，请扫一扫如下图：

![image](https://github.com/testdevhome/Doc/blob/main/pic-V1.0/testdevhome.jpg)



