#!/bin/bash
#!/usr/bin/env bash

# Inicializa as funções de configuração dos projetos
sistemas() {
    while true;
    do
        printInBar "Ambientes Pravaler" "ciano"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        printInBar "Ambientes" "amarelo"
        echo -e
        printInBar "Menu" "verde"
        printLineSystem "1  - Backoffice" "BACKOFFICE"
        printLineSystem "2  - Agendamento de Homologação" "AGENDAMENTO"
        printLineSystem "3  - Api Apartada" "APIAPARTADA"
        printLineSystem "4  - Api Pravaler" "APIPRAVALER"
        printLineSystem "5  - CDN" "CDN"
        printLineSystem "6  - CreditScore" "CREDITSCORE"
        printLineSystem "7  - FTP Risco e Cobrança" "FTPRISCOCOBRANCA"
        printLineSystem "8  - Marketplace" "MARKETPLACE_API"
        printLineSystem "9  - Nova Proposta Backend" "NOVAPROPOSTA_BACKEND"
        printLineSystem "10 - Nova Proposta Frontend" "NOVAPROPOSTA_FRONTEND"
        printLineSystem "11 - Portal Pravaler" "PORTALPRAVALER"
        printLineSystem "12 - Retorno Mec" "RETORNO_MEC"
        printLineSystem "13 - Seguros" "SEGUROS"

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
          1) detalhe "Backoffice" "BACKOFFICE" "setup_backoffice"
          ;;
          2) detalhe "Agendamento de Homologação" "AGENDAMENTO" "setup_agendamento"
          ;;
          3) detalhe "Api Apartada" "APIAPARTADA" "setup_api_apartada"
          ;;
          4) detalhe "Api Pravaler" "APIPRAVALER" "setup_api_pravaler"
          ;;
          5) detalhe "CDN" "CDN" "setup_cdn"
          ;;
          6) detalhe "CreditScore" "CREDITSCORE" "setup_credit_score"
          ;;
          7) detalhe "FTP Risco e Cobrança" "FTPRISCOCOBRANCA" "ftp"
          ;;
          8) detalhe "Marketplace Api" "MARKETPLACE_API" "setup_marketplace_api"
          ;;
          9) detalhe "Nova Proposta Backend" "NOVAPROPOSTA_BACKEND" "setup_nova_proposta_backend"
          ;;
          10) detalhe "Nova Proposta Frontend" "NOVAPROPOSTA_FRONTEND" "setup_nova_proposta_frontend"
          ;;
          11) detalhe "Portal Pravaler" "PORTALPRAVALER" "setup_portal_pravaler"
          ;;
          12) detalhe "Retorno Mec" "RETORNO_MEC" "retorno_mec"
          ;;
          13) detalhe "Seguros" "SEGUROS" "setup_seguros"
          ;;

          *) clear
            printInBar "Opção inválida!" "vermelho"
          ;;

        esac

    done

}
