#!/bin/sh
# BLOG SITE:http://www.apoyl.com
# AUTHOR:(凹凸曼)lyc
# EMAIL:jar-c@163.com
# COPYRIGHT © 2014-2099 apoyl.com  All rights reserved.

#环境安装路径
installdir=/apoyl/lanmp-mm
pwddir=`pwd`
sourcedir=${pwddir}/src
compliedir=${pwddir}/complie
logdir=${pwddir}/log
etcdir=${pwddir}/etc

#默认安装数据库
dbdir=${installdir}/db/mysql
#默认站点 如修改这个 需要修改对应的php.ini nginx.conf 文件
sitedir=${installdir}/www/localhost

#run=(re2c013 libmcrypt25 apr17 aprutil16)
#手动安装 
re2c013="http://jaist.dl.sourceforge.net/project/re2c/re2c/0.13.7.5/re2c-0.13.7.5.tar.gz"
libmcrypt25="http://nchc.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz"
apr17="https://mirrors.bfsu.edu.cn/apache//apr/apr-1.7.0.tar.gz"
aprutil16="https://mirrors.bfsu.edu.cn/apache//apr/apr-util-1.6.1.tar.gz"
#支持php7
memcache40="https://pecl.php.net/get/memcache-4.0.5.2.tgz"

nginx16="http://nginx.org/download/nginx-1.6.2.tar.gz"
nginx114="http://nginx.org/download/nginx-1.14.0.tar.gz"

mysql50="http://downloads.mysql.com/archives/get/file/mysql-5.0.96-linux-x86_64-glibc23.tar.gz|ec0897c53c8c325c816e0d045520939c"
mysql51="http://downloads.mysql.com/archives/get/file/mysql-5.1.72-linux-x86_64-glibc23.tar.gz|e717f71e8c780c422af26847bf64e99a"
mysql57="https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.22-linux-glibc2.12-x86_64.tar.gz|9ef7a05695f8b4ea29f8d077c3b415e2"

php54="http://cn2.php.net/distributions/php-5.4.38.tar.gz|53ecd57da7b2243f8461e4fb8ce689a6"
phpap54="http://cn2.php.net/distributions/php-5.4.38.tar.gz|53ecd57da7b2243f8461e4fb8ce689a6"
#sha256
php71="http://am1.php.net/distributions/php-7.1.19.tar.gz|e1ae477b72bed02cdcb04f0157b8f8767bd4f6030416ae06408b4f6d85ee66a1"
php73="https://www.php.net/distributions/php-7.3.18.tar.gz|3211d5d6ea8a27c2794498a551bf26e334bc2b986741971809c9bb650eaa47a3"
phpap73="https://www.php.net/distributions/php-7.3.18.tar.gz|3211d5d6ea8a27c2794498a551bf26e334bc2b986741971809c9bb650eaa47a3"

apache22="http://mirror.bit.edu.cn/apache/httpd/httpd-2.2.29.tar.gz|7036a6eb5fb3b85be7a804255438b795"
apache24="https://mirror.bit.edu.cn/apache//httpd/httpd-2.4.43.tar.gz|2624e92d89b20483caeffe514a7c7ba93ab13b650295ae330f01c35d5b50d87f"

#re2c013
re2c013rule=("yum -y install make tar gcc gcc-c++","[  -z `rpm -qa 're2c'` ] || break","./configure","make&&make install")
#libmcrypt25
libmcrypt25rule=("yum -y install make tar gcc gcc-c++","[  -z `rpm -qa 'libmcrypt'` ] || break","./configure","make&&make install")
#apr17
apr17rule=("yum -y install make tar gcc gcc-c++","./configure --prefix=${installdir}/apr17","make&&make install")
#aprutil16
aprutil16rule=("yum -y install make tar gcc gcc-c++","./configure --prefix=${installdir}/aprutil16 --with-apr=${installdir}/apr17","make&&make install")
#memcache
memcache40rule=("yum -y install make tar gcc gcc-c++","${installdir}/php73/bin/phpize","./configure --with-php-config=${installdir}/php73/bin/php-config","make&&make install")

