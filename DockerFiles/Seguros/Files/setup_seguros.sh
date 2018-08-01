#!/usr/bin/env bash
database_seguros()
{
    if  isValidInstall 'SEGUROS' && validDatabase; then
        cd $SEGUROS_LOCAL
        regexFile 'DATABASE_URL=' "pgsql://$DATABASE_USER:$DATABASE_PASSWORD@$DATABASE_HOST:$DATABASE_PORT/$DATABASE_NAME"
    fi
}

setup_seguros()
{
    cd $1

    composerConfig $1

    configInitialEnv '.env.dist'

    msgConfig "Definindo Permissões:"
    chmod 777 -R $1
    msgConfigItem "Permissões Definidas"

    dockerComposeUp $SEGUROS_CONTAINER

    configHost $SEGUROS_CONTAINER $SEGUROS_URL

}
