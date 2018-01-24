#!/usr/bin/env bash

setup_credit_score()
{

    composerConfig $1

    echo -e "\n\tDefinindo configurações do .env:\n"
    cd $1
    chmod 777 -R vendor/
    if [ -f ".env" ]
    then
        echo "Arquivo $(pwd)/.env já existe."
    else
        cp sample.env .env
    fi
    sed -i -E "s/db.bo.host=(.*)/db.bo.host=$DB_HOST/g" .env
    sed -i -E "s/bo.api.host=(.*)/bo.api.host=$BACKOFFICE_API_URL\/portal\/pravaler_v2/g" .env

    echo -e "\n\tCriando diretórios e definindo configurações:\n"
    if [ -d "xdebug-profile-logs" ]
    then
        echo "\nDiretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R xdebug-profile-logs/

    dockerComposeUp 'creditscore'

    configHost $CREDITSCORE_IP $CREDITSCORE_URL
}