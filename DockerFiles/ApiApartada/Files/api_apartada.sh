#!/usr/bin/env bash

setup_api_apartada()
{
    cd $APIAPARTADA_LOCAL
    chmod 777 -R html
    cd html/portal/pravaler_v2/api/app
    if [ -d "log" ]
    then
        echo "\nDiretório $(pwd)/log já existe."
    else
        mkdir log
    fi
    cd $APIAPARTADA_LOCAL
    if [ -d "xdebug-profile-logs" ]
    then
        echo "\nDiretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R $APIAPARTADA_LOCAL
}
