#!/usr/bin/env bash
display_database_oauth()
{
    display_database_neo
}

oauth(){

    DIR=$1

    composerConfig $DIR

    docker run --rm -v $1:/app composer run-script symfony-scripts

     cd $DIR

    msgConfig "Configurando $NEO_CONFIG:"
    if isNotValidFile config.php; then
        ln -s $NEO_CONFIG config.php
        msgConfigItemSucess "Link do $NEO_CONFIG foi criado.\n"
    else
        msgConfigItemWarning "Link do $NEO_CONFIG já existe.\n"
    fi

    msgConfig "Definindo Permissões:"

    chmod 777 -R .

    msgConfigItem "Permissões Definidas."

    dockerComposeUp $(getEnv "$2_CONTAINER") 'neo'

    configHost $(getEnv "$2_CONTAINER")  $(getEnv "$2_URL")

    config_service $2

    database_neo

    include_oauth_alfredclient

}