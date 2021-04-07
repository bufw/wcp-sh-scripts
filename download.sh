#!/bin/sh
cd /root/wcp/src
. ../functions.sh
. ../config.ini
if [ ! -e /usr/bin/wget ]; then
	red_echo "wget 不存在"
	exit 1
fi

down_success_or_stop(){
	if [ ! -e $1 ];then
	     red_echo "$1 download failed!"
	     exit 1
        fi
}

#download expat
if [ ! -e "expat-${expat_version}.tar.gz" ];then
	expat_ver=$(echo ${expat_version} | sed "s/\./_/g")
	expat_ver="R_${expat_ver}"
	wget https://github.com/libexpat/libexpat/releases/download/${expat_ver}/expat-${expat_version}.tar.gz
	down_success_or_stop "expat-${expat_version}.tar.gz"
else
	green_echo "download expat-${expat_version}.tar.gz"
fi


#download openssl
if [ ! -e "openssl-${openssl_version}.tar.gz" ];then	
	wget https://www.openssl.org/source/openssl-${openssl_version}.tar.gz
	down_success_or_stop "openssl-${openssl_version}.tar.gz"
else
        green_echo "download openssl-${openssl_version}.tar.gz"
fi

#download zlib
if [ ! -e "zlib-${zlib_version}.tar.gz" ];then
	wget https://zlib.net/zlib-${zlib_version}.tar.gz
	down_success_or_stop "zlib-${zlib_version}.tar.gz"
else
	green_echo "download zlib-${zlib_version}.tar.gz"
fi


#download pcre
if [ ! -e "pcre-${pcre_version}.tar.gz" ];then
	wget https://ftp.pcre.org/pub/pcre/pcre-${pcre_version}.tar.gz
	down_success_or_stop "pcre-${pcre_version}.tar.gz"
else
        green_echo "download pcre-${pcre_version}.tar.gz"
fi

#download apache 
if [ ! -e "httpd-${apache_version}.tar.gz" ];then
	wget https://mirrors.sonic.net/apache/httpd/httpd-${apache_version}.tar.gz
        down_success_or_stop "httpd-${apache_version}.tar.gz"
else
        green_echo "download httpd-${apache_version}.tar.gz"
fi

#apr

if [ ! -e "apr-${apr_version}.tar.gz" ];then
	wget https://apache.claz.org/apr/apr-${apr_version}.tar.gz
        down_success_or_stop "apr-${apr_version}.tar.gz"
else
        green_echo "download apr-${apr_version}.tar.gz"
fi

#apr-util
if [ ! -e "apr-util-${apr_util_version}.tar.gz" ];then
	wget https://apache.claz.org/apr/apr-util-${apr_util_version}.tar.gz
        down_success_or_stop "apr-util-${apr_util_version}.tar.gz"
else
        green_echo "download apr-util-${apr_util_version}.tar.gz"
fi





