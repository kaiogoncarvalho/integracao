#!/usr/bin/env bash
#Variáveis do ENV
ENV=./.env
# Configuração do Serviço de Negociação de acordos
NEGOTIATION_SH=./DockerFiles/Neo/Negotiation/negotiation.sh
# Configuração do Serviço de Proposta
PROPOSAL_SH=./DockerFiles/Neo/Proposal/proposal.sh
# Configuração do Serviço de Integração
INTEGRATION_SH=./DockerFiles/Neo/Integration/integration.sh
# Configuração do Serviço de Integração
STUDENT_SH=./DockerFiles/Neo/Student/student.sh
# Configuração da lib do Neo
LIB_SH=./DockerFiles/Neo/Lib/lib.sh
# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh


. $HELPERS
. $NEGOTIATION_SH
. $PROPOSAL_SH
. $INTEGRATION_SH
. $STUDENT_SH
. $LIB_SH



# Inicializa as funções de configuração dos projetos
main() {

    msgGeneral '\n\t\tIniciando configuração dos ambientes: \n' 'verde' 'negrito'

    configEnvIntegracao 'example.env'

    msgGeneral "\nConfigurando o config.php do Neo:\n" 'verde' 'negrito'

    if configNeo;
    then
        configRepository "Negotiation" "NEO_NEGOTIATION" "negotiation"
        configRepository "Proposal" "NEO_PROPOSAL" "proposal"
        configRepository "Integration" "NEO_INTEGRATION" "integration"
        configRepository "Student" "NEO_STUDENT" "student"
    fi



}

main
