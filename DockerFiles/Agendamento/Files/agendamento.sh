#!/usr/bin/env bash

setup_agendamento()
{
    docker run --rm -v $AGENDAMENTO_LOCAL/:/app kaioidealinvest/composer:php7.1 install
    cd $AGENDAMENTO_LOCAL
    if [ -f ".env" ]
    then
        echo "\nArquivo $(pwd)/.env já existe."
    else
        cp .env.example .env
    fi
    DIR_DOCKER=$(echo $BACKOFFICE_DOCKER/ | sed -e "s/\//\\\\\//g")
    sed -i -E "s/BACKOFFICE_REPOSITORY=(.*)/BACKOFFICE_REPOSITORY=$DIR_DOCKER/g" .env
    cp $BACKOFFICE_LOCAL/.env $AGENDAMENTO_LOCAL/helpers/backoffice.env.bkp
    cd $AGENDAMENTO_LOCAL
    if [ -d "xdebug-profile-logs" ]
    then
        echo "\nDiretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R $AGENDAMENTO_LOCAL
}

