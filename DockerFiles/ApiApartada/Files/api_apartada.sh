#!/usr/bin/env bash

setup_api_apartada()
{

   msgConfig "Criando diretórios e definindo permissões: "
    cd $1
    chmod 777 -R html
    cd html/portal/pravaler_v2/api/app
    if [ -d "log" ]
    then
        msgConfigItem "Diretório $(pwd)/log já existe."
    else
        mkdir log
        msgConfigItem "Diretório $(pwd)/log foi criado."
    fi
    cd $1
    if [ -d "xdebug-profile-logs" ]
    then
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs foi criado."
    fi
    chmod 777 -R $1

    dockerComposeUp 'api_apartada'

    configHost $APIAPARTADA_IP $APIAPARTADA_URL
}
