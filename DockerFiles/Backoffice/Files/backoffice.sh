#!/usr/bin/env bash
display_database_backoffice()
{
    if validFile $BACKOFFICE_LOCAL'/.env'; then
        SYSTEM_DB_HOST=$(grep -oP '(?<=db.default.host=)([\d.]*)' $BACKOFFICE_LOCAL/.env)
        SYSTEM_DB_PORT=$(grep -oP '(?<=db.default.port=)([\d]*)' $BACKOFFICE_LOCAL/.env)
        SYSTEM_DB_NAME=$(grep -oP '(?<=db.default.name=)([\d\w[:punct:]]*)' $BACKOFFICE_LOCAL/.env)
        SYSTEM_DB_USER=$(grep -oP '(?<=db.default.user=)([\d\w[:punct:]]*)' $BACKOFFICE_LOCAL/.env)
        SYSTEM_DB_PASSWORD=$(grep -oP '(?<=db.default.pass=)([\d\w[:punct:]]*)' $BACKOFFICE_LOCAL/.env)
    else
        STATUS=$STATUS"\033[07;31m- Arquivo .env não existe (necessário reinstalar o Sistema para criar)\033[00;31m\n\n"
    fi
}

database_backoffice()
{
    if isValidInstall 'BACKOFFICE' && validDatabase; then
        cd $BACKOFFICE_LOCAL
        sed -i -E "/portal/!s/(db\.[[:print:]]+\.host=)([0-9.]*)/\1$DATABASE_HOST/g" .env
        regexFile 'logger.dns=' "pgsql:host=$DATABASE_HOST;port=$DATABASE_PORT;dbname=syslog;user=$DATABASE_USER;password=$DATABASE_PASSWORD"
        sed -i -E "/portal/!s/(db\.[[:print:]]+\.port=)([0-9]*)/\1$DATABASE_PORT/g" .env
        sed -i -E "/portal/!s/(db\.[[:print:]]+\.name=)([[:print:]]*)/\1$DATABASE_NAME/g" .env
        regexFile 'db.cep.name=' "xcep"
        sed -i -E "/portal/!s/(db\.[[:print:]]+\.user=)([[:print:]]*)/\1$DATABASE_USER/g" .env
        sed -i -E "/portal/!s/(db\.[[:print:]]+\.pass=)([[:print:]]*)/\1$DATABASE_PASSWORD/g" .env
        return 0
    fi
    return 1

}

include_in_backoffice()
{
    declare -A envs
    array_systems=("$@")

    envs["PORTALPRAVALER","REGEX"]="portal.domain="
    envs["PORTALPRAVALER","REPLACE"]=$PORTALPRAVALER_URL

    envs["NOVAPROPOSTA_FRONTEND","REGEX"]="proposta2017.path="
    envs["NOVAPROPOSTA_FRONTEND","REPLACE"]="http://$NOVAPROPOSTA_FRONTEND_URL/app/\#/finalize"

    envs["RETORNO_MEC","REGEX"]="retorno.mec="
    envs["RETORNO_MEC","REPLACE"]="http://$RETORNO_MEC_URL"

    envs["APIPRAVALER","REGEX"]="api.aprovacaoIes.path="
    envs["APIPRAVALER","REPLACE"]="http://$APIPRAVALER_URL/v1.1"

    envs["NEO_LOG","REGEX"]="neo.log="
    envs["NEO_LOG","REPLACE"]="http://$NEO_LOG_URL"

    envs["NEO_BPM","REGEX"]="neo.orig="
    envs["NEO_BPM","REPLACE"]="http://$NEO_BPM_URL"

    envs["SEGUROS","REGEX"]="seguro.index="
    envs["SEGUROS","REPLACE"]="http://$SEGUROS_URL"


    if isValidInstall 'BACKOFFICE'; then
        cd $BACKOFFICE_LOCAL
        for i in "${array_systems[@]}"
        do
             if isValidInstall $i; then
                if ! [ -z "${envs[$i,'REGEX']}" ] && ! [ -z "${envs[$i,'REPLACE']}" ]; then
                    regexFile "${envs[$i,'REGEX']}" "${envs[$i,'REPLACE']}"
                    CONTAINER=$(getEnv $i"_CONTAINER")
                    if verifyContainerStarted $CONTAINER && [ $2 == 'restart' ] 2> /dev/null ; then
                        restartContainer $CONTAINER
                        CONTAINER=''
                    fi
                fi

                if [ $i == 'NEO_OAUTH' ]; then
                    regexFile 'neo.oauth=' "http://$NEO_OAUTH_URL"
                    regexFile 'seguro.oauth=' "http://$NEO_OAUTH_URL"
                fi
             fi
        done
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

    regexFile 'neo.subscription_fee=' "http://st.fee.idealinvest.srv.br"
    regexFile 'neo.userToAccess=' "backoffice.contrato"
    regexFile 'neo.passwordToAccess=' "123456"

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

    systems=( "PORTALPRAVALER" "NOVAPROPOSTA_FRONTEND" "RETORNO_MEC" "APIPRAVALER" "NEO_LOG" "NEO_BPM" "NEO_OAUTH" "SEGUROS" )
    include_in_backoffice  "${systems[@]}"

    config_service 'BACKOFFICE'

    include_backoffice_creditscore
    include_backoffice_novapropostabackend
}
