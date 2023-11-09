# Autotestplat
一站式自动化测试平台及解决方案
Autotestplat-v2.0版本

功能介绍：
一共7大模块：产品/项目，用户，系统参数设置，接口测试用例，测试计划，定时任务，测试报告。目前是接口，后续会集入UI，性能，智能化，依然是开源的一站式自动化测试平台系统。

部署指南：
python3.6
django2.1
mysql
版本待更新...<br>
1、下载和安装python 3.6、git、mysql、redis等安装包https://github.com/testdevhome/installPackage<br>
2、git clone https://github.com/testdevhome/Autotestplat<br>
3、cd Autotestplat <br>
4、pip install -r requirements.txt<br>
5、创建和导入数据库<br>
创建数据库名autotestplat，导入autotestplat.sql
可能要修改数据库连接配置文件 Autotestplat/settings.py 77行 DATABASES 
6、运行命令 python manage.py runserver 0.0.0.0:80 <br>
7、运行命令 redis-server redis.conf<br>
8、访问 127.0.0.1/autotest/login<br>
9、用户名 fin，密码test123456<br>

操作手册：<br>
第一步、设置用户，设置产品/项目，用户设置默认产品，也就是当前正在进入使用的产品。<br>
第二步、在系统设置中设置参数，环境设置即设置host地址，常量即设置固定值作为参数，变量可以是时间戳，随机数字、字符等。<br>
第三步、在接口用例中进行接口用例录入调试，设置断言，通过正则表达式设置关联参数，执行；在接口中通过{关键字}设置参数。<br>
第四步、在测试计划中选择接口用例，修改接口参数，手动执行调试。<br>
第五步、在定时任务中选择测试计划，保存后执行以及定时自动执行。<br>
第六步、在测试报告中查看测试记录，报告的详情数据。<br>

![image](https://github.com/testdevhome/Doc/blob/main/pic/systemsetting.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/apitestcase.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/editpara.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/testresult.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/testplan.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/task.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/report.png)


    欢迎关注我们的微信公众号，请扫一扫如下图：

![image](https://github.com/testdevhome/Doc/blob/main/pic-V1.0/testdevhome.jpg)



