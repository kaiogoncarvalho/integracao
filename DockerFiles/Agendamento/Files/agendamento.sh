#!/usr/bin/env bash

setup_agendamento()
{
    composerConfig $1

    echo -e "\n\tConfigurando .env:\n"
    cd $1
    if [ -f ".env" ]
    then
        echo "\nArquivo $(pwd)/.env já existe."
    else
        cp .env.example .env
    fi
    DIR_DOCKER=$(echo $BACKOFFICE_DOCKER/ | sed -e "s/\//\\\\\//g")
    sed -i -E "s/BACKOFFICE_REPOSITORY=(.*)/BACKOFFICE_REPOSITORY=$DIR_DOCKER/g" .env
    cp $BACKOFFICE_LOCAL/.env $1/helpers/backoffice.env.bkp

    echo -e "\n\t Criando diretórios:\n"
    cd $1
    if [ -d "xdebug-profile-logs" ]
    then
        echo -e "\n- Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        echo -e "\n- Diretório $(pwd)/xdebug-profile-logs foi criado."
    fi
    chmod 777 -R $1

   dockerComposeUp 'agendamento'

    configHost $AGENDAMENTO_IP $AGENDAMENTO_URL


}

