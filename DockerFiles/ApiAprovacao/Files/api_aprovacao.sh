#!/usr/bin/env bash

setup_api_aprovacao()
{
    docker run --rm -v $APIAPROVACAO_LOCAL/:/app kaioidealinvest/composer:php7.1 install
    cd $APIAPROVACAO_LOCAL
    cd config/
    cp database.example.php database.php
    sed -i -E "s/10.10.100.110/$DATABASE/g" database.php
    sed -i -E "s/''/'123456'/g" database.php
    cp serasa.example.php serasa.php
}
