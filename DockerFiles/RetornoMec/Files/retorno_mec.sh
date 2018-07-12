#!/usr/bin/env bash

retorno_mec()
{
    cd $1

    composerConfig $1

    configInitialEnv '.env.example'

    regexFile 'DB_HOST=' "$DB_HOST"
    regexFile 'DB_PORT=' "$DB_PORT"
    regexFile 'DB_DATABASE=' "$DB_DATABASE"
    regexFile 'DB_USERNAME=' "$DB_USER"
    regexFile 'DB_PASSWORD=' "$DB_PASSWORD"

    regexFile 'QUEUE_HOST=' "redis"

    regexFile 'PORTAL_URL=' "$PORTALPRAVALER_URL"

    regexFile 'PRAVALER_URL=' "$APIPRAVALER_URL"

    msgConfig "Definindo Permissões:"
    chmod 777 -R $1
    msgConfigItem "Permissões Definidas"

    dockerComposeUp 'retorno_mec'

    configHost 'retorno_mec' $RETORNO_MEC_URL

}
