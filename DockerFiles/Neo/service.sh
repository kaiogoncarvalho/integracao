#!/usr/bin/env bash

config_service(){
    if isValidInstall $1; then
        msgConfig "Incluindo Serviço no Config:"

        SYSTEM_URL=$(getEnv "$2_URL")

        grep -i -E 's/(\s*.backoffice.\s*=>\s*array.[\s\w\d[:punct:]]*?.host.\s=>\s.)([\w\/:.]*)./g' $NEO_CONFIG


        msgConfigItemSucess "Serviço incluido.\n"
    fi

}

service(){

config_service $2
return 0

    DIR=$1

    composerConfig $DIR

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



    include_callcenter_alfredclient
    include_bpm_alfredclient
    include_oauth_alfredclient
    include_neolog_creditscore
    include_neoproposal_creditscore

}
