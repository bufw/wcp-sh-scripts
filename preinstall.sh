#!/bin/sh

install_expat() {

Uncompress_targz ${WCP_SRC}/expat-${expat_version}.tar.gz ${WCP_BUILD}
cd ${WCP_BUILD}/expat-${expat_version}
./configure
make
make install
cd ${WCP_ROOT}



}

install_pcre() {

	Uncompress_targz ${WCP_SRC}/pcre-${pcre_version}.tar.gz ${WCP_BUILD}
	cd ${WCP_BUILD}/pcre-${pcre_version}
	./configure
	make
	make install
	cd ${WCP_ROOT}


}

install_zlib(){
	Uncompress_targz ${WCP_SRC}/zlib-${zlib_version}.tar.gz ${WCP_BUILD}
        cd ${WCP_BUILD}/zlib-${zlib_version}
        ./configure
        make
        make install
        cd ${WCP_ROOT}

}

install_openssl(){
	#if [ -f /lib64/libssl.so.1.1 ];then
	#	return 0
	#fi
	Uncompress_targz ${WCP_SRC}/openssl-${openssl_version}.tar.gz ${WCP_BUILD}
	cd openssl-${openssl_version}
	./config -Wl,-rpath=${APP_PATH}/openssl-${openssl_version}/lib enable-weak-ssl-ciphers -fPIC --prefix=${APP_PATH}/openssl-${openssl_version} --openssldir=${APP_PATH}/openssl-${openssl_version}
	make depend
	make
	make install

	#if [ -f "/etc/ld.so.conf.d/wcp-openssl.conf" ]; then
	#	rm -rf /etc/ld.so.conf.d/wcp-openssl.conf
	#fi
	#echo "${APP_PATH}/openssl-${openssl_version}/lib" > /etc/ld.so.conf.d/wcp-openssl.conf
	#ldconfig
	ln -sf /wcp/apps/openssl-1.1.1k/lib/libssl.so.1.1 /lib64/
	ln -sf /wcp/apps/openssl-1.1.1k/lib/libcrypto.so.1.1 /lib64/
	cd ${WCP_ROOT}
}


