#!/usr/bin/env bash

setup_backoffice()
{

    composerConfig $1

    cd $1

    echo -e "\n\tConfigurando arquivo .env: \n"
    if [ -f ".env" ]
    then
        echo -e "\n- Arquivo $(pwd)/.env já existe."
    else
        cp sample.env .env
    fi
    OLD_DB=$(grep -E "db.default.host=(.*)" .env | sed -n 's/^db.default.host=*//p' .env)
    sed -i  "s/$OLD_DB/$DB_HOST/g" .env
    OLD_PORT=$(grep -E "db.default.port=(.*)" .env | sed -n 's/^db.default.port=*//p' .env)
    sed -i  "s/$OLD_PORT/$DB_PORT/g" .env
    OLD_HOST=$(grep -E "backoffice.domain=(.*)" .env | sed -n 's/^backoffice.domain=*//p' .env)
    sed -i  "s/$OLD_HOST/$BACKOFFICE_URL/g" .env
    OLD_HOSTPORTAL=$(grep -E "portal.domain=(.*)" .env | sed -n 's/^portal.domain=*//p' .env)
    sed -i  "s/$OLD_HOSTPORTAL/$PORTALPRAVALER_URL/g" .env
    updateEnv 'api.aprovacaoIes.path' "$APIPRAVALER_URL\\/v.1.1"
    updateEnv 'api.url' "$BACKOFFICE_API_URL\\/"
    echo -e "\n- Arquivo $(pwd)/.env configurado."

    echo -e "\n\tCriando pastas necessárias: \n"
    cd html/portal/pravaler/
    if [ -d "log" ]
    then
        echo -e "\n- Diretório $(pwd)/log já existe."
    else
        mkdir log
        echo -e "\n- Diretório $(pwd)/log criado."
    fi
    cd backoffice/
     if [ -d "cnab" ]
    then
        echo -e "\n- Diretório $(pwd)/cnab já existe."
    else
        mkdir cnab
        echo -e "\n- Diretório $(pwd)/cnab criado."
    fi
    cd cnab
    if [ -d "bancos" ]
    then
        echo -e "\n- Diretório $(pwd)/bancos já existe."
    else
        mkdir bancos
        echo -e "\n- Diretório $(pwd)/bancos criado."
    fi
    cd bancos
    if [ -d "db" ]
    then
        echo -e "\n- Diretório $(pwd)/db já existe."
    else
        mkdir db
        echo -e "\n- Diretório $(pwd)/db criado."
    fi
    cd $1
    if [ -d "xdebug-profile-logs" ]
    then
        echo -e "\n- Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        mkdir xdebug-profile-logs
        echo -e "\n- Diretório $(pwd)/xdebug-profile-log criado."
    fi

    echo -e "\n\tDefinindo Permissões: \n"
    chmod 777 -R .
    echo -e "\n- Permissões Definidas."

    dockerComposeUp 'backoffice'

    configHost $BACKOFFICE_IP $BACKOFFICE_URL
    configHost $BACKOFFICE_IP $BACKOFFICE_API_URL
}
