#!/usr/bin/env bash

setup_nova_proposta_frontend() {

    cd $1

    msgConfig "Copiando arquivo angular-cli.json: "
    if isNotValidFile angular-cli.json; then
        cp .angular-cli.json angular-cli.json
        msgConfigItemSucess "Arquivo angular-cli.json foi criado.\n"
    else
        msgConfigItemWarning "Arquivo angular-cli.json já existe.\n"
    fi

    npmInstall $1
    bowerInstall $1/src/assets

    msgConfig "Copiando arquivo de environment: "
    update_environment


    dockerComposeUp $NOVAPROPOSTA_FRONTEND_CONTAINER

    configHost $NOVAPROPOSTA_FRONTEND_CONTAINER $NOVAPROPOSTA_FRONTEND_URL

    chmod 777 -R $1

    msgGeneral "\nAguarde cerca de 45 segundos para que o Frontend da Nova Proposta funcione..." "verde" "reverso"
    msgGeneral "\nng serve sendo executado...\n" "branco" "reverso"

    sleep 45

    logContainer $ALFRED_CLIENT_CONTAINER

    include_callcenter_alfred_client
    include_bpm_alfred_client
    include_oauth_alfred_client

    dockerComposeUp 'nova_proposta_frontend'

    configHost 'nova_proposta_frontend' $NOVAPROPOSTA_FRONTEND_URL

    chmod 777 -R $1

    msgGeneral "\nAguarde cerca de 30 segundos para que o Frontend da Nova Proposta funcione..." "verde" "reverso"
    msgGeneral "\nnpm build sendo executado..." "branco" "reverso\n"

}

