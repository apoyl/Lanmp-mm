#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2023-2099 apoyl.com  All rights reserved. 

source ./scode/config.sh

str="
ulimit -HSn 65535
\n${installdir}/php81/sbin/php-fpm
\n${installdir}/nginx/sbin/nginx
\n${installdir}/mysql/bin/mysqld --defaults-file=${installdir}/mysql/my.cnf --basedir=${installdir}/mysql --datadir=${dbdir} --port=3306 --user=mysql --pid-file=${dbdir}/mysqld.pid  --socket=/tmp/mysql.sock --explicit_defaults_for_timestamp"

echo -e $str>>/etc/rc.local

chmod a+x /etc/rc.d/rc.local
