#!/usr/bin/env bash

integration(){

    composerConfig $1
    
     cd $1

    ln -s $NEO_CONFIG config.php
     
    msgConfig "Definindo Permissões:"

    chmod 777 -R .

    msgConfigItem "Permissões Definidas."

    dockerComposeUp 'integration' 'neo'

    configHost $NEO_INTEGRATION_IP $NEO_INTEGRATION_URL

    testSystem $NEO_INTEGRATION_URL

}
