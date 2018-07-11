#!/usr/bin/env bash

setup_nova_proposta_backend()
{
    cd $1

    composerConfig $1

    configInitialEnv '.env.example'

    regexFile 'APP_ENV=' "homolog"
    regexFile 'APP_URL=' $NOVAPROPOSTA_BACKEND_URL
    regexFile 'API_URL=' "$APIAPARTADA_URL/"
    regexFile 'BO_URL=' "$BACKOFFICE_URL/"
    regexFile 'DB_HOST=' 'mongodb'
    regexFile 'DB_USERNAME=' 'propostanova'
    regexFile 'DB_PASSWORD=' 'propostanova'
    regexFile 'RABBITMQ_HOST=' 'rabbitmq'
    regexFile 'DB_BO_HOST=' $DB_HOST
    regexFile 'DB_BO_PORT=' $DB_PORT
    regexFile 'DB_BO_DATABASE=' $DB_DATABASE
    regexFile 'DB_BO_USERNAME=' $DB_USER
    regexFile 'DB_BO_PASSWORD=' $DB_PASSWORD
    regexFile 'NOVA_PROPOSTA_URL=' "http://$NOVAPROPOSTA_FRONTEND_URL/"
    regexFile 'API_TOKEN=' "539a6c1ee350a8c21d56b68719a01caf"
    regexFile 'PROXY=' ""

    if [ -d "xdebug-profile-logs" ]
    then
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R .

    docker rm -f mongodb

    dockerComposeUp "mongo-temp"

    dockerComposeUp "nova_proposta_backend"

    configHost "mongodb" "mongodb"

    configHost "nova_proposta_backend" $NOVAPROPOSTA_BACKEND_URL

    docker rm -f mongo-temp


    msgConfig "Executando php artisan key:generate: "
    docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" key:generate

    msgConfig "Executando php artisan migrate: "
    docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" migrate

    msgConfig "Executando php artisan db:seed: "
    docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" db:seed

    msgConfig "Atualizando Instituições: "
    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/instituicoes"

    msgConfig "Atualizando Campis: "
    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/campi"

    msgConfig "Atualizando Cursos: "
    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/cursos"

    echo -e "\n"

    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/atualizar"
}