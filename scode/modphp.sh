#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2014-2015 apoyl.com  All rights reserved. 


phpversion=php

if [ -n "$1" ]
then
        phpversion=$1
fi


phpini="$installdir/$phpversion/etc/php.ini"
sed  -i "s:/data/www:$installdir/www:g" $phpini
