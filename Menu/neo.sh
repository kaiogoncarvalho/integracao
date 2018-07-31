#!/bin/bash
#!/usr/bin/env bash

# Inicializa as funções de configuração dos projetos
neo() {

 while true;
    do
        printInBar "Ambientes Pravaler" "ciano"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        printInBar "Ambientes Neo" "verde"
        printLine "1  - Alfred Client"
        printLine "2  - Alfred Server"
        printLine "3  - BPM"
        printLine "4  - Integration"
        printLine "5  - Log"
        printLine "6  - Negotiation"
        printLine "7  - Neo Api"
        printLine "8  - Oauth"
        printLine "9  - Proposal"
        printLine "10 - Student"
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
          1) detalhe "Alfred Client" "ALFRED_CLIENT" "alfred_client"
          ;;
          2) detalhe "Alfred Server" "ALFRED_SERVER" "service"
          ;;
          3) detalhe "BPM" "NEO_BPM" "service"
          ;;
          4) detalhe "Integration" "NEO_INTEGRATION" "service"
          ;;
          5) detalhe "Log" "NEO_LOG" "service"
          ;;
          6) detalhe "Negotiation" "NEO_NEGOTIATION" "service"
          ;;
          7) detalhe "Neo Api" "NEO_API" "service"
          ;;
          8) detalhe "Oauth" "NEO_OAUTH" "service"
          ;;
          9) detalhe "Proposal" "NEO_PROPOSAL" "service"
          ;;
          10) detalhe "Student" "NEO_STUDENT" "service"
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}

