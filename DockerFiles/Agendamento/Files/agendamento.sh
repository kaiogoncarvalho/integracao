#!/usr/bin/env bash

setup_agendamento()
{
    composerConfig $1
    cd $1

    configInitialEnv '.env.example'

    regexFile 'BACKOFFICE_REPOSITORY=' $BACKOFFICE_DOCKER
    cp $BACKOFFICE_LOCAL/.env $1/helpers/backoffice.env.bkp

    msgConfig "Criando diretórios: "
    cd $1
    if [ -d "xdebug-profile-logs" ]
    then
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs foi criado."
    fi
    chmod 777 -R $1

   dockerComposeUp $AGENDAMENTO_CONTAINER

   configHost $AGENDAMENTO_CONTAINER $AGENDAMENTO_URL


}

