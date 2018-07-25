#!/usr/bin/env bash
database_credit_score()
{

    if isValidInstall 'CREDITSCORE'; then
        cd $CREDITSCORE_LOCAL
        if isNotEmptyVariable $DATABASE_HOST; then
            regexFile "db.bo.host=" $DATABASE_HOST
        fi

        if isNotEmptyVariable $DATABASE_PORT; then
            regexFile "db.bo.port=" $DATABASE_PORT
        fi

        if isNotEmptyVariable $DATABASE_NAME; then
            regexFile "db.bo.dbname=" $DATABASE_NAME
        fi

        if isNotEmptyVariable $DATABASE_USER; then
            regexFile "db.bo.user=" $DATABASE_USER
        fi

        if isNotEmptyVariable $DATABASE_PASSWORD; then
            regexFile "db.bo.pass=" $DATABASE_PASSWORD
        fi
    fi
}

include_backoffice_creditscore()
{
    if isValidInstall 'BACKOFFICE' && isValidInstall 'CREDITSCORE'; then
        cd $CREDITSCORE_LOCAL
        regexFile "bo.api.host=" "$BACKOFFICE_API_URL/portal/pravaler_v2"
    fi
}

include_neolog_creditscore()
{

    if isValidInstall 'NEO_LOG' && isValidInstall 'CREDITSCORE'; then
        cd $NEO_LOG_LOCAL
        regexFile "neo.log.host=" $NEO_LOG_URL
    fi

}

include_neoproposal_creditscore()
{

    if isValidInstall 'NEO_PROPOSAL' && isValidInstall 'CREDITSCORE'; then
        cd $NEO_PROPOSAL_LOCAL
        regexFile "neo.proposal.host=" $NEO_PROPOSA_URL
    fi

}

setup_credit_score()
{

    composerConfig $1

    msgConfig "Definindo configurações do .env:"
    cd $1
    chmod 777 -R vendor/

    configInitialEnv '.env-example'

    database_credit_score

    include_backoffice_creditscore
    include_neolog_creditscore
    include_neoproposal_creditscore

    msgConfig "Criando diretórios e definindo configurações:"
    if [ -d "xdebug-profile-logs" ]
    then
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs criado."
    fi
    chmod 777 -R $1

    dockerComposeUp $CREDITSCORE_CONTAINER

    configHost $CREDITSCORE_CONTAINER $CREDITSCORE_URL
}