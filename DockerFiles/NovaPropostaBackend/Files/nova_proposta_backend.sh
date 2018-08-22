#!/usr/bin/env bash
display_database_nova_proposta_backend(){
    if validFile $NOVAPROPOSTA_BACKEND_LOCAL'/.env'; then
        SYSTEM_DB_HOST=$(grep -oP '(?<=DB_BO_HOST=)([\d.]*)' $NOVAPROPOSTA_BACKEND_LOCAL/.env)
        SYSTEM_DB_PORT=$(grep -oP '(?<=DB_BO_PORT=)([\d]*)' $NOVAPROPOSTA_BACKEND_LOCAL/.env)
        SYSTEM_DB_NAME=$(grep -oP '(?<=DB_BO_DATABASE=)([\d\w[:punct:]]*)' $NOVAPROPOSTA_BACKEND_LOCAL/.env)
        SYSTEM_DB_USER=$(grep -oP '(?<=DB_BO_USERNAME=)([\d\w[:punct:]]*)' $NOVAPROPOSTA_BACKEND_LOCAL/.env)
        SYSTEM_DB_PASSWORD=$(grep -oP '(?<=DB_BO_PASSWORD=)([\d\w[:punct:]]*)' $NOVAPROPOSTA_BACKEND_LOCAL/.env)
    else
        STATUS=$STATUS"\033[07;31m- Arquivo .env não existe (necessário reinstalar o Sistema para criar)\033[00;31m\n\n"
    fi

}

database_nova_proposta_backend(){

     if isValidInstall 'NOVAPROPOSTA_BACKEND' && validDatabase; then
        cd $NOVAPROPOSTA_BACKEND_LOCAL
        regexFile 'DB_BO_HOST=' $DATABASE_HOST
        regexFile 'DB_BO_PORT=' $DATABASE_PORT
        regexFile 'DB_BO_DATABASE=' $DATABASE_NAME
        regexFile 'DB_BO_USERNAME=' $DATABASE_USER
        regexFile 'DB_BO_PASSWORD=' $DATABASE_PASSWORD
        return 0
     fi

     return 1

}

include_backoffice_novapropostabackend(){

    if isValidInstall 'BACKOFFICE' && isValidInstall 'NOVAPROPOSTA_BACKEND'; then
        cd $NOVAPROPOSTA_BACKEND_LOCAL
        regexFile 'BO_URL=' "$BACKOFFICE_URL/"
    fi
}

include_novapropostafrontend_novapropostabackend()
{
    if isValidInstall 'NOVAPROPOSTA_FRONTEND' && isValidInstall 'NOVAPROPOSTA_BACKEND'; then
        cd $NOVAPROPOSTA_BACKEND_LOCAL
        regexFile 'NOVA_PROPOSTA_URL=' "http://$NOVAPROPOSTA_FRONTEND_URL/"
    fi

}

include_apiapartada_novapropostabackend()
{
    if isValidInstall 'APIAPARTADA' && isValidInstall 'NOVAPROPOSTA_BACKEND'; then
        cd $NOVAPROPOSTA_BACKEND_LOCAL
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
        msgConfigItemWarning "Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R .

    deleteContainer 'mongodb'
    deleteContainer 'rabbitmq'
    deleteContainer 'mongo-temp'

    dockerComposeUp "mongo-temp"

    dockerComposeUp $NOVAPROPOSTA_BACKEND_CONTAINER

    configHost "mongodb" "mongodb"

    configHost $NOVAPROPOSTA_BACKEND_CONTAINER $NOVAPROPOSTA_BACKEND_URL

    deleteContainer 'mongo-temp'

    msgConfig "Executando php artisan key:generate: "
    docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" key:generate

    msgConfig "Executando php artisan migrate: "
    docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" migrate

    msgConfig "Executando php artisan db:seed: "
    docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" db:seed


    database_nova_proposta_backend

    include_backoffice_novapropostabackend
    include_novapropostafrontend_novapropostabackend
    include_apiapartada_novapropostabackend

    include_novapropostabackend_novapropostafrontend

    msgConfig "Atualizando Instituições: "
    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/instituicoes"

    msgConfig "Atualizando Campis: "
    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/campi"

    msgConfig "Atualizando Cursos: "
    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/cursos"

    echo -e "\n"

    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/atualizar"


}