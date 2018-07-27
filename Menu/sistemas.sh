#!/bin/bash
#!/usr/bin/env bash

# Inicializa as funções de configuração dos projetos
sistemas() {
    while true;
    do
        printInBar "Ambientes Pravaler" "verde"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        printInBar "Ambientes" "verde"
        printLine "1  - Agendamento de Homologação"
        printLine "2  - Api Apartada"
        printLine "3  - Api Pravaler"
        printLine "4  - Backoffice"
        printLine "5  - CDN"
        printLine "6  - CreditScore"
        printLine "7  - FTP Risco e Cobrança"
        printLine "8  - Marketplace"
        printLine "9  - Nova Proposta Backend"
        printLine "10 - Nova Proposta Frontend"
        printLine "11 - Portal Pravaler"
        printLine "12 - Retorno Mec"
        printLine "13 - Seguros"

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
          1) installSystem "Agendamento de Homologação" "AGENDAMENTO" "setup_agendamento"
          ;;
          2) installSystem "Api Apartada" "APIAPARTADA" "setup_api_apartada"
          ;;
          3) installSystem "Api Pravaler" "APIPRAVALER" "setup_api_pravaler"
          ;;
          4) installSystem "Backoffice" "BACKOFFICE" "setup_backoffice"
          ;;
          5) installSystem "CDN" "CDN" "setup_cdn"
          ;;
          6) installSystem "CreditScore" "CREDITSCORE" "setup_credit_score"
          ;;
          7)
            msgGeneral "\nComeçando configuração do FTP Risco e Cobrança:\n" 'verde' 'negrito'

            configEnvIntegracao 'example.env'
            createNetwork
            reloadEnv
            setup_ftp_risco_cobranca
          ;;
          8) installSystem "Marketplace Api" "MARKETPLACE_API" "setup_marketplace_api"
          ;;
          9) installSystem "Nova Proposta Backend" "NOVAPROPOSTA_BACKEND" "setup_nova_proposta_backend"
          ;;
          10) installSystem "Nova Proposta Frontend" "NOVAPROPOSTA_FRONTEND" "setup_nova_proposta_frontend"
          ;;
          11) installSystem "Portal Pravaler" "PORTALPRAVALER" "setup_portal_pravaler"
          ;;
          12) installSystem "Retorno Mec" "RETORNO_MEC" "retorno_mec"
          ;;
          13) installSystem "Seguros" "SEGUROS" "setup_seguros"
          ;;

          *) clear
            printInBar "Opção inválida!" "vermelho"
          ;;

        esac

    done

}
