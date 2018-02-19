#!/usr/bin/env bash

setup_nova_proposta_frontend() {

    dockerComposeUp 'nova_proposta_frontend'

    configHost $NOVAPROPOSTAFRONTEND_IP $NOVAPROPOSTAFRONTEND_URL

}

