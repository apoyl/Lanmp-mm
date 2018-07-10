#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2014-2099 apoyl.com  All rights reserved. 

#启动之前先干掉MYSQL
killall ${installdir}/mysql/bin/mysqld
sleep 1
#启动mysql
ulimit -HSn 65535
setColor green "MYSQL start ....."
`nohup ${installdir}/mysql/bin/mysqld --defaults-file=${installdir}/mysql/my.cnf --basedir=${installdir}/mysql --datadir=${dbdir} --port=3306 --user=mysql --pid-file=${dbdir}/mysqld.pid  --socket=/tmp/mysql.sock --explicit_defaults_for_timestamp > /dev/null 2>&1 &` || msgFail "MYSQL failed to start !"
setColor green "MYSQL started successfully !"

