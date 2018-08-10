#!/usr/bin/env bash
display_database_bpm()
{
    display_database_neo
}
database_bpm(){
    database_neo
}

bpm(){

    service $1 $2

    SYSTEM_URL='http://'$(getEnv "$2_URL")
    CONTAINER=$(getEnv "$2_CONTAINER")

    php_preg_replace "/(\'base_url\'\s*=>\s*')(http:[\w\d:.\/]*?)(?=\')/s" '${1}'$SYSTEM_URL $NEO_CONFIG

    include_bpm_alfredclient
    include_bpm_backoffice

}
