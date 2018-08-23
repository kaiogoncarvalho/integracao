#!/usr/bin/env bash

setup_agendamento()
{
    cd $1
    composerConfig $1

    configInitialEnv '.env.example'

    regexFile 'APP_URL=' "$AGENDAMENTO_URL"

    cd $1
    if [ -d "xdebug-profile-logs" ]
    then
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs foi criado."
    fi

     if [ -d '/var/data-mysql' ]
    then
        msgConfigItem "Diretório /var/data-mysql já existe."
    else
        mkdir /var/data-mysql
        msgConfigItem "Diretório /var/data-mysqlfoi criado."
    fi
    chmod 777 -R $1

   dockerComposeUp $AGENDAMENTO_CONTAINER

   configHost $AGENDAMENTO_CONTAINER $AGENDAMENTO_URL

   msgConfig "Executando php artisan key:generate: "
   docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" key:generate

   msgConfig "Executando php artisan migrate: "
   docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" migrate

   msgConfig "Executando php artisan db:seed: "
   docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" db:seed


}

