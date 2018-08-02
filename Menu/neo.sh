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
        printLine "1  - Alfred Client"
        printLine "2  - Alfred Server"
        printLine "3  - BPM"
        printLine "4  - Integration"
        printLine "5  - Log"
        printLine "6  - Negotiation"
        printLine "7  - Neo Api"
        printLine "8  - Oauth"
        printLine "9  - People"
        printLine "10 - Proposal"
        printLine "11 - Retorno Mec"
        printLine "12 - Student"
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
          8) detalhe "Oauth" "NEO_OAUTH" "oauth"
          ;;
          9) detalhe "People" "NEO_PEOPLE" "service"
          ;;
          10) detalhe "Proposal" "NEO_PROPOSAL" "service"
          ;;
          11) detalhe "Retorno Mec" "RETORNO_MEC" "retorno_mec"
          ;;
          12) detalhe "Student" "NEO_STUDENT" "service"
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}

