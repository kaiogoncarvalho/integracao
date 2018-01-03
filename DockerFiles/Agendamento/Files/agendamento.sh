#!/usr/bin/env bash

setup_agendamento()
{
    docker run --rm -v $AGENDAMENTO_LOCAL/:/app kaioidealinvest/composer:php7.1 install
    cd $AGENDAMENTO_LOCAL
    cp .env.example .env
    DIR_DOCKER=$(echo $BACKOFFICE_DOCKER/ | sed -e "s/\//\\\\\//g")
    sed -i -E "s/BACKOFFICE_REPOSITORY=(.*)/BACKOFFICE_REPOSITORY=$DIR_DOCKER/g" .env
    cp $BACKOFFICE_LOCAL/.env $AGENDAMENTO_LOCAL/helpers/backoffice.env.bkp
    cd $AGENDAMENTO_LOCAL
    mkdir xdebug-profile-logs
    chmod 777 -R $AGENDAMENTO_LOCAL
}

