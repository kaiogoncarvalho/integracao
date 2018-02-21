FROM centos:7

RUN yum install -y wget \
	&& wget -q http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
	&& wget -q https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
	&& rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm \
	&& yum groupinstall -y "Development Tools" \
	&& yum install -y libxml2-devel wget pcre pcre-devel openssl openssl-devel libcurl-devel gd-devel

RUN yum install -y \
	php70.x86_64 \
	php70-php-bcmath.x86_64 \
	php70-php-cli.x86_64 \
	php70-php-common.x86_64 \
	php70-php-devel.x86_64 \
	php70-php-fpm.x86_64 \
	php70-php-json.x86_64 \
	php70-php-mbstring.x86_64 \
	php70-php-mcrypt.x86_64 \
	php70-php-mysqlnd.x86_64 \
	php70-php-opcache.x86_64 \
	php70-php-pdo.x86_64 \
	php70-php-pear.noarch \
	php70-php-pecl-amqp.x86_64 \
	php70-php-pecl-mongodb.x86_64 \
	php70-php-pecl-mysql.x86_64 \
	php70-php-pecl-xdebug.x86_64 \
	php70-php-pecl-zip.x86_64 \
	php70-php-pgsql.x86_64 \
	php70-php-xml.x86_64 \
	php70-php-xmlrpc.x86_64

RUN useradd www-data \
	 && usermod -aG www-data www-data \
	 && cd /home \
         && wget http://nginx.org/download/nginx-1.10.2.tar.gz \
         && tar -xvzf nginx-1.10.2.tar.gz \
         && cd nginx-1.10.2 \
         && ./configure --prefix=/usr/local/nginx-1.10.2 --with-http_ssl_module --with-http_realip_module --with-http_addition_module \
         --with-http_gzip_static_module --with-http_secure_link_module --with-http_stub_status_module --with-http_degradation_module \
         --with-http_gunzip_module --with-http_auth_request_module --with-http_v2_module \
         && make \
         && make install \
	 && cp /usr/local/nginx-1.10.2/sbin/nginx /usr/bin/nginx \
         && mkdir /usr/local/nginx-1.10.2/conf/apps

ADD DockerFiles/NovaPropostaBackend/Files/nginx.conf /usr/local/nginx-1.10.2/conf/
ADD DockerFiles/NovaPropostaBackend/Files/proposta.conf /usr/local/nginx-1.10.2/conf/apps/
ADD DockerFiles/NovaPropostaBackend/Files/php-fpm.conf /etc/opt/remi/php70/
ADD DockerFiles/NovaPropostaBackend/Files/www.conf /etc/opt/remi/php70/php-fpm.d/

RUN  chmod -R 777 /etc/opt/remi/php70/ \
	 && ln -s /usr/bin/php70 /usr/bin/php

EXPOSE 80

ENTRYPOINT nginx \
	     && /opt/remi/php70/root/usr/sbin/php-fpm -R -c /etc/opt/remi/php70/php.ini \
	     && /bin/bash