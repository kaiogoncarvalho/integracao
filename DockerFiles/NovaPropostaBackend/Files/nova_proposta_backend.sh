#!/usr/bin/env bash
database_novapropostabackend(){

     if isValidInstall 'NOVAPROPOSTA_BACKEND'; then


        if validDatabase; then
            cd $BACKOFFICE_LOCAL
            regexFile 'DB_BO_HOST=' $DATABASE_HOST
            regexFile 'DB_BO_PORT=' $DATABASE_PORT
            regexFile 'DB_BO_DATABASE=' $DATABASE_NAME
            regexFile 'DB_BO_USERNAME=' $DATABASE_USER
            regexFile 'DB_BO_PASSWORD=' $DATABASE_PASSWORD
        fi
     fi

}

include_backoffice_novapropostabackend(){

    if isValidInstall 'BACKOFFICE' && isValidInstall 'NOVAPROPOSTA_BACKEND'; then
        regexFile 'BO_URL=' "$BACKOFFICE_URL/"
    fi
}

include_novapropostafrontend_novapropostabackend()
{
    if isValidInstall 'NOVAPROPOSTA_FRONTEND' && isValidInstall 'NOVAPROPOSTA_BACKEND'; then
        regexFile 'NOVA_PROPOSTA_URL=' "http://$NOVAPROPOSTA_FRONTEND_URL/"
    fi

}

include_apiapartada_novapropostabackend()
{
    if isValidInstall 'APIAPARTADA' && isValidInstall 'NOVAPROPOSTA_BACKEND'; then
        regexFile 'API_URL=' "$APIAPARTADA_URL/"
    fi

}
setup_nova_proposta_backend()
{
    cd $1

    composerConfig $1

    configInitialEnv '.env.example'

    regexFile 'APP_ENV=' "homolog"
    regexFile 'APP_URL=' $NOVAPROPOSTA_BACKEND_URL
    regexFile 'DB_HOST=' 'mongodb'
    regexFile 'DB_USERNAME=' 'propostanova'
    regexFile 'DB_PASSWORD=' 'propostanova'
    regexFile 'RABBITMQ_HOST=' 'rabbitmq'


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

    dockerComposeUp $NOVAPROPOSTA_BACKEND_CONTAINER

    configHost "mongodb" "mongodb"

    configHost $NOVAPROPOSTA_BACKEND_CONTAINER $NOVAPROPOSTA_BACKEND_URL

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

    database_novapropostabackend

    include_backoffice_novapropostabackend
    include_novapropostafrontend_novapropostabackend
    include_apiapartada_novapropostabackend

    include_novapropostafrontend_backoffice
    include_novapropostabackend_novapropostafrontend
}