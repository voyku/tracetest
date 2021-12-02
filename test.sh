#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
Green_font="\033[32m" && Red_font="\033[31m" && Font_suffix="\033[0m"
Info="${Green_font}[Info]${Font_suffix}"
Error="${Red_font}[Error]${Font_suffix}"
echo -e "${Green_font}
#======================================
# Project: jctestrace
# Version: 0.0.2
# Blog:   https://ybfl.xyz
# Github: https://github.com/Netflixxp
#======================================
${Font_suffix}"

check_system(){
	if   [[ ! -z "`cat /etc/issue | grep -iE "debian"`" ]]; then
		apt-get install traceroute mtr -y
	elif [[ ! -z "`cat /etc/issue | grep -iE "ubuntu"`" ]]; then
		apt-get install traceroute mtr -y
	elif [[ ! -z "`cat /etc/redhat-release | grep -iE "CentOS"`" ]]; then
		yum install traceroute mtr -y
	else
		echo -e "${Error} system not support!" && exit 1
	fi
}
check_root(){
	[[ "`id -u`" != "0" ]] && echo -e "${Error} must be root user !" && exit 1
}
directory(){
	[[ ! -d /home/tstrace ]] && mkdir -p /home/tstrace
	cd /home/tstrace
}
install(){
	[[ ! -d /home/tstrace/besttrace ]] && wget -O besttrace https://github.com/Netflixxp/jcnfbesttrace/releases/download/831/besttrace
	chmod -R +x /home/tstrace
}


test_single(){
	echo -e "${Info} 请输入你要测试的目标 ip :"
	read -p "输入 ip 地址:" ip

	while [[ -z "${ip}" ]]
		do
			echo -e "${Error} 无效输入"
			echo -e "${Info} 请重新输入" && read -p "输入 ip 地址:" ip
		done

	./besttrace -q1 -g cn ${ip} | tee -a -i /home/tstrace/tstrace.log 2>/dev/null

	
}


test_all(){
	result_all	'115.192.48.87'	    '浙江杭州电信'

	result_all	'101.71.241.238'	'浙江杭州联通'

	result_all	'112.17.0.106'		'浙江杭州移动'

	echo -e "${Info} 三网路由快速测试 已完成 ！"
}
result_all(){
	ISP_name=$2
	echo -e "${Info} 测试路由 到 ${ISP_name} 中 ..."
	./besttrace -q1 -g cn $1
	echo -e "${Info} 测试路由 到 ${ISP_name} 完成 ！"
}


check_system
check_root
directory
install
cd besttrace

echo -e "${Info} 选择你要使用的功能: "
echo -e "1.手动输入 ip 进行测试\n2.三网路由快速测试"
read -p "输入数字以选择:" function

	while [[ ! "${function}" =~ ^[1-3]$ ]]
		do
			echo -e "${Error} 缺少或无效输入"
			echo -e "${Info} 请重新选择" && read -p "输入数字以选择:" function
		done

	if [[ "${function}" == "1" ]]; then
		test_single
	elif [[ "${function}" == "2" ]]; then
		test_all | tee -a -i /home/tstrace/tstrace.log 2>/dev/null
	fi
