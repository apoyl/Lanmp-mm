#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2014-2015 apoyl.com  All rights reserved. 

#启动之前先干掉LAMP
#kill -TERM `cat ${installdir}/apache2/logs/httpd.pid`
${installdir}/apache2/bin/apachectl -k stop
#sleep 1
#kill -QUIT `cat ${installdir}/php/var/run/php-fpm.pid`
sleep 1
killall ${installdir}/mysql/bin/mysqld
sleep 1
#启动LNMP
ulimit -HSn 65535
setColor green "Start LAMP....."
setColor green "MYSQL start ....."
`nohup ${installdir}/mysql/bin/mysqld --defaults-file=${installdir}/mysql/my.cnf --basedir=${installdir}/mysql --datadir=${dbdir} --port=3309 --user=mysql --pid-file=${dbdir}/mysqld.pid  --socket=/tmp/mysql.sock > /dev/null 2>&1 &` || msgFail "MYSQL failed to start !"
setColor green "MYSQL started successfully !"

#setColor green "php-fpm start ......"
#${installdir}/php/sbin/php-fpm || msgFail "PHP-FPM failed to start !"
#setColor green "PHP-FPM started successfully !"

setColor green "APACHE start ......"
${installdir}/apache2/bin/apachectl -f ${installdir}/apache2/conf/httpd.conf || msgFail "APACHE failed to start !"
setColor green "APACHE started successfully !"
	
