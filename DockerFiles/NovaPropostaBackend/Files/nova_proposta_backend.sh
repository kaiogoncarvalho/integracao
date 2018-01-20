#!/usr/bin/env bash

setup_nova_proposta_backend()
{
    cd $NOVAPROPOSTA_BACKEND_LOCAL
    docker run --rm -v $NOVAPROPOSTA_BACKEND_LOCAL/:/app kaioidealinvest/composer:php7.1 install
    if [ -f ".env" ]
    then
        echo "\nArquivo $(pwd)/.env já existe."
    else
        cp .env.example .env
    fi
    docker run --rm -v $NOVAPROPOSTA_BACKEND_LOCAL/:/app kaioidealinvest/php-cli:7.1 php artisan key:generate
    docker run --rm -v $NOVAPROPOSTA_BACKEND_LOCAL/:/app kaioidealinvest/node_modules:4 npm install

    sed -i -E "s/APP_URL=(.*)/APP_URL=$NOVAPROPOSTA_BACKEND_URL/g" .env
    sed -i -E "s/DB_HOST=(.*)/DB_HOST=mongo_db/g" .env
    sed -i -E "s/RABBITMQ_HOST=(.*)/RABBITMQ_HOST=rabbit_mq/g" .env
    sed -i -E "s/DB_BO_HOST=(.*)/DB_BO_HOST=$DB_HOST/g" .env
    sed -i -E "s/DB_BO_PORT=(.*)/DB_BO_PORT=$DB_PORT/g" .env
    sed -i -E "s/DB_BO_DATABASE=(.*)/DB_BO_DATABASE=$DB_DATABASE/g" .env
    sed -i -E "s/DB_BO_USERNAME=(.*)/DB_BO_USERNAME=$DB_USER/g" .env
    sed -i -E "s/DB_BO_PASSWORD=(.*)/DB_BO_PASSWORD=$DB_PASSWORD/g" .env
    sed -i -E "s/API_URL=(.*)/API_URL=$APIAPARTADA_URL/g" .env
    sed -i -E "s/BO_URL=(.*)/BO_URL=$BACKOFFICE_URL/g" .env

    if [ -d "xdebug-profile-logs" ]
    then
        echo "\nDiretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R .

    cd $INTEGRACAO_DIR

    docker-compose up -d nova_proposta_backend

}
