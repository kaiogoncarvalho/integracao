#!/usr/bin/env bash

alfred_client() {

    npmInstall $1
    bowerInstall $1/src/assets

    dockerComposeUp $ALFRED_CLIENT_CONTAINER 'neo'

    configHost $ALFRED_CLIENT_CONTAINER $ALFRED_CLIENT_URL

    chmod 777 -R $1

    msgGeneral "\nAguarde cerca de 45 segundos para que o Alfred Client funcione..." "verde" "reverso"
    msgGeneral "\nnpm build sendo executado...\n" "branco" "reverso"

    sleep 45

    logContainer $ALFRED_CLIENT_CONTAINER

}

