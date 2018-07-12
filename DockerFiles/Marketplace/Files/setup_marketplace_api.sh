#!/usr/bin/env bash

setup_seguros()
{
    cd $1

    composerConfig $1

    configInitialEnv '.env.example'

    msgConfig "Definindo Permissões:"
    chmod -R 777 $1/storage
    msgConfigItem "Permissões Definidas"

    dockerComposeUp 'marketplace'

    configHost 'seguros' $MARKETPLACE_API_URL

}
