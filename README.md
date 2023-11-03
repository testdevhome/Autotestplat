# Autotestplat
一站式自动化测试平台及解决方案
Autotestplat-v2.0版本

功能介绍：
一共7大模块：产品/项目，用户，系统参数设置，接口测试用例，测试计划，定时任务，测试报告。目前是接口，后续会集入UI，性能，智能化，依然是开源的一站式自动化测试平台系统。

部署指南：
python3.6
django2.1
mysql
版本待更新...
1、git clone https://github.com/testdevhome/Autotestplat
2、cd Autotestplat
3、pip install -r requirements.txt
4、python manage.py runserver 0.0.0.0:80
5、redis-server redis.windows.conf

操作手册：
第一步、设置用户，设置产品项目，设置系统。其中系统参数的设置 包括<span style="color: red"> 环境设置 </span>即host的url地址设置，<span style="color: red">常量</span>即设置一个固定值作为参数，<span style="color: red"> 变量</span>即通过随机函数获取需要的变量值，可以是时间戳，随机数字，随机字符等。在接口中通过{关键字}获取。
第二步、在接口测试中进行接口用例及调试即接口信息录入，设置<span style="color: red"> 断言</span>，通过正则表达式设置<span style="color: red"> 关联参数</span>，执行；在测试计划中选择用例及调试即选择用例，修改接口参数，手动执行；在定时任务中选择设置要运行的测试计划，保存后执行以及定时自动执行。
第三步、测试报告中查看测试结果。

![image](https://github.com/testdevhome/Doc/blob/main/pic/systemsetting.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/apitestcase.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/editpara.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/testresult.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/testplan.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/task.png)
![image](https://github.com/testdevhome/Doc/blob/main/pic/report.png)


    欢迎关注我们的微信公众号，请扫一扫如下图：

![image](https://github.com/testdevhome/Doc/blob/main/pic-V1.0/testdevhome.jpg)



