#!/usr/bin/env bash

negotiation(){

    composerConfig $1
    
     cd $1

     ln -s $NEO_CONFIG config.php
     
    msgConfig "Definindo Permissões:"

    chmod 777 -R .

    msgConfigItem "Permissões Definidas."

    dockerComposeUp 'negotiation' 'neo'

    configHost $NEO_NEGOTIATION_IP $NEO_NEGOTIATION_URL

}
