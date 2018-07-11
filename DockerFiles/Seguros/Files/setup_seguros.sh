#!/usr/bin/env bash

setup_seguros()
{
    cd $1

    composerConfig $1

    configInitialEnv '.env.dist'

    regexFile 'DATABASE_URL=' "pgsql://iipravaler:mfmm2018@10.10.100.121:5432/iipravaler"

    msgConfig "Definindo Permissões:"
    chmod 777 -R $1
    msgConfigItem "Permissões Definidas"

    dockerComposeUp 'seguros'

    configHost 'seguros' $SEGUROS_URL

}
