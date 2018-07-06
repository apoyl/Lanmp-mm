#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2014-2015 apoyl.com  All rights reserved. 

source ./scode/config.sh
source ./scode/func.sh
runparam=$(echo $1|tr '[A-Z]' '[a-z]')
[ ! -z "${runparam}" ] || msgFail "Please select an installation environment of:LNMP or LAMP\nExample:./main.sh LNMP"
run=`runSoft $runparam`
[ ! -z "${run}" ] || msgFail "Select the installation environment error"
#新建相关目录
mkDir ${installdir}
mkDir ${sourcedir}
mkDir ${compliedir}
mkDir ${logdir}

#检查基础命令
#psmisc包含(killall)
which make tar gcc wget killall 
errnum=$?
if [ ${errnum} -gt 0 ]
then
	yum -y install make tar gcc gcc-c++ wget psmisc
fi


#获取文件名，md5
for v in ${run[*]}
do
	#文件名，md5
	s=`eval echo \\$${v}`
	srule=`eval echo \\$${v}rule`
	fileurl=`echo ${s}|cut -d\| -f1`
	filename=`basename ${fileurl}`
	filemd5=`echo ${3}|cut -d\| -f2`
	compliename=${v}
	#判断文件是否存在,并下载文件 ,暂未检验文件
	if ! fileExist "${sourcedir}/${filename}"
	then
		downFile ${fileurl} ${filename} ${filemd5}
	fi
	#创建编译目录
	mkDir ${compliedir}/${compliename}
	#解压文件	
	source ./scode/apoylextract.sh ${sourcedir}/${filename} ${compliedir}/${compliename}
	setColor green "${compliename}--Unzip the file to the end"	
	#进入预编译目录
	setColor green "${compliename}--To begin precomplied software and install software......"
	cd ${compliedir}/${compliename}/* 
	#echo  ${compliedir}/${compliename}/* 
	cleng=`echo $srule|grep -o ","|wc -l`
	
	for ((i=1;i<=${cleng}+1;i++))
	do
		tmp=`echo $srule|cut -d\, -f$i`
		
		if [ ! -z "$tmp" ]
		then	
			eval ${tmp} 1>>${logdir}/${v}-`date +%Y%m%d`  || msgFail "Precomplie  failed" 
		fi
	done
	#返回主目录
	cd ${pwddir}
	setColor green "$compliename--Install the software successfully !"
	#sleep 3
done
	#启动LNMP LAMP
	source ./scode/${runparam}start.sh
