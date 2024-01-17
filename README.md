# ipmi.sh
利用ipmitool对Dell服务器状态进行查询和设置，理论上其他支持ipmi的服务器也可以支持，但未经过测试
包括：
1. 风扇转速
2. 温度（进出风温度，核心温度）
3. 电压
4. 功率
5. 其他

20231226 Updated:
1. 优化了输出内容
2. 新增了调整到风扇自动模式
3. 新增了服务器电源状态查看
4. 新增了服务器电源操作

使用前需先安装ipmitool

**Mac：**

```
brew install ipmitool
```

**Linux:**

Ubuntu

```
apt-get install -y ipmitool
```

CentOS

```
yum install -y ipmitool
```


**Windows:**

Windows不适用，但经过适当转换及使用ipmitool.exe也可实现，后期有空更新

建议直接使用GUI版本，相关项目链接：

https://github.com/cw1997/dell_fans_controller

https://github.com/jiafeng5513/dell_fans_controller

个人比较喜欢第二个

## 使用方法
使用前需编辑脚本，修改其中的用户名、密码和IP

将user更换为登录idrac的用户名

```
username="user"
```

将pwd更换为登录idrac的密码

```
password="pwd"
```

将127.0.0.1更换为访问idrac的IP

```
IDRAC_IP="127.0.0.1"
```

修改好用户名、密码和IP后：

```
bash ipmi.sh
```

输入对应的数字即可，部分功能需要获取的信息较多需要等待几秒

下面是执行效果
```
root@ubuntu:~# bash ipmi.sh 
----------------------------------------
|*****************MENU*****************|
----------------------------------------
 1)Get Server Status
 2)Set Fan Speed
 3)Get Fan Speed
 4)Get Server Temperature
 5)Get Server Power
 6)Back Menu
 7)EXIT
Please enter the number:1
Fan1             | 30h | ok  |  7.1 | 2280 RPM
Fan2             | 31h | ok  |  7.1 | 2280 RPM
Fan3             | 32h | ok  |  7.1 | 2280 RPM
Fan4             | 33h | ok  |  7.1 | 2280 RPM
Fan5             | 34h | ok  |  7.1 | 2280 RPM
Fan6             | 35h | ok  |  7.1 | 2160 RPM
Fan Redundancy   | 75h | ok  |  7.1 | Fully Redundant
Inlet Temp       | 04h | ok  |  7.1 | 5 degrees C
Exhaust Temp     | 01h | ok  |  7.1 | 19 degrees C
Temp             | 0Eh | ok  |  3.1 | 25 degrees C
Temp             | 0Fh | ok  |  3.2 | 25 degrees C
Voltage 1        | 6Ch | ok  | 10.1 | 214 Volts
Voltage 2        | 6Dh | ok  | 10.2 | 214 Volts
Current 1        | 6Ah | ok  | 10.1 | 0.80 Amps
Current 2        | 6Bh | ok  | 10.2 | 0.20 Amps
Pwr Consumption  | 77h | ok  |  7.1 | 154 Watts
Press any key to continue...
----------------------------------------
|*****************MENU*****************|
----------------------------------------
 1)Get Server Status
 2)Set Fan Speed
 3)Get Fan Speed
 4)Get Server Temperature
 5)Get Server Power
 6)Back Menu
 7)EXIT
Please enter the number:2
Enter fans speed percent(0-100):10


Press any key to continue...
----------------------------------------
|*****************MENU*****************|
----------------------------------------
 1)Get Server Status
 2)Set Fan Speed
 3)Get Fan Speed
 4)Get Server Temperature
 5)Get Server Power
 6)Back Menu
 7)EXIT
Please enter the number:3
Fan1             | 30h | ok  |  7.1 | 2280 RPM
Fan2             | 31h | ok  |  7.1 | 2280 RPM
Fan3             | 32h | ok  |  7.1 | 2280 RPM
Fan4             | 33h | ok  |  7.1 | 2160 RPM
Fan5             | 34h | ok  |  7.1 | 2280 RPM
Fan6             | 35h | ok  |  7.1 | 2160 RPM
Press any key to continue...
----------------------------------------
|*****************MENU*****************|
----------------------------------------
 1)Get Server Status
 2)Set Fan Speed
 3)Get Fan Speed
 4)Get Server Temperature
 5)Get Server Power
 6)Back Menu
 7)EXIT
Please enter the number:4
Inlet Temp       | 04h | ok  |  7.1 | 5 degrees C
Exhaust Temp     | 01h | ok  |  7.1 | 19 degrees C
Temp             | 0Eh | ok  |  3.1 | 24 degrees C
Temp             | 0Fh | ok  |  3.2 | 25 degrees C
Press any key to continue...
----------------------------------------
|*****************MENU*****************|
----------------------------------------
 1)Get Server Status
 2)Set Fan Speed
 3)Get Fan Speed
 4)Get Server Temperature
 5)Get Server Power
 6)Back Menu
 7)EXIT
Please enter the number:5
Pwr Consumption  | 77h | ok  |  7.1 | 154 Watts
Press any key to continue... 
----------------------------------------
|*****************MENU*****************|
----------------------------------------
 1)Get Server Status
 2)Set Fan Speed
 3)Get Fan Speed
 4)Get Server Temperature
 5)Get Server Power
 6)Back Menu
 7)EXIT
Please enter the number:7
root@ubuntu:~# 
```
