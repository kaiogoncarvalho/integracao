#!/usr/bin/env bash
database_backoffice()
{
    if isValidInstall 'BACKOFFICE'; then

        cd $BACKOFFICE_LOCAL
        if isNotEmptyVariable $DATABASE_HOST; then
            sed -i -E "/portal/!s/(db\.[[:print:]]+\.host=)([0-9.]*)/\1$DATABASE_HOST/g" .env
            regexFile 'logger.dns=' "pgsql:host=$DATABASE_HOST;port=$DATABASE_PORT;dbname=syslog;user=$DATABASE_USER"
        fi

        if isNotEmptyVariable $DATABASE_PORT; then
            sed -i -E "/portal/!s/(db\.[[:print:]]+\.port=)([0-9]*)/\1$DATABASE_PORT/g" .env
        fi

        if isNotEmptyVariable $DATABASE_NAME; then
            sed -i -E "/portal/!s/(db\.[[:print:]]+\.database=)([[:print:]]*)/\1$DATABASE_NAME/g" .env
        fi

        if isNotEmptyVariable $DATABASE_USER; then
            sed -i -E "/portal/!s/(db\.[[:print:]]+\.user=)([[:print:]]*)/\1$DATABASE_USER/g" .env
        fi

        if isNotEmptyVariable $DATABASE_PASSWORD; then
            sed -i -E "/portal/!s/(db\.[[:print:]]+\.pass=)([[:print:]]*)/\1$DATABASE_PASSWORD/g" .env
        fi

    fi


}

include_portalpravaler_backoffice()
{

     if isValidInstall 'PORTALPRAVALER' && isValidInstall 'BACKOFFICE'; then
          cd $BACKOFFICE_LOCAL
          regexFile 'portal.domain=' "$PORTALPRAVALER_URL"
     fi
}

include_novapropostafrontend_backoffice()
{

     if isValidInstall 'NOVAPROPOSTA_FRONTEND' && isValidInstall 'BACKOFFICE'; then
          cd $BACKOFFICE_LOCAL
          regexFile 'proposta2017.path=' "http://$NOVAPROPOSTA_FRONTEND_URL/app/\#/finalize"
     fi

}

include_retornomec_backoffice()
{

    if isValidInstall 'RETORNO_MEC' && isValidInstall 'BACKOFFICE'; then
        cd $BACKOFFICE_LOCAL
        regexFile 'retorno.mec=' "$RETORNO_MEC_URL"
    fi
}
include_apipravaler_backoffice()
{

    if isValidInstall 'APIPRAVALER' && isValidInstall 'BACKOFFICE'; then
        cd $BACKOFFICE_LOCAL
        regexFile 'api.aprovacaoIes.path=' "http://$APIPRAVALER_URL/v.1.1"
    fi
}

include_neolog_backoffice()
{

    if isValidInstall 'NEO_LOG' && isValidInstall 'BACKOFFICE'; then
        cd $BACKOFFICE_LOCAL
        regexFile 'neo.log=' "$NEO_LOG_URL"
    fi
}
setup_backoffice()
{

    composerConfig $1

    cd $1

    configInitialEnv 'sample.env'



    regexFile 'backoffice.domain=' "$BACKOFFICE_URL"

    regexFile 'api.path=' "http://$BACKOFFICE_URL/portal/pravaler_v2/api/"
    regexFile 'api.link.billet=' "http://$BACKOFFICE_URL/portal/pravaler/backoffice/"
    regexFile 'api.link.contract=' "http://$BACKOFFICE_URL/portal/pravaler/contrato/"
    regexFile 'api.link.debt=' "http://$BACKOFFICE_URL/portal/pravaler/backoffice/dividas/cmd.php?mAcordoID="

    regexFile 'api.url=' "$BACKOFFICE_API_URL/"

    regexFile 'neo.oauth=' "http://st.oauth.idealinvest.srv.br"
    regexFile 'neo.subscription_fee=' "http://st.fee.idealinvest.srv.br"
    regexFile 'neo.userToAccess=' "backoffice.contrato"
    regexFile 'neo.passwordToAccess=' "123456"
    regexFile 'neo.orig=' "https://bpm.desenv"


    msgConfigItem "Arquivo $(pwd)/.env configurado."

    msgConfig "Criando pastas necessárias: "

    cd html/portal/pravaler/
    
    if [ -d "csv" ]
    then
        msgConfigItem "Diretório $(pwd)/csv já existe."
    else
        mkdir csv
        msgConfigItem "Diretório $(pwd)/csv criado."
    fi

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

    if [ -d "riscoCobranca/planilhas" ]
    then
        echo -e "\n- Diretório $(pwd)/riscoCobranca/planilhas já existe."
    else
        mkdir -p riscoCobranca/planilhas
        echo -e "\n- Diretório $(pwd)/riscoCobranca/planilhas criado."
    fi

    if [ -d "boletosAcordoAvulso/boletosAvulsosSimples" ]
    then
        echo -e "\n- Diretório $(pwd)/boletosAcordoAvulso/boletosAvulsosSimples já existe."
    else
        mkdir -p boletosAcordoAvulso/boletosAvulsosSimples
        echo -e "\n- Diretório $(pwd)/boletosAcordoAvulso/boletosAvulsosSimples criado."
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

    dockerComposeUp $BACKOFFICE_CONTAINER

    configHost $BACKOFFICE_CONTAINER $BACKOFFICE_URL
    configHost $BACKOFFICE_CONTAINER $BACKOFFICE_API_URL

    database_backoffice

    include_portalpravaler_backoffice
    include_apipravaler_backoffice
    include_novaproposta_backoffice
    include_neolog_backoffice
    include_retornomec_backoffice

    include_backoffice_creditscore
}
