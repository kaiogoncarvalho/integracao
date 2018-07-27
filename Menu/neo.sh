#!/bin/bash
#!/usr/bin/env bash

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
          1) detalhe "Alfred Client" "ALFRED_CLIENT" "alfred_client"
          ;;
          2) detalhe "Alfred Server" "ALFRED_SERVER" "service"
          ;;
          3) detalhe "Integration" "NEO_INTEGRATION" "service"
          ;;
          4) detalhe "Log" "NEO_LOG" "service"
          ;;
          5) detalhe "Negotiation" "NEO_NEGOTIATION" "service"
          ;;
          6) detalhe "Neo Api" "NEO_API" "service"
          ;;
          7) detalhe "Proposal" "NEO_PROPOSAL" "service"
          ;;
          8) detalhe "Student" "NEO_STUDENT" "service"
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}

