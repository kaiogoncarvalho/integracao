#!/usr/bin/env bash
display_database_api_pravaler()
{
    if validFile $APIPRAVALER_LOCAL'/config/database.php';then
        SYSTEM_DB_HOST=$(php_preg_match "/('host'[^'\"]*)'([^'\"]*)'/s"  $APIPRAVALER_LOCAL/config/database.php 2)
        SYSTEM_DB_PORT=$(php_preg_match "/('port'[^'\"]*)'([^'\"]*)'/s"  $APIPRAVALER_LOCAL/config/database.php  2)
        SYSTEM_DB_NAME=$(php_preg_match "/('dbname'[^'\"]*)'([^'\"]*)'/s"  $APIPRAVALER_LOCAL/config/database.php 2)
        SYSTEM_DB_USER=$(php_preg_match "/('user'[^'\"]*)'([^'\"]*)'/s"  $APIPRAVALER_LOCAL/config/database.php  2)
        SYSTEM_DB_PASSWORD=$(php_preg_match "/('password'[^'\"]*)'([^'\"]*)'/s"  $APIPRAVALER_LOCAL/config/database.php 2)
    else
        STATUS=$STATUS"\033[07;31m- Arquivo config/database.php não existe (necessário reinstalar o Sistema para criar)\033[00;31m\n\n"
    fi


}
database_api_pravaler()
{
    if isValidInstall 'APIPRAVALER' && validDatabase; then
        cd $APIPRAVALER_LOCAL/config
        sed -E -i "s/('host'[[:print:]]*)'([^'\"]*?)'/\1'$DATABASE_HOST'/g" 'database.php'
        sed -E -i "s/('port'[[:print:]]*)'([^'\"]*?)'/\1'$DATABASE_PORT'/g" 'database.php'
        sed -E -i "s/('dbname'[[:print:]]*)'([^'\"]*?)'/\1'$DATABASE_NAME'/g" 'database.php'
        sed -E -i "s/('user'[[:print:]]*)'([^'\"]*?)'/\1'$DATABASE_USER'/g" 'database.php'
        sed -E -i "s/('password'[[:print:]]*)'([^'\"]*?)'/\1'$DATABASE_PASSWORD'/g" 'database.php'
        return 0
    fi
    return 1

}

setup_api_pravaler()
{

    composerConfig $1

    cd $1

    chmod 777 -R $1

    msgConfig "Gerando arquivos de configuração: "
    cd config/
    cp database.example.php database.php
    chmod 777  database.php



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

    msgConfigItem "Permissão no diretório $(pwd) concedida."


    dockerComposeUp 'api_pravaler'

    configHost 'api_pravaler' $APIPRAVALER_URL

    database_api_pravaler

    include_apipravaler_backoffice
    include_apipravaler_novapropostafrontend
    include_apipravaler_retornomec
}
