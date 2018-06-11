#!/usr/bin/env bash

student(){

    composerConfig $1
    
     cd $1

     ln -s $NEO_CONFIG config.php
     
    msgConfig "Definindo Permissões:"

    chmod 777 -R .

    msgConfigItem "Permissões Definidas."

    dockerComposeUp 'student' 'neo'

    configHost $NEO_STUDENT_IP $NEO_STUDENT_URL

}
