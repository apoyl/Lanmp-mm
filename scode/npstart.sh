#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2014-2015 apoyl.com  All rights reserved. 

#启动之前先干掉LNMP
${installdir}/nginx/sbin/nginx -s stop
sleep 1
kill -QUIT `cat ${installdir}/var/run/php-fpm.pid`
sleep 1
#启动LNMP
ulimit -HSn 65535
setColor green "php-fpm start ......"
${installdir}/sbin/php-fpm || msgFail "PHP-FPM failed to start !"
setColor green "PHP-FPM started successfully !"

setColor green "NGINX start ......"
${installdir}/nginx/sbin/nginx || msgFail "NGINX failed to start !"
setColor green "NGINX started successfully !"
	
