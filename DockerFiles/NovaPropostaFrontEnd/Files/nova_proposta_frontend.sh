#!/usr/bin/env bash

setup_nova_proposta_frontend() {

    dockerComposeUp 'nova_proposta_frontend'

    configHost $NOVAPROPOSTA_FRONTEND_IP $NOVAPROPOSTA_FRONTEND_URL

    chmod 777 -R $1

    msgGeneral "\nAguarde cerca de 30 segundos para que o Frontend da Nova Proposta funcione..." "verde" "reverso"
    msgGeneral "\nnpm build sendo executado..." "branco" "reverso\n"

}

