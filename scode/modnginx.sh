#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2014-2015 apoyl.com  All rights reserved. 

nginxconf="$installdir/nginx/conf/nginx.conf"
sed  -i "s:/data/www:$installdir/www:g" $nginxconf
