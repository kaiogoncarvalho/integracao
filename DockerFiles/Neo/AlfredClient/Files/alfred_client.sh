#!/usr/bin/env bash

alfred_client() {

    dockerComposeUp 'alfred-client' 'neo'

    configHost $ALFRED_CLIENT_PROJECT $ALFRED_CLIENT_URL

    chmod 777 -R $1

    msgGeneral "\nAguarde cerca de 30 segundos para que o Alfred Client funcione..." "verde" "reverso"
    msgGeneral "\nnpm build sendo executado..." "branco" "reverso\n"

}

