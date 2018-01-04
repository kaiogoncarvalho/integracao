#!/usr/bin/env bash

setup_backoffice()
{
    cd $BACKOFFICE_LOCAL
    docker run --rm -v $BACKOFFICE_LOCAL/:/app kaioidealinvest/composer:php7.1 install
    if [ -f ".env" ]
    then
        echo "\nArquivo $(pwd)/.env já existe."
    else
        cp sample.env .env
    fi
    OLD_DB=$(grep -E "db.default.host=(.*)" .env | sed -n 's/^db.default.host=*//p' .env)
    sed -i -e "s/$OLD_DB/$DATABASE/g" .env
    OLD_PORT=$(grep -E "db.default.port=(.*)" .env | sed -n 's/^db.default.port=*//p' .env)
    sed -i -e "s/$OLD_PORT/$PORT/g" .env
    sed -i -E "s/api.aprovacaoIes.path=(.*)/api.aprovacaoIes.path=$APIAPROVACAO_URL\\/v1.1/g" .env
    OLD_HOST=$(grep -E "backoffice.domain=(.*)" .env | sed -n 's/^backoffice.domain=*//p' .env)
    sed -i -e "s/$OLD_HOST/$BACKOFFICE_URL/g" .env
    sed -i -E "s/api.url=(.*)/api.url=$BACKOFFICE_API_URL/g" .env
    OLD_HOSTPORTAL=$(grep -E "portal.domain=(.*)" .env | sed -n 's/^portal.domain=*//p' .env)
    sed -i -E "s/portal.domain=(.*)/portal.domain=$PORTALPRAVALER_URL/g" .env
    cd html/portal/pravaler/
    if [ -d "log" ]
    then
        echo "\nDiretório $(pwd)/log já existe."
    else
        mkdir log
    fi
    cd backoffice/
     if [ -d "cnab" ]
    then
        echo "\nDiretório $(pwd)/cnab já existe."
    else
        mkdir cnab
    fi
    cd cnab
    if [ -d "bancos" ]
    then
        echo "\nDiretório $(pwd)/bancos já existe."
    else
        mkdir bancos
    fi
    cd bancos
    if [ -d "db" ]
    then
        echo "\nDiretório $(pwd)/db já existe."
    else
        mkdir db
    fi
    cd $BACKOFFICE_LOCAL
    if [ -d "xdebug-profile-logs" ]
    then
        echo "\nDiretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R .
}
