#!/usr/bin/env bash

setup_backoffice()
{
    cd $BACKOFFICE_LOCAL
    docker run --rm -v $BACKOFFICE_LOCAL/:/app kaioidealinvest/composer:php7.1 install
    cp sample.env .env
    OLD_DB=$(grep -E "db.default.host=(.*)" .env | sed -n 's/^db.default.host=*//p' .env)
    sed -i -e "s/$OLD_DB/$DATABASE/g" .env
    OLD_PORT=$(grep -E "db.default.port=(.*)" .env | sed -n 's/^db.default.port=*//p' .env)
    sed -i -e "s/$OLD_PORT/$PORT/g" .env
    sed -i -E "s/api.aprovacaoIes.path=(.*)/api.aprovacaoIes.path=$APIAPROVACAO_URL\\/v1.1/g" .env
    OLD_HOST=$(grep -E "backoffice.domain=(.*)" .env | sed -n 's/^backoffice.domain=*//p' .env)
    sed -i -e "s/$OLD_HOST/$BACKOFFICE_URL/g" .env
    sed -i -E "s/api.url=(.*)/api.url=$BACKOFFICE_API_URL/g" .env
    OLD_HOSTPORTAL=$(grep -E "portal.domain=(.*)" .env | sed -n 's/^portal.domain=*//p' .env)
    sed -i -E "s/portal.domai=(.*)/portal.domai=$PORTALPRAVALER_URL/g" .env
    DIR_DOCKER=$(echo $BACKOFFICE_DOCKER | sed -e "s/\//\\\\\//g")
    sed -i -E "s/\/home\/httpd\/html\/idealinvest.com.br\//$DIR_DOCKER\//g" .env
    cd html/portal/pravaler/
    mkdir log
    cd backoffice/
    mkdir cnab
    cd cnab
    mkdir bancos
    cd bancos
    mkdir db
    cd $BACKOFFICE_LOCAL
    chmod 777 -R .
}
