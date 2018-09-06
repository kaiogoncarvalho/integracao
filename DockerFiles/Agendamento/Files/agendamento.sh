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
        rm -r /var/data-mysql
    fi
    mkdir /var/data-mysql
    msgConfigItem "Diretório /var/data-mysql foi criado."
    chmod 777 -R $1

   deleteContainer 'mysql'

   dockerComposeUp $AGENDAMENTO_CONTAINER

   configHost $AGENDAMENTO_CONTAINER $AGENDAMENTO_URL

   msgConfig "Executando php artisan key:generate: "
   docker exec -ti $AGENDAMENTO_CONTAINER php "$AGENDAMENTO_DOCKER/artisan" key:generate

   msgConfig "Executando php artisan migrate: "
   docker exec -ti $AGENDAMENTO_CONTAINER php "$AGENDAMENTO_DOCKER/artisan" migrate

   msgConfig "Executando php artisan db:seed: "
   docker exec -ti $AGENDAMENTO_CONTAINER php "$AGENDAMENTO_DOCKER/artisan" db:seed


}

