#!/usr/bin/env bash

setup_nova_proposta_backend()
{
    cd $1

    composerConfig $1

    echo -e "\n\tConfigurando arquivo .env: \n"
    if [ -f ".env" ]
    then
        echo -e "\n- Arquivo $(pwd)/.env já existe."
    else
        cp .env.example .env
    fi

    regexFile 'APP_URL=' $NOVAPROPOSTA_BACKEND_URL
    regexFile 'API_URL=' $APIAPARTADA_URL
    regexFile 'BO_URL=' $BACKOFFICE_URL
    regexFile 'DB_HOST=' $MONGO_IP
    regexFile 'DB_USERNAME=' 'propostanova'
    regexFile 'DB_PASSWORD=' 'propostanova'
    regexFile 'RABBITMQ_HOST=' 'rabbit_mq'
    regexFile 'DB_BO_HOST=' $DB_HOST
    regexFile 'DB_BO_PORT=' $DB_PORT
    regexFile 'DB_BO_DATABASE=' $DB_DATABASE
    regexFile 'DB_BO_USERNAME=' $DB_USER
    regexFile 'DB_BO_PASSWORD=' $DB_PASSWORD
    #regexFile 'NOVA_PROPOSTA_URL=' $NOVAPROPOSTA_FRONTEND_URL
    regexFile 'API_TOKEN=' "539a6c1ee350a8c21d56b68719a01caf"

    if [ -d "xdebug-profile-logs" ]
    then
        echo -e "\n- Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R .

    configHost $NOVAPROPOSTA_BACKEND_IP $NOVAPROPOSTA_BACKEND_URL

    #cd $INTEGRACAO_DIR/DockerFiles/NovaPropostaBackend/Files

    #echo -e "\n\tConfigurando arquivo $(pwd)/proposta.conf: \n"

    #cp example.proposta.conf proposta.conf

    #chmod 777 proposta.conf

    #regexFile 'root ' "$NOVAPROPOSTA_BACKEND_DOCUMENT_ROOT;" proposta.conf
    #regexFile 'server_name ' "$NOVAPROPOSTA_BACKEND_URL;" proposta.conf

    echo -e "\n- Arquivo $(pwd)/proposta.conf configurado."

    dockerComposeUp "nova_proposta_backend"

    docker rm -f mongo-temp

    echo -e "\n\tExecutando php artisan key:generate: \n"
    docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" key:generate

    echo -e "\n\tExecutando php artisan migrate: \n"
    docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" migrate

    echo -e "\n\tExecutando php artisan db:seed: \n"
    docker exec -ti nova_proposta_backend php "$NOVAPROPOSTA_BACKEND_DOCKER/artisan" db:seed

    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/instituicoes"
    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/campi"
    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/cursos"
    docker exec -ti nova_proposta_backend curl "http://$NOVAPROPOSTA_BACKEND_URL/v1/atualizar-base/atualizar"
}