#nginx16
nginx16rule=("yum -y install make tar gcc libtool* zlib-devel pcre-devel","./configure --prefix=${installdir}/nginx  --with-http_realip_module  --with-http_addition_module  --with-http_sub_module --with-http_secure_link_module  --with-http_gzip_static_module  --with-http_stub_status_module  --without-http_ssi_module --with-pcre","make && make install","mkdir -p ${sitedir} ","echo 'yes' | cp  ${etcdir}/nginx.conf ${installdir}/nginx/conf/nginx.conf","source ../../../scode/modnginx.sh","cp ${etcdir}/index.php ${sitedir} && groupadd www || echo 0 && useradd -r  -g www www ||echo 0","usermod -s /sbin/nologin www")
#nginx114
nginx114rule=("yum -y install make tar gcc libtool* zlib-devel pcre-devel","./configure --prefix=${installdir}/nginx  --with-http_realip_module  --with-http_addition_module  --with-http_sub_module --with-http_secure_link_module  --with-http_gzip_static_module  --with-http_stub_status_module  --without-http_ssi_module --with-pcre --with-http_ssl_module","make && make install","mkdir -p ${sitedir} ","echo 'yes' | cp  ${etcdir}/nginx.conf ${installdir}/nginx/conf/nginx.conf","source ../../../scode/modnginx.sh","cp ${etcdir}/index.php ${sitedir} && groupadd www || echo 0 && useradd -r  -g www www ||echo 0","usermod -s /sbin/nologin www")

#apache22
apache22rule=("yum -y install make tar gcc gcc-c++ libtool* zlib-devel ntp perl apr apr-util","./configure --prefix=${installdir}/apache2 --enable-so --enable-rewrite","make&&make install","mkdir -p ${sitedir}","cp ${etcdir}/index.php ${sitedir}","cp ${installdir}/apache2/conf/httpd.conf ${installdir}/apache2/conf/httpdbak.conf","source ../../../scode/modhttpd.sh")
#apache24
apache24rule=("yum -y install make tar gcc gcc-c++ libtool* zlib-devel ntp perl apr apr-util","./configure --prefix=${installdir}/apache24 --enable-so --enable-rewrite --with-crypto --with-apr=${installdir}/apr17 --with-apr-util=${installdir}/aprutil16","make&&make install","mkdir -p ${sitedir}","cp ${etcdir}/index.php ${sitedir}","cp ${installdir}/apache24/conf/httpd.conf ${installdir}/apache24/conf/httpdbak.conf","source ../../../scode/modhttpd.sh apache24")

#mysql模板
mysql50rule=("yum -y install tar","mkdir -p ${installdir}/mysql && cp -rp ./ ${installdir}/mysql","source ../../../scode/modmysql.sh","groupadd mysql ||echo 0","useradd  -r -g  mysql mysql || echo 0"," usermod -s /sbin/nologin mysql","cd ${installdir}/mysql","chown -R mysql:mysql .","cp ${etcdir}/my-large.cnf ./my.cnf","mkdir -p ${dbdir} && ./scripts/mysql_install_db --user=mysql --datadir=${dbdir} --defaults-file=${installdir}/mysql/my.cnf","chown -R root:root . && chown -R  mysql:mysql ${dbdir}")
mysql51rule=("yum -y install tar","mkdir -p ${installdir}/mysql && cp -rp ./ ${installdir}/mysql","source ../../../scode/modmysql.sh","groupadd mysql ||echo 0","useradd  -r -g  mysql mysql || echo 0","usermod -s /sbin/nologin mysql","cd ${installdir}/mysql","chown -R mysql:mysql .","cp ${etcdir}/my-large.cnf ./my.cnf","mkdir -p ${dbdir} && ./scripts/mysql_install_db --user=mysql --datadir=${dbdir} --defaults-file=${installdir}/mysql/my.cnf","chown -R root:root . && chown -R  mysql:mysql ${dbdir}")
mysql57rule=("yum -y install tar","mkdir -p ${installdir}/mysql && cp -rp ./ ${installdir}/mysql","groupadd mysql ||echo 0","useradd  -r -g  mysql mysql || echo 0","usermod -s /sbin/nologin mysql","cd ${installdir}/mysql","chown -R mysql:mysql .","cp ${etcdir}/my-large-57.cnf ./my.cnf","mkdir -p ${dbdir} && ./bin/mysqld --initialize-insecure --user=mysql  --basedir=${installdir}/mysql --datadir=${dbdir}   --explicit_defaults_for_timestamp","chown -R root:root . && chown -R  mysql:mysql ${dbdir}")

