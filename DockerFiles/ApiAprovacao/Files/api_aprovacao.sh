#!/usr/bin/env bash

setup_api_aprovacao()
{
    docker run --rm -v $APIPRAVALER_LOCAL/:/app kaioidealinvest/composer:php7.1 install
    cd $APIPRAVALER_LOCAL
    chmod 777 -R vendor/
    cd config/
    cp database.example.php database.php
    chmod 777  database.php
    sed -i -E "s/10.10.100.110/$DATABASE/g" database.php
    sed -i -E "s/''/'123456'/g" database.php
    cp serasa.example.php serasa.php
    chmod 777 serasa.php
    cd $APIPRAVALER_LOCAL
    if [ -d "xdebug-profile-logs" ]
    then
        echo "\nDiretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R xdebug-profile-logs/
}
