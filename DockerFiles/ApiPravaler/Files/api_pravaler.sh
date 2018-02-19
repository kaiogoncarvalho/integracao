#!/usr/bin/env bash

setup_api_pravaler()
{

    composerConfig $1

    cd $1

    echo -e "\n\tGerando arquivos de configuração:\n"
    cd config/
    cp database.example.php database.php
    chmod 777  database.php
    sed -i -E "s/10.10.100.110/$DB_HOST/g" database.php
    sed -i -E "s/''/'123456'/g" database.php
    cp serasa.example.php serasa.php
    chmod 777 serasa.php

    echo -e "\n\tCriando diretórios\n"
    cd $1
    if [ -d "xdebug-profile-logs" ]
    then
        echo -e "\n- Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        echo -e "\n- Diretório $(pwd)/xdebug-profile-logs foi criado."
    fi
    chmod 777 -R xdebug-profile-logs/

    echo -e "\n\tDando Permissão no Projeto\n"
    chmod 777 -R $1
    echo -e "\n- Permissão no diretório $(pwd) concedida."


    dockerComposeUp 'api_pravaler'

    configHost $APIPRAVALER_IP $APIPRAVALER_URL
}
