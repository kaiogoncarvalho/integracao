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

        printLine "1  - Log"
        printLine "2  - Integration"
        printLine "3  - People"
        printLine "4  - Oauth"
        printLine "5  - BPM"
        printLine "6  - Student"
        printLine "7  - Alfred Server"
        printLine "8  - Alfred Client"
        printLine "9  - Negotiation"
        printLine "10 - Neo Api"
        printLine "11 - Proposal"
        printLine "12 - Retorno Mec"

        printLine "0  - Voltar" "branco" "negrito"
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
          5) detalhe "BPM" "NEO_BPM" "service"
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
          12) detalhe "Retorno Mec" "RETORNO_MEC" "retorno_mec"
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}

