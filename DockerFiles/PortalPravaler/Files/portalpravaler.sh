#!/usr/bin/env bash

setup_portal_pravaler()
{
    composerConfig "$1"
    composerConfig "$1/workbench/portal/analytics"
    composerConfig "$1/workbench/portal/plugins"
    composerConfig "$1/workbench/portal/pravaler-backoffice"
    composerConfig "$1/workbench/portal/proposal"
    composerConfig "$1/workbench/portal/marketplace"

    msgConfig "Configurando permissões de diretórios: "
    cd $1
    chmod -R 777 app/storage
    chmod -R 777 vendor
    chmod 777 composer.lock

    echo -e "Criando diretórios necessários: "
    if [ -d "xdebug-profile-logs" ]
    then
        msgConfigItem "\n- Diretório $(pwd)/xdebug-profile-logs já existe."
    else
        msgConfigItem "\n- Diretório $(pwd)/xdebug-profile-logs foi criado."
        mkdir xdebug-profile-logs
    fi
    chmod 777 -R $1

    dockerComposeUp 'portal_pravaler'

    configHost $PORTALPRAVALER_IP $PORTALPRAVALER_URL
}

