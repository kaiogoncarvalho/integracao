#!/usr/bin/env bash

setup_credit_score()
{
    docker run --rm -v $CREDITSCORE_LOCAL/:/app kaioidealinvest/composer:php7.1 install
    cd $CREDITSCORE_LOCAL
    chmod 777 -R vendor/
    if [ -f ".env" ]
    then
        echo "Arquivo $(pwd)/.env já existe."
    else
        cp sample.env .env
    fi
    sed -i -E "s/db.bo.host=(.*)/db.bo.host=$DATABASE/g" .env
    sed -i -E "s/bo.api.host=(.*)/bo.api.host=$BACKOFFICE_API_URL\/portal\/pravaler_v2/g" .env
    if [ -d "xdebug-profile-logs" ]
    then
        echo "\nDiretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R xdebug-profile-logs/
}