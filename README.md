此脚本为测试vps回程一键脚本（修改完善版）
---------------
 
 **一键脚本**
 
下载脚本并直接运行
````
wget -O test.sh https://raw.githubusercontent.com/voyku/tracetest/main/test.sh && chmod 755 test.sh &&./test.sh
````
运行脚本（再次检查仅需运行下面代码）

````
bash test.sh
````
    
**功能说明**

脚本的安装目录位于 /home/testrace
测试完成并退出脚本后，会生成测试的记录文件于 /home/testrace/testrace.log
运行脚本后将出现三个选项，分别为

- 1.手动输入ip进行测试
- 2.三网路由快速测试

输入数字选择需要进行的测试。

其中手动输入的意思为指定IP测试，获取自己ip可前往https://www.ipip.net/


----------


脚本修改自 南琴浪 https://github.com/nanqinlang-script/testrace
