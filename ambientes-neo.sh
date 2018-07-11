#!/usr/bin/env bash
#Variáveis do ENV
ENV=./.env
#Env Example
ENV_EXAMPLE=./example.env
# Configuração padrão para instalação de serviço
SERVICE_SH=./DockerFiles/Neo/service.sh
# Configuração do Serviço de Negociação de acordos
ALFRED_CLIENT_SH=./DockerFiles/Neo/AlfredClient/Files/alfred_client.sh
# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh


. $HELPERS
. $SERVICE_SH
. $ALFRED_CLIENT_SH


# Inicializa as funções de configuração dos projetos
main() {

    msgGeneral '\n\t\tIniciando configuração dos ambientes: \n' 'verde' 'negrito'

    configEnvIntegracao 'example.env'

    createNetwork

    msgGeneral "\nConfigurando o config.php do Neo:\n" 'verde' 'negrito'

    if configNeo;
    then
        configRepository "Negotiation" "NEO_NEGOTIATION" "service"
        configRepository "Proposal" "NEO_PROPOSAL" "service"
        configRepository "Integration" "NEO_INTEGRATION" "service"
        configRepository "Student" "NEO_STUDENT" "service"
        configRepository "Alfred Server" "ALFRED_SERVER" "service"
        configRepository "Alfred Client" "ALFRED_CLIENT" "alfred_client"
        configRepository "Log" "NEO_LOG" "service"
        configRepository "Neo-API" "NEO_API" "service"
    fi



}

main
