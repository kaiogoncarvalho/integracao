#!/usr/bin/env bash

setup_credit_score()
{
    docker run --rm -v $CREDITSCORE_LOCAL/:/app kaioidealinvest/composer:php7.1 install
    cd $CREDITSCORE_LOCAL
    cp .env-example .env
    sed -i -E "s/db.bo.host=(.*)/db.bo.host=$DATABASE/g" .env
    sed -i -E "s/bo.api.host=(.*)/bo.api.host=$BACKOFFICE_API_URL\/portal\/pravaler_v2/g" .env
}