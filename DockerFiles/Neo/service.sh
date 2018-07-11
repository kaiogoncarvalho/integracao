#!/usr/bin/env bash

service(){

    DIR=$1

    composerConfig $DIR

     cd $DIR

    msgConfig "Configurando $NEO_CONFIG:"
    if isNotValidFile config.php; then
        ln -s $NEO_CONFIG config.php
        msgConfigItemSuccess "Link do $NEO_CONFIG foi criado.\n"
    else
        msgConfigItemWarning "Link do $NEO_CONFIG já existe.\n"
    fi

    msgConfig "Definindo Permissões:"

    chmod 777 -R .

    msgConfigItem "Permissões Definidas."

    dockerComposeUp $(getEnv "$2_PROJECT") 'neo'

    configHost $(getEnv "$2_PROJECT")  $(getEnv "$2_URL")

}
