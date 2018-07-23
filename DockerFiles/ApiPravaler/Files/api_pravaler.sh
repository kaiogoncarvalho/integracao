#!/usr/bin/env bash
database_api_pravaler()
{
    if isValidRepository $APIPRAVALER_LOCAL; then

        cd $APIPRAVALER_LOCAL/config
        if isNotEmptyVariable $DATABASE_HOST; then
            sed -E -i "s/('host'[[:print:]]*)'([[:digit:].]+)'/\1'$DATABASE_HOST'/g" 'database.php'
        fi

        if isNotEmptyVariable $DATABASE_PORT; then
            sed -E -i "s/('port'[[:print:]]*)'([[:digit:]]+)'/\1'$DATABASE_PORT'/g" 'database.php'
        fi

        if isNotEmptyVariable $DATABASE_NAME; then
            sed -E -i "s/('dbname'[[:print:]]*)'([^']*)'/\1'$DATABASE_NAME'/g" 'database.php'
        fi

        if isNotEmptyVariable $DATABASE_USER; then
            sed -E -i "s/('user'[[:print:]]*')'([^']*)'/\1'$DATABASE_USER'/g" 'database.php'
        fi

        if isNotEmptyVariable $DATABASE_PASSWORD; then
            sed -E -i "s/('password'[[:print:]]*)'([^']*)'/\1'$DATABASE_PASSWORD'/g" 'database.php'
        fi
    fi

}

setup_api_pravaler()
{

    composerConfig $1

    cd $1

    msgConfig "Gerando arquivos de configuração: "
    cd config/
    cp database.example.php database.php
    chmod 777  database.php

    database_api_pravaler

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

    include_apipravaler_backoffice
}
