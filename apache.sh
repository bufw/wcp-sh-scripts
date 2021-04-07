#! /bin/sh
install_apr() {
#install apr
local TARGET_DIR=${WCP_BUILD}
mkdir -p ${TARGET_DIR}
[[ -d "${TARGET_DIR}" ]] && echo "${TARGET_DIR} The directory already exists"

#install apr
Uncompress_targz ${WCP_SRC}/apr-${apr_version}.tar.gz ${TARGET_DIR}
#tar zxvf ${WCP_SRC}/apr-${apr_version}.tar.gz -C ${WCP_BUILD}/apr-${apr_version}
cd ${TARGET_DIR}/apr-${apr_version}
./configure --prefix=${APP_PATH}/apps/apr
make
make install
echo "${APP_PATH}/apps/apr/lib" > /etc/ld.so.conf.d/wcp-apr.conf
ldconfig
cd ${WCP_ROOT}

#install apr-util
Uncompress_targz ${WCP_SRC}/apr-util-${apr_util_version}.tar.gz ${TARGET_DIR}
cd ${TARGET_DIR}/apr-util-${apr_util_version}
./configure --prefix=${APP_PATH}/apr-util --with-apr=${APP_PATH}/apps/apr
make
make install
echo "${APP_PATH}/apps/apr-util/lib" > /etc/ld.so.conf.d/wcp-apr-util.conf
ldconfig

cd ${WCP_ROOT}

}



install_apache() {
local TARGET_DIR=${WCP_BUILD}
mkdir -p ${TARGET_DIR}
[[ -d "${TARGET_DIR}" ]] && echo "${TARGET_DIR} The directory already exists"


#install apache
Uncompress_targz ${WCP_SRC}/httpd-${apache_version}.tar.gz ${TARGET_DIR}
#install apr
Uncompress_targz ${WCP_SRC}/apr-${apr_version}.tar.gz ${TARGET_DIR}
mv ${WCP_BUILD}/apr-${apr_version} ${WCP_BUILD}/httpd-${apache_version}/srclib/apr

#install apr-util
Uncompress_targz ${WCP_SRC}/apr-util-${apr_util_version}.tar.gz ${TARGET_DIR}
mv ${WCP_BUILD}/apr-util-${apr_util_version} ${WCP_BUILD}/httpd-${apache_version}/srclib/apr-util

cd ${WCP_BUILD}/httpd-${apache_version}

./configure --prefix=${APP_PATH}/apache \
	--enable-mpms-shared=all \
	--with-mpm=event \
	--enable-mods-shared=most \
	--enable-headers \
	--enable-mime-magic \
	--enable-proxy \
	--enable-so \
	--enable-rewrite \
	--enable-ssl \
	--with-ssl=${APP_PATH}/openssl-${openssl_version}
	--enable-deflate \
	--with-pcre \
	--with-included-apr \
	--with-apr-util \
	--enable-remoteip \
	--enable-static-support \
	--enable-expires
# --enable-http2 --with-nghttp2=/usr/local/nghttp2   http2
make
make install

if [ -e "${apache_install_dir}/bin/httpd" ]; then
    echo "Apache installed successfully!"
else
    echo "Apache install failed"
    exit 1
fi


#sed -i 's/^#Include conf\/extra\/httpd-ssl.conf/Include conf\/extra\/httpd-ssl.conf/g' httpd.conf
# startup script


echo '[Unit]
Description=The Apache HTTP Server
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
ExecStart=${APP_PATH}/apache/bin/httpd $OPTIONS -k start
ExecReload=${APP_PATH}/apache/bin/httpd $OPTIONS -k graceful
ExecStop=${APP_PATH}/apache/bin/httpd -k stop
PrivateTmp=false

[Install]
WantedBy=multi-user.target
' > /lib/systemd/system/httpd.service
systemctl enable httpd

cd ${WCP_ROOT}




}


