#!/usr/bin/env bash

install_nginx() {
    useradd ${NGINX_USERNAME}
    usermod -aG ${NGINX_USERNAME} ${NGINX_GROUPNAME}
    cd /home
    wget http://nginx.org/download/${NGINX_VERSION}.tar.gz
    tar -xvzf ${NGINX_VERSION}.tar.gz
    cd ${NGINX_VERSION}
    ./configure \
        --prefix=/usr/local/${NGINX_VERSION} \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_gzip_static_module \
        --with-http_secure_link_module \
        --with-http_stub_status_module \
        --with-http_degradation_module \
        --with-http_gunzip_module \
        --with-http_auth_request_module \
        --with-http_v2_module
    make
    make install
    cp /usr/local/${NGINX_VERSION}/sbin/nginx /usr/bin/nginx
    mkdir /usr/local/${NGINX_VERSION}/conf/apps
}

install_nginx