#php54+nginx
php54rule=("yum -y install make tar gcc gcc-c++ libtool*  sed flex bison m4 autoconf automake gd-devel libjpeg-devel freetype-devel fontconfig-devel libpng-devel libtiff-devel libmcrypt-devel pcre-devel zlib-devel libevent-devel bzip2-devel php-mbstring libxml2 libxml2-devel","./configure --prefix=${installdir}/php  \
        --with-config-file-path=${installdir}/php/etc \
        --with-mysql=${installdir}/mysql \
        --with-gd --enable-gd-native-ttf  --enable-gd-jis-conv \
        --with-png-dir --with-jpeg-dir \
        --with-freetype-dir --with-iconv-dir \
        --with-zlib-dir --enable-ftp \
        --disable-ipv6 --with-bz2 --enable-mbstring \
        --with-libxml-dir --enable-sockets --enable-exif \
        --disable-debug --with-mcrypt --enable-pcntl \
        --enable-sigchild  --enable-sysvmsg \
        --enable-pdo  --with-pdo-mysql --enable-fpm \
	","make && make install","cp ${etcdir}/php5.ini ${installdir}/php/etc/php.ini &&  cp ${etcdir}/php-fpm.conf ${installdir}/php/etc/php-fpm.conf #&& cp ./sapi/fpm/php-fpm ${installdir}/php/bin","source ../../../scode/modphp.sh","groupadd www || echo 0 && useradd -r  -g www www || echo 0 ","usermod -s /sbin/nologin www")

#php71+nginx
php71rule=("yum -y install make tar gcc gcc-c++ libtool* openssl openssl-devel sed flex bison m4 autoconf automake gd-devel libjpeg-devel freetype-devel fontconfig-devel libpng-devel libtiff-devel libmcrypt-devel pcre-devel zlib-devel libevent-devel bzip2-devel php-mbstring libxml2 libxml2-devel","./configure --prefix=${installdir}/php  \
        --with-config-file-path=${installdir}/php/etc \
        --with-mysqli \
	--with-openssl \
        --with-gd --enable-gd-native-ttf  --enable-gd-jis-conv \
        --with-png-dir --with-jpeg-dir \
        --with-freetype-dir --with-iconv-dir \
        --with-zlib-dir --enable-ftp \
        --disable-ipv6 --with-bz2 --enable-mbstring \
        --with-libxml-dir --enable-sockets --enable-exif \
        --disable-debug --with-mcrypt --enable-pcntl \
        --enable-sigchild  --enable-sysvmsg \
        --enable-pdo  --with-pdo-mysql --enable-fpm \
	","make && make install","cp ${etcdir}/php7.ini ${installdir}/php/etc/php.ini &&  cp ${etcdir}/php-fpm.conf ${installdir}/php/etc/php-fpm.conf #&& cp ./sapi/fpm/php-fpm ${installdir}/php/bin","source ../../../scode/modphp.sh","groupadd www || echo 0 && useradd -r  -g www www || echo 0 ","usermod -s /sbin/nologin www")

#php73+nginx
php73rule=("yum -y install make tar gcc gcc-c++ libtool* openssl openssl-devel sed flex bison m4 autoconf automake gd-devel libjpeg-devel freetype-devel fontconfig-devel libpng-devel libtiff-devel libmcrypt-devel pcre-devel zlib-devel libevent-devel bzip2-devel php-mbstring libxml2 libxml2-devel","./configure --prefix=${installdir}/php73  \
        --with-config-file-path=${installdir}/php73/etc \
        --with-mysqli \
	--with-openssl \
        --with-gd --enable-gd-jis-conv \
        --with-png-dir --with-jpeg-dir \
        --with-freetype-dir --with-iconv-dir \
        --with-zlib-dir --enable-ftp \
        --disable-ipv6 --with-bz2 --enable-mbstring \
        --with-libxml-dir --enable-sockets --enable-exif \
        --disable-debug  --enable-pcntl \
        --enable-sigchild  --enable-sysvmsg \
        --enable-pdo  --with-pdo-mysql --enable-opcache --enable-fpm \
	","make && make install","cp ${etcdir}/php7.ini ${installdir}/php73/etc/php.ini &&  cp ${etcdir}/php-fpm.conf ${installdir}/php73/etc/php-fpm.conf #&& cp ./sapi/fpm/php-fpm ${installdir}/php73/bin","source ../../../scode/modphp.sh php73","groupadd www || echo 0 && useradd -r  -g www www || echo 0 ","usermod -s /sbin/nologin www")


