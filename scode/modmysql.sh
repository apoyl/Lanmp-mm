#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2014-2015 apoyl.com  All rights reserved. 

mysqllib="$installdir/mysql/lib/libmysqlclient.la"
sed  -i "s:/usr/local/mysql/lib:$installdir/mysql/lib:g" $mysqllib
mysqllib="$installdir/mysql/lib/libz.la"
sed -i "s:/usr/local/mysql/lib:$installdir/mysql/lib:g" $mysqllib
