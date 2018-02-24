#!/usr/bin/env bash

setup_backoffice()
{

    composerConfig $1

    cd $1

    msgConfig "Configurando arquivo .env: "

    if [ -f ".env" ]
    then
        msgConfigItem "Arquivo $(pwd)/.env já existe."
    else
        cp sample.env .env
    fi

    regexFile 'db.(?!portal)[[:alpha:]]+.host=' "$DB_HOST"
    regexFile 'db.(?!portal)[[:alpha:]]+.port=' "$DB_PORT"
    regexFile 'db.(?!portal)[[:alpha:]]+..database=' "$DB_DATABASE"
    regexFile 'db.(?!portal)[[:alpha:]]+.user=' "$DB_USER"
    regexFile 'db.(?!portal)[[:alpha:]]+.pass=' "$DB_PASSWORD"

    regexFile 'backoffice.domain=' "$BACKOFFICE_URL"
    regexFile 'portal.domain=' "$PORTALPRAVALER_URL"

    regexFile 'logger.dns=' "pgsql:host=$DB_HOST;port=$DB_PORT;dbname=syslog;user=$DB_USER"

    regexFile 'api.path=' "http://$BACKOFFICE_URL/portal/pravaler_v2/api/"
    regexFile 'api.link.billet=' "http://$BACKOFFICE_URL/portal/pravaler/backoffice/"
    regexFile 'api.link.contract=' "http://$BACKOFFICE_URL/portal/pravaler/contrato/"
    regexFile 'api.link.debt=' "http://$BACKOFFICE_URL/portal/pravaler/backoffice/dividas/cmd.php?mAcordoID="

    regexFile 'proposta2017.path=' "http://$NOVAPROPOSTA_FRONTEND_URL/app/#/finalize"

    regexFile 'api.url=' "$BACKOFFICE_API_URL/"
    regexFile 'http://api.aprovacaoIes.path=' "$APIPRAVALER_URL/v.1.1"

    msgConfigItem "Arquivo $(pwd)/.env configurado."

    msgConfig "Criando pastas necessárias: "
    cd html/portal/pravaler/
    if [ -d "log" ]
    then
        msgConfigItem "Diretório $(pwd)/log já existe."
    else
        mkdir log
        msgConfigItem "Diretório $(pwd)/log criado."
    fi
    cd backoffice/
     if [ -d "cnab" ]
    then
        msgConfigItem "Diretório $(pwd)/cnab já existe."
    else
        mkdir cnab
        msgConfigItem "Diretório $(pwd)/cnab criado."
    fi
    cd cnab
    if [ -d "bancos" ]
    then
        msgConfigItem "Diretório $(pwd)/bancos já existe."
    else
        mkdir bancos
        msgConfigItem "Diretório $(pwd)/bancos criado."
    fi
    cd bancos
    if [ -d "db" ]
    then
        msgConfigItem "Diretório $(pwd)/db já existe."
    else
        mkdir db
        msgConfigItem "Diretório $(pwd)/db criado."
    fi
    cd $1
    if [ -d "xdebug-profile-logs" ]
    then
        msgConfigItem "Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        msgConfigItem "Diretório $(pwd)/xdebug-profile-log criado."
    fi

    msgConfig "Definindo Permissões:"

    chmod 777 -R .

    msgConfigItem "Permissões Definidas."

    dockerComposeUp 'backoffice'

    configHost $BACKOFFICE_IP $BACKOFFICE_URL
    configHost $BACKOFFICE_IP $BACKOFFICE_API_URL
}