#php54+apache22
phpap54rule=("yum -y install make tar gcc gcc-c++ libtool*  sed flex bison m4 autoconf automake gd-devel libjpeg-devel freetype-devel fontconfig-devel libpng-devel libtiff-devel libmcrypt-devel pcre-devel zlib-devel libevent-devel bzip2-devel php-mbstring libxml2 libxml2-devel","./configure --prefix=${installdir}/php  \
        --with-config-file-path=${installdir}/php/etc \
        --with-mysql=${installdir}/mysql \
	--with-apxs2=${installdir}/apache2/bin/apxs \
        --with-gd --enable-gd-native-ttf  --enable-gd-jis-conv \
        --with-png-dir --with-jpeg-dir \
        --with-freetype-dir --with-iconv-dir \
        --with-zlib-dir --enable-ftp \
        --disable-ipv6 --with-bz2 --enable-mbstring \
        --with-libxml-dir --enable-sockets --enable-exif \
        --disable-debug --with-mcrypt --enable-pcntl \
        --enable-sigchild  --enable-sysvmsg \
        --enable-pdo  --with-pdo-mysql \
        ","make  && make install","cp ${etcdir}/php5.ini ${installdir}/php/etc/php.ini","source ../../../scode/modphp.sh")



#php71+apache24
phpap71rule=("yum -y install make tar gcc gcc-c++ libtool*   openssl openssl-devel sed flex bison m4 autoconf automake gd-devel libjpeg-devel freetype-devel fontconfig-devel libpng-devel libtiff-devel libmcrypt-devel pcre-devel zlib-devel libevent-devel bzip2-devel php-mbstring libxml2 libxml2-devel","./configure --prefix=${installdir}/php  \
        --with-config-file-path=${installdir}/php/etc \
        --with-mysqli \
	--with-apxs2=${installdir}/apache24/bin/apxs \
        --with-gd --enable-gd-native-ttf  --enable-gd-jis-conv \
        --with-png-dir --with-jpeg-dir \
        --with-freetype-dir --with-iconv-dir \
        --with-zlib-dir --enable-ftp \
        --disable-ipv6 --with-bz2 --enable-mbstring \
        --with-libxml-dir --enable-sockets --enable-exif \
        --disable-debug --with-mcrypt --enable-pcntl \
        --enable-sigchild  --enable-sysvmsg \
        --enable-pdo  --with-pdo-mysql \
        ","make  && make install","cp ${etcdir}/php7.ini ${installdir}/php/etc/php.ini","source ../../../scode/modphp.sh")

#php73+apache24
phpap73rule=("yum -y install make tar gcc gcc-c++ libtool*   openssl openssl-devel sed flex bison m4 autoconf automake gd-devel libjpeg-devel freetype-devel fontconfig-devel libpng-devel libtiff-devel libmcrypt-devel pcre-devel zlib-devel libevent-devel bzip2-devel php-mbstring libxml2 libxml2-devel","./configure --prefix=${installdir}/php73  \
        --with-config-file-path=${installdir}/php73/etc \
        --with-mysqli \
	--with-apxs2=${installdir}/apache24/bin/apxs \
	--with-openssl \
        --with-gd  --enable-gd-jisi-conv \
        --with-png-dir --with-jpeg-dir \
        --with-freetype-dir --with-iconv-dir \
        --with-zlib-dir --enable-ftp \
        --disable-ipv6 --with-bz2 --enable-mbstring \
        --with-libxml-dir --enable-sockets --enable-exif \
        --disable-debug  --enable-pcntl \
        --enable-sigchild  --enable-sysvmsg \
        --enable-pdo  --with-pdo-mysql --enable-opcache \
        ","make  && make install","cp ${etcdir}/php7.ini ${installdir}/php73/etc/php.ini","source ../../../scode/modphp.sh php73")

