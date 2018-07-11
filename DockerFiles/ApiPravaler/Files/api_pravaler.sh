#!/usr/bin/env bash

setup_api_pravaler()
{

    composerConfig $1

    cd $1

    msgConfig "Gerando arquivos de configuração: "
    cd config/
    cp database.example.php database.php
    chmod 777  database.php

    sed -E -i "s/('host'[[:print:]]*)'([[:digit:].]+)'/\1'$DB_HOST'/g" 'database.php'
    sed -E -i "s/('port'[[:print:]]*)'([[:digit:]]+)'/\1'$DB_PORT'/g" 'database.php'
    sed -E -i "s/('dbname'[[:print:]]*)'([^']*)'/\1'$DB_DATABASE'/g" 'database.php'
    sed -E -i "s/('user'[[:print:]]*')'([^']*)'/\1'$DB_USER'/g" 'database.php'
    sed -E -i "s/('password'[[:print:]]*)'([^']*)'/\1'$DB_PASSWORD'/g" 'database.php'

    msgConfigItem "Arquivo database.php gerado."

    cp serasa.example.php serasa.php
    chmod 777 serasa.php

    msgConfigItem "Arquivo serasa.php gerado."

    msgConfig "Criando diretórios: "
    cd $1
    if [ -d "xdebug-profile-logs" ]
    then
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs foi criado."
    fi
    chmod 777 -R xdebug-profile-logs/

    msgConfig "Dando Permissão no Projeto: "
    chmod 777 -R $1
    msgConfigItem "Permissão no diretório $(pwd) concedida."


    dockerComposeUp 'api_pravaler'

    configHost 'api_pravaler' $APIPRAVALER_URL
}
