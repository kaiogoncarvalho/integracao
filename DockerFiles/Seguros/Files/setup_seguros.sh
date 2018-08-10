#!/usr/bin/env bash
display_database_seguros()
{
    if validFile $SEGUROS_LOCAL'/.env'; then
        SYSTEM_DB_HOST=$(php_preg_match "/(?<=DATABASE_URL=pgsql:\/\/)[^@]+?@([\d.]+?):/s"  $SEGUROS_LOCAL/.env 1)
        SYSTEM_DB_PORT=$(php_preg_match "/(?<=DATABASE_URL=pgsql:\/\/)[^@]+?@([\d.]+?):([\d]+?)\//s"  $SEGUROS_LOCAL/.env 2)
        SYSTEM_DB_NAME=$(php_preg_match "/(?<=DATABASE_URL=pgsql:\/\/)[^\/]+?\/([\w_[:punct:]]+)/s"  $SEGUROS_LOCAL/.env 1)
        SYSTEM_DB_USER=$(php_preg_match "/(?<=DATABASE_URL=pgsql:\/\/)[^\/]+?\/([\w_[:punct:]]+)/s"  $SEGUROS_LOCAL/.env 1)
        SYSTEM_DB_PASSWORD=$(php_preg_match "/(?<=DATABASE_URL=pgsql:\/\/)[^:]+?:([\w_[:punct:]]+?)@/s"  $SEGUROS_LOCAL/.env 1)

        SYSTEM_DB_USER=$(regexFilterReverse $SYSTEM_DB_USER)
        SYSTEM_DB_PASSWORD=$(regexFilterReverse $SYSTEM_DB_PASSWORD)

    else
        STATUS=$STATUS"\033[07;31m- Arquivo .env não existe (necessário reinstalar o Sistema para criar)\033[00;31m\n\n"
    fi

}
database_seguros()
{
    if  isValidInstall 'SEGUROS' && validDatabase; then
        cd $SEGUROS_LOCAL
        DATABASE_PASSWORD_NEW=$(regexFilter $DATABASE_PASSWORD)
        DATABASE_USER_NEW=$(regexFilter $DATABASE_USER)
        regexFile 'DATABASE_URL=' "pgsql://$DATABASE_USER_NEW:$DATABASE_PASSWORD_NEW@$DATABASE_HOST:$DATABASE_PORT/$DATABASE_NAME"
        return 0
    fi
    return 1
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
