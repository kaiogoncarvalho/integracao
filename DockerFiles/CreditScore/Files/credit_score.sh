#!/usr/bin/env bash

setup_credit_score()
{

    composerConfig $1

    msgConfig "Definindo configurações do .env:"
    cd $1
    chmod 777 -R vendor/

    configInitialEnv '.env-example'

    regexFile "bo.api.host=" $BACKOFFICE_API_URL
    regexFile "db.bo.user=" $DB_USER
    regexFile "db.bo.pass=" $DB_PASSWORD
    regexFile "db.bo.dbname=" $DB_DATABASE
    regexFile "db.bo.port=" $DB_PORT
    regexFile "db.bo.host=" $DB_HOST
    regexFile "bo.api.host=" "$BACKOFFICE_API_URL/portal/pravaler_v2"

    msgConfig "Criando diretórios e definindo configurações:"
    if [ -d "xdebug-profile-logs" ]
    then
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs criado."
    fi
    chmod 777 -R $1

    dockerComposeUp 'creditscore'

    configHost 'creditscore' $CREDITSCORE_URL
}