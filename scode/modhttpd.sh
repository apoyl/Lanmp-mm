#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2014-2015 apoyl.com  All rights reserved. 

apacheversion=apache2

if [ -n "$1" ]
then
	apacheversion=$1
fi


httpdc="$installdir/$apacheversion/conf/httpd.conf"
sed  -i "s:$installdir/$apacheversion/htdocs:$sitedir:g" $httpdc
sed  -i "s:you@example.com:jar-c@163.com:g" $httpdc
sed  -i  "s:#ServerName www.example.com\:80:ServerName 127.0.0.1:g" $httpdc
sed  -i  '/AddType application\/x-gzip .gz .tgz/a\AddType application\/x-httpd-php .php' $httpdc
