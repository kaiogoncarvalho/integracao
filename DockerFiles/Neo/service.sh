#!/usr/bin/env bash
display_database_neo()
{
    if validFile $NEO_CONFIG; then
        SYSTEM_DB_HOST=$(php_preg_match "/(['\\\"]database['\\\"]\s*=>\s*array\s*\(.*?['\\\"]backoffice['\\\"]\s*=>\s*array\s*\([^)]*?['\\\"]host['\\\"]\s*=>\s*')([\d.]*)(?=['\\\"])/s"  $NEO_CONFIG 2)
        SYSTEM_DB_PORT=$(php_preg_match "/(['\\\"]database['\\\"]\s*=>\s*array\s*\(.*?['\\\"]backoffice['\\\"]\s*=>\s*array\s*\([^)]*?['\\\"]port['\\\"]\s*=>\s*')([\d]*)(?=['\\\"])/s"  $NEO_CONFIG 2)
        SYSTEM_DB_NAME=$(php_preg_match "/(['\\\"]database['\\\"]\s*=>\s*array\s*\(.*?['\\\"]backoffice['\\\"]\s*=>\s*array\s*\([^)]*?['\\\"]dbname['\\\"]\s*=>\s*')([\w\d[:punct:]]*)(?=['\\\"])/s"  $NEO_CONFIG 2)
        SYSTEM_DB_USER=$(php_preg_match "/(['\\\"]database['\\\"]\s*=>\s*array\s*\(.*?['\\\"]backoffice['\\\"]\s*=>\s*array\s*\([^)]*?['\\\"]user['\\\"]\s*=>\s*')([\w\d[:punct:]]*)(?=['\\\"])/s"  $NEO_CONFIG 2)
        SYSTEM_DB_PASSWORD=$(php_preg_match "/(['\\\"]database['\\\"]\s*=>\s*array\s*\(.*?['\\\"]backoffice['\\\"]\s*=>\s*array\s*\([^)]*?['\\\"]password['\\\"]\s*=>\s*')([\w\d[:punct:]]*)(?=['\\\"])/s"  $NEO_CONFIG 2)
    else
        STATUS=$STATUS"\033[07;31m- Arquivo config.php não existe (necessário reinstalar sistema para criar)\033[00;31m\n\n"
    fi
}
database_neo(){

        if validFile $NEO_CONFIG && validDatabase; then
            php_preg_replace "/(\'database\'\s*=>\s*array\s*\(.*?\'backoffice\'\s*=>\s*array\s*\([^)]*?\'host\'\s*=>\s*\')([\d.]*)(?=\')/s" '${1}'$DATABASE_HOST $NEO_CONFIG
            php_preg_replace "/(\'database\'\s*=>\s*array\s*\(.*?\'backoffice\'\s*=>\s*array\s*\([^)]*?\'port\'\s*=>\s*\')([\d.]*)(?=\')/s" '${1}'$DATABASE_PORT $NEO_CONFIG
            php_preg_replace "/(\'database\'\s*=>\s*array\s*\(.*?\'backoffice\'\s*=>\s*array\s*\([^)]*?\'dbname\'\s*=>\s*\')([\w_]*)(?=\')/s" '${1}'$DATABASE_NAME $NEO_CONFIG
            php_preg_replace "/(\'database\'\s*=>\s*array\s*\(.*?\'backoffice\'\s*=>\s*array\s*\([^)]*?\'user\'\s*=>\s*\')([\w_]*)(?=\')/s" '${1}'$DATABASE_USER $NEO_CONFIG
            php_preg_replace "/(\'database\'\s*=>\s*array\s*\(.*?\'backoffice\'\s*=>\s*array\s*\([^)]*?\'password\'\s*=>\s*\')(.*?)(?=\')/s" '${1}'$DATABASE_PASSWORD $NEO_CONFIG
            return 0
        fi
        return 1
}

config_service(){
    msgConfig "Incluindo Serviço no Config:"
    if isValidInstall $1 && validFile $NEO_CONFIG; then

        SYSTEM_URL='http://'$(getEnv "$1_URL")
        CONTAINER=$(getEnv "$1_CONTAINER")

        php_preg_replace "/(\'$CONTAINER\'\s*=>\s*array\s*\([^)]*\'host\'\s*=>\s*\')(http:[\w\d:.\/]*?)(?=\')/s" '${1}'$SYSTEM_URL $NEO_CONFIG

        msgConfigItemSucess "Serviço incluido.\n"
    else
        msgAlert "Serviço não incluido devido erro na instalação.\n"
    fi

}

service(){

    DIR=$1

    composerConfig $DIR

     cd $DIR

     configInitialEnv '.env.dist'

    msgConfig "Configurando $NEO_CONFIG:"
    if isNotValidFile 'config.php' && validFile $NEO_CONFIG;then
        rm -r config.php
        ln -s $NEO_CONFIG $DIR
        msgConfigItemSucess "Link de $NEO_CONFIG para $DIR/config.php  foi criado.\n"
    else
        msgConfigItemWarning "Link do $NEO_CONFIG  $DIR/config.php já existe.\n"
    fi

    msgConfig "Definindo Permissões:"

    chmod 777 -R .

    msgConfigItem "Permissões Definidas."

    dockerComposeUp $(getEnv "$2_CONTAINER") 'neo'

    configHost $(getEnv "$2_CONTAINER")  $(getEnv "$2_URL")

    config_service $2

    msgConfig "Atualizando Banco de dados no Config:"
    database_neo

    include_callcenter_alfredclient
    include_bpm_alfredclient
    include_oauth_alfredclient
    include_neolog_creditscore

    include_neoproposal_creditscore
    include_neolog_backoffice

}
