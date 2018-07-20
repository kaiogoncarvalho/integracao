#!/bin/bash
#!/usr/bin/env bash

# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
#Variáveis do ENV
ENV=./.env
#Env Example
ENV_EXAMPLE=./example.env
# Configuração dos Outros Sistemas
OUTROS=./Menu/outros.sh
# Configuração dos Sistemas Neo
NEO=./Menu/neo.sh
# Configuração do Banco de Dados
DATABASE=./Menu/database.sh

INTEGRACAO_DIR=$(pwd)

. $HELPERS
. $OUTROS
. $NEO
. $DATABASE

# Inicializa as funções de configuração dos projetos
main() {
    configEnvIntegracao 'example.env'
    createNetwork
    clear

  while true;
  do
    clear

    printInBar "Ambientes Pravaler" "verde"
    echo -e
    printInBar "Criado por Kaio Gonçalves Carvalho"
    echo -e
    printInBar "Menu" "verde"
    printLine "1 - Instalar Ambientes"
    printLine "2 - Instalar Ambientes Neo"
    printLine "3 - Alterar Banco de Dados usado nas instalações"
    printInBar "s - Sair" "vermelho"
    read -p "| Informe a opção desejada >_ " OPTION

    clear

    case $OPTION in
      's')
        clear
        printInBar "Execução finalizada!"
        exit
      ;;
      'S')
        clear
        printInBar "Execução finalizada!"
        exit
      ;;
      1)
        outros
      ;;
      2)
        neo
      ;;
      3)
        database
      ;;
      *) clear
        printInBar "Opção inválida!"
      ;;
    esac
    clear
     if [ $TIPO_INSTALACAO == "servidor" ];
         then
            echo -e "\nConfigurando Nginx:\n"
            reloadEnv
            setup_nginx
        fi
    printInBar "Fim da operação."
    echo -e
  done
}

main
