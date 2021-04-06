#! /bin/sh

uname -a
clear

printf "
#######################################################################
#       				WCP.SH			      #
#######################################################################
"
echo $0
echo $WCP_ROOT_PATH
basename $0
if [ $(id -u) != "0" ]; then 
	echo "You must be root to run this script"
	exit 1
fi

WCP_VERSION="1.0.1"
WCP_VERSION_DATE="2021-4-1"
WCP_ROOT=$(pwd)
WCP_SRC="${WCP_ROOT}/src"
WCP_BUILD="${WCP_ROOT}/build"

WCP_DB_PASSWD=`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16`

#加载配置文件
. ./config.ini
. ./functions.sh
. ./preinstall.sh

#创建用户和组
groupadd ${web_group}
useradd -s /sbin/nologin -g ${web_group} ${web_user}

#创建web目录 和 数据存放目录
mkdir -p ${APP_PATH}
mkdir -p ${APP_LOGS}
mkdir -p ${WEB_ROOT}
mkdir -p ${SSL_PATH}
chown -R ${web_user}:${web_group} ${APP_PATH}
chown -R ${web_user}:${web_group} ${APP_LOGS}
chown -R ${web_user}:${web_group} ${WEB_ROOT}
chown -R ${web_user}:${web_group} ${SSL_PATH}


WCP_ACTION=$1
if [ "${WCP_ACTION}" = "" ]; then
	WCP_ACTION="auto_install_lamp"
else
	WCP_ACTION=$1
fi


auto_install_lamp() {
#	install_expat
	install_openssl
	install_pcre
	install_zlib
	pwd
	. ./apache.sh
	echo "install apache"
	install_apache


}



$WCP_ACTION



