FROM kaioidealinvest/php:7.1

RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        php7.1-mbstring \
        php7.1-xml \
        php7.1-json \
        php7.1-opcache \
        php7.1-xdebug \
        php7.1-pgsql \
        php7.1-redis \
        php7.1-apcu \
        php7.1-mysql

RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN phpenmod apcu