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
        printInBar "Ambientes Neo" "amarelo"
        echo -e
        printInBar "Menu" "verde"

        printLineSystem "1  - Log" "NEO_LOG"
        printLineSystem "2  - Integration" "NEO_INTEGRATION"
        printLineSystem "3  - People" "NEO_PEOPLE"
        printLineSystem "4  - Oauth" "NEO_OAUTH"
        printLineSystem "5  - BPM" "NEO_BPM"
        printLineSystem "6  - Student" "NEO_STUDENT"
        printLineSystem "7  - Alfred Server" "ALFRED_SERVER"
        printLineSystem "8  - Alfred Client" "ALFRED_CLIENT"
        printLineSystem "9  - Negotiation" "NEO_NEGOTIATION"
        printLineSystem "10 - Neo Api" "NEO_API"
        printLineSystem "11 - Proposal" "NEO_PROPOSAL"


        if validFile $NEO_CONFIG; then
            printLine "12 - Ver/Alterar config.php" "amarelo" "negrito"
        fi

        printLine "0  - Voltar" "azul" "negrito"
        printInBar "s - Sair" "vermelho"
        read -p "| Informe a opção desejada >_ " OPTION

        clear

        case $OPTION in
          'S')
              printInBar "Execução finalizada!" 'verde'
              exit
          ;;
          's')
              printInBar "Execução finalizada!" 'verde'
              exit
          ;;
          0) break
          ;;
          1) detalhe "Log" "NEO_LOG" "service"
          ;;
          2) detalhe "Integration" "NEO_INTEGRATION" "service"
          ;;
          3) detalhe "People" "NEO_PEOPLE" "service"
          ;;
          4) detalhe "Oauth" "NEO_OAUTH" "oauth" "service"
          ;;
          5) detalhe "BPM" "NEO_BPM" "bpm"
          ;;
          6) detalhe "Student" "NEO_STUDENT" "service"
          ;;
          7) detalhe "Alfred Server" "ALFRED_SERVER" "service"
          ;;
          8) detalhe "Alfred Client" "ALFRED_CLIENT" "alfred_client"
          ;;
          9) detalhe "Negotiation" "NEO_NEGOTIATION" "service"
          ;;
          10) detalhe "Neo Api" "NEO_API" "service"
          ;;
          11) detalhe "Proposal" "NEO_PROPOSAL" "service"
          ;;
          12)

            if validFile $NEO_CONFIG; then
                vi $NEO_CONFIG
            else
                printInBar "Opção inválida!" "vermelho"
            fi
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}

