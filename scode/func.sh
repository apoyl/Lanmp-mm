#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2014-2099 apoyl.com  All rights reserved.

mkDir(){
   local _dirname=$1
   [ ! -d "${_dirname}" ] && mkdir -p ${_dirname}
   
}
setColor(){
   local _colorname=$1
   local _msg=$2
   case ${_colorname} in
        "red")
	color="\033[47;31m"
	;;
	"green")
	color="\033[47;32m"
	;;
	"yellow")
	color="\033[47;33m"
	;;
	*)
	color="\033[47;30m"
	;;
esac
	echo -e "${color}${_msg}"
	echo -ne "\033[47;30m"
}
msgFail(){
	local _msg=$1
	
	setColor red "$_msg"
	exit 1
}
#判断文件是否存在
fileExist(){
   local _filepath=$1
   if  [ -f ${_filepath} ]
   then
	setColor yellow "${_filepath} already exists "
	return 0 
   fi	
	setColor red "${_filepath} not exists"
	return 1
}
#下载文件
downFile(){
   local _url=$1
   local _filename=$2
   local _md5sum=$3
   setColor green "Start Download ${_filename}......"} 
   if wget ${_url} -O $sourcedir/${_filename}
   then
	:
   else
	setColor red "${_filename} Download failed"
	exit 1
   fi
}
#安装软件
runSoft(){
   local _name=$1
   case "${_name}" in
	"lnmp")
	run=(re2c013 libmcrypt25 mysql57 php73 nginx114)
	;;
	"lnmp5")
	run=(re2c013 libmcrypt25 mysql51 php54 nginx16)
	;;
	"lamp")
	run=(apr17 aprutil16 mysql57 apache24 phpap73)
	;;
	"np")
	run=(php73 nginx114)
	;;
	"ap")
	run=(apr17 aprutil16 apache24 phpap73)
	;;
	"${_name}")
	run=(${_name})
	;;
	"lampold")
	run=(mysql51 apache22 phpap54)
	;;
	*)
	exit 1
	
	;;
esac
   echo ${run[*]}  
}
