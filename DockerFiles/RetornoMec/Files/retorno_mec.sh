#!/usr/bin/env bash
display_database_retornomec()
{
    if validFile $RETORNO_MEC_LOCAL'/.env'; then
        SYSTEM_DB_HOST=$(grep -oP '(?<=DB_HOST=)([\d.]*)' $RETORNO_MEC_LOCAL/.env)
        SYSTEM_DB_PORT=$(grep -oP '(?<=DB_PORT=)([\d]*)' $RETORNO_MEC_LOCAL/.env)
        SYSTEM_DB_NAME=$(grep -oP '(?<=DB_DATABASE=)([\d\w[:punct:]]*)' $RETORNO_MEC_LOCAL/.env)
        SYSTEM_DB_USER=$(grep -oP '(?<=DB_USERNAME=)([\d\w[:punct:]]*)' $RETORNO_MEC_LOCAL/.env)
        SYSTEM_DB_PASSWORD=$(grep -oP '(?<=DB_PASSWORD=)([\d\w[:punct:]]*)' $RETORNO_MEC_LOCAL/.env)
    else
        STATUS=$STATUS"\033[07;31m- Arquivo .env não existe (necessário reinstalar o Sistema para criar)\033[00;31m\n\n"
    fi
}


database_retornomec()
{

    if isValidInstall 'RETORNO_MEC' && validDatabase; then
        cd $RETORNO_MEC_LOCAL
        regexFile 'DB_HOST=' "$DATABASE_HOST"
        regexFile 'DB_PORT=' "$DATABASE_PORT"
        regexFile 'DB_DATABASE=' "$DATABASE_NAME"
        regexFile 'DB_USERNAME=' "$DATABASE_USER"
        regexFile 'DB_PASSWORD=' "$DATABASE_PASSWORD"
        return 0
    fi
    return 1

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

    docker rm -f redis

    dockerComposeUp $RETORNO_MEC_CONTAINER

    configHost $RETORNO_MEC_CONTAINER $RETORNO_MEC_URL

    database_retornomec

    include_portalpravaler_retornomec
    include_apipravaler_retornomec

    include_retornomec_backoffice

    config_service 'RETORNO_MEC'

}
