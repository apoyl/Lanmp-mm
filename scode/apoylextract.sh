#!/bin/sh
#  BLOG SITE:http://www.apoyl.com/
#  AUTHOR:(凹凸曼)lyc
#  EMAIL: jar-c@163.com

#  HELP  TIPS:  ./apoylextract.sh -h 
#  EXAMPLE: apoylextract.sh  test.tar
#  COPYRIGHT © 2011-2012 apoyl.com  All rights reserved. 

factory(){
	local _dir=$3
case "$2" in
	"$1: bzip2 compressed"*)
		bunzip2 "$1";;
	"$1: gzip compressed"*)
		ggzip $1 ${_dir};;
	"$1: XZ compressed"*)
		ggzip $1 ${_dir};;
	"$1: POSIX tar"*)
		tar -xvf "$1";;
	"$1: Zip archive"*)
		unzip "$1";;
	"$1: ERROR: cannot open"*)
		setColor red " '$1' file do not exist ! "
		exit 0;;
	*) setColor red " '$1' file type not supported ! "
		exit 0;;
esac
}

ggzip(){
	local _file=$1
	local _dir=$2
	#na=$(awk -v argone=${_file} 'BEGIN{split(argone,name,".")}END{print name[2]}' /dev/null)
	na=$(echo ${_file} | sed 's/^.*\.//')
	nanew=$(echo ${_file: -6})

        if [ x"$nanew"=x"tar.gz" ];then
                tar -zxvf "${_file}"  -C ${_dir}
	elif [ x"$na" = x"tar" ];then
		tar -xvf "${_file}"  -C ${_dir} 
	elif [ x"$na" = x"gz" ];then
                gunzip "${_file}" -c ${_dir}
	elif [ x"$na" = x"xz" ];then 
		tar -xvf "${_file}" -C ${_dir}
	else
		tar -zxvf "${_file}" -C ${_dir}
	fi

}
help(){
cat << HELP
	DECOMPRESSION TOOL :apoylextract.sh
	TYPES OF SUPPORT   :*.bz2, *.gz, *.tar, *.tar.gz, *.zip

	EXAMPLE: ./apoylextract.sh  test.tar /some/dir
HELP
exit 0
}

[ "-h" = "$1" ] && help

factory $1 "`file "$1"`" $2
