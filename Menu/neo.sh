#!/bin/bash
#!/usr/bin/env bash
# Configuração padrão para instalação de serviço
SERVICE_SH=./DockerFiles/Neo/service.sh
# Configuração do Serviço de Negociação de acordos
ALFRED_CLIENT_SH=./DockerFiles/Neo/AlfredClient/Files/alfred_client.sh


. $SERVICE_SH
. $ALFRED_CLIENT_SH


# Inicializa as funções de configuração dos projetos
neo() {

 while true;
    do
        printInBar "Ambientes Pravaler" "verde"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        printInBar "Ambientes Neo" "verde"
        printLine "1  - Alfred Client"
        printLine "2  - Alfred Server"
        printLine "3  - Integration"
        printLine "4  - Log"
        printLine "5  - Negotiation"
        printLine "6  - Neo Api"
        printLine "7  - Proposal"
        printLine "8  - Student"
        printLine "0  - Voltar" "branco" "negrito"
        printInBar "s - Sair" "vermelho"
        read -p "| Informe a opção desejada >_ " OPTION

        clear

        case $OPTION in
          'S')
              printInBar "Execução finalizada!"
              exit
          ;;
          's')
              printInBar "Execução finalizada!"
              exit
          ;;
          0) break
          ;;
          1) installSystem "Alfred Client" "ALFRED_CLIENT" "alfred_client"
          ;;
          2) installServiceNeo "Alfred Server" "ALFRED_SERVER" "service"
          ;;
          3) installServiceNeo "Integration" "NEO_INTEGRATION" "service"
          ;;
          4) installServiceNeo "Log" "NEO_LOG" "service"
          ;;
          5) installServiceNeo "Negotiation" "NEO_NEGOTIATION" "service"
          ;;
          6) installServiceNeo "Neo Api" "NEO_API" "service"
          ;;
          7) installServiceNeo "Proposal" "NEO_PROPOSAL" "service"
          ;;
          8) installServiceNeo "Student" "NEO_STUDENT" "service"
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}

