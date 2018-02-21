#!/usr/bin/env bash

setup_nova_proposta_frontend() {

    dockerComposeUp 'nova_proposta_frontend'

    configHost $NOVAPROPOSTA_FRONTEND_IP $NOVAPROPOSTA_FRONTEND_URL


}

