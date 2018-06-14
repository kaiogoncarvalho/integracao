#!/usr/bin/env bash

service(){

    DIR=$1

    composerConfig $DIR

     cd $DIR

    ln -s $NEO_CONFIG config.php

    msgConfig "Definindo Permissões:"

    chmod 777 -R .

    msgConfigItem "Permissões Definidas."

    dockerComposeUp $(getEnv "$2_PROJECT") 'neo'

    configHost $(getEnv "$2_IP")  $(getEnv "$2_URL")

}
