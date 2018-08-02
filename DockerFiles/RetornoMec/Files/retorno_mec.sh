#!/usr/bin/env bash
database_retornomec()
{

    if isValidInstall 'RETORNO_MEC' && validDatabase; then
        regexFile 'DB_HOST=' "$DATABASE_HOST"
        regexFile 'DB_PORT=' "$DATABASE_PORT"
        regexFile 'DB_DATABASE=' "$DATABASE_NAME"
        regexFile 'DB_USERNAME=' "$DATABASE_USER"
        regexFile 'DB_PASSWORD=' "$DATABASE_PASSWORD"
    fi

}

include_portalpravaler_retornomec()
{
    if isValidInstall 'RETORNO_MEC' && isValidInstall 'PORTALPRAVALER' ; then
        cd $RETORNO_MEC_LOCAL
        regexFile 'PORTAL_URL=' "$PORTALPRAVALER_URL"
    fi

}

include_apipravaler_retornomec()
{
    if isValidInstall 'RETORNO_MEC' && isValidInstall 'PORTALPRAVALER' ; then
        cd $RETORNO_MEC_LOCAL
        regexFile 'PRAVALER_URL=' "$APIPRAVALER_URL"
    fi

}



retorno_mec()
{
    cd $1

    composerConfig $1

    configInitialEnv '.env.example'

    regexFile 'QUEUE_HOST=' "redis"


    msgConfig "Definindo Permissões:"
    chmod 777 -R $1
    msgConfigItem "Permissões Definidas"

    dockerComposeUp $RETORNO_MEC_CONTAINER

    configHost $RETORNO_MEC_CONTAINER $RETORNO_MEC_URL

    database_retornomec

    include_portalpravaler_retornomec
    include_apipravaler_retornomec

    include_retornomec_backoffice

    config_service 'RETORNO_MEC'

}
