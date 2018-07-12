#!/usr/bin/env bash

retorno_mec()
{
    cd $1

    composerConfig $1

    configInitialEnv '.env.example'

    regexFile 'DB_HOST=' "$DATABASE_HOST"
    regexFile 'DB_PORT=' "$DATABASE_PORT"
    regexFile 'DB_DATABASE=' "$DATABASE_NAME"
    regexFile 'DB_USERNAME=' "$DATABASE_USER"
    regexFile 'DB_PASSWORD=' "$DATABASE_PASSWORD"

    regexFile 'QUEUE_HOST=' "redis"

    regexFile 'PORTAL_URL=' "$PORTALPRAVALER_URL"

    regexFile 'PRAVALER_URL=' "$APIPRAVALER_URL"

    msgConfig "Definindo Permissões:"
    chmod 777 -R $1
    msgConfigItem "Permissões Definidas"

    dockerComposeUp 'retorno_mec'

    configHost 'retorno_mec' $RETORNO_MEC_URL

}
