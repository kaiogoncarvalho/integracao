#!/usr/bin/env bash

proposal(){

    composerConfig $1
    
     cd $1

     ln -s $NEO_CONFIG config.php
     
    msgConfig "Definindo Permissões:"

    chmod 777 -R .

    msgConfigItem "Permissões Definidas."

    dockerComposeUp 'proposal' 'neo'

    configHost $NEO_PROPOSAL_IP $NEO_PROPOSAL_URL

    testSystem $NEO_PROPOSAL_URL

}
