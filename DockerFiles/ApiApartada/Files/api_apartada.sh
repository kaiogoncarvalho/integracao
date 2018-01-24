#!/usr/bin/env bash

setup_api_apartada()
{

    echo -e "\n\tCriando diretórios e definindo permissões:\n"
    cd $1
    chmod 777 -R html
    cd html/portal/pravaler_v2/api/app
    if [ -d "log" ]
    then
        echo -e "\n- Diretório $(pwd)/log já existe."
    else
        mkdir log
        echo -e "\n- Diretório $(pwd)/log foi criado."
    fi
    cd $1
    if [ -d "xdebug-profile-logs" ]
    then
        echo -e "\n- Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        echo -e "\n - Diretório $(pwd)/xdebug-profile-logs foi criado."
    fi
    chmod 777 -R $1

    dockerComposeUp 'api_apartada'

    configHost $APIAPARTADA_IP $APIAPARTADA_URL
}
