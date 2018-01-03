#!/usr/bin/env bash

setup_api_apartada()
{
    cd $APIAPARTADA_LOCAL
    chmod 777 -R html
    cd html/portal/pravaler_v2/api/app
    mkdir log
    cd $APIAPARTADA_LOCAL
    mkdir xdebug-profile-logs
    chmod 777 -R $APIAPARTADA_LOCAL
}
