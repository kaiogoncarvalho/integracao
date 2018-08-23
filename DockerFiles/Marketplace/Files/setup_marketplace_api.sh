#!/usr/bin/env bash

setup_marketplace_api()
{
    cd $1

    composerConfig $1

    configInitialEnv '.env.example'

    msgConfig "Definindo Permissões:"
    chmod -R 777 $1/storage
    msgConfigItem "Permissões Definidas"

    deleteContainer 'redis'

    dockerComposeUp $MARKETPLACE_API_CONTAINER

    configHost $MARKETPLACE_API_CONTAINER $MARKETPLACE_API_URL

}
