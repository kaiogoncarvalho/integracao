#!/bin/bash
#!/usr/bin/env bash

# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
#Variáveis do ENV
ENV=./.env
#Env Example
ENV_EXAMPLE=./example.env
# Configuração dos Outros Sistemas
SISTEMAS=./Menu/sistemas.sh
# Configuração dos Sistemas Neo
NEO=./Menu/neo.sh
# Configuração do Banco de Dados
DATABASE=./Menu/database.sh
# Configuração do Nginx
NGINX_SH=./DockerFiles/Nginx/Files/nginx.sh

INTEGRACAO_DIR=$(pwd)

. $HELPERS
. $SISTEMAS
. $NEO
. $DATABASE
. $NGINX_SH

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
    if [ $TIPO_INSTALACAO == "servidor" ];
         then
           printLine "4 - Reinstalar Nginx do Servidor"
         fi
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
      4)
       if [ $TIPO_INSTALACAO == "servidor" ];
         then
            echo -e "\nConfigurando Nginx:\n"
            reloadEnv
            setup_nginx
         fi
       ;;
      *) clear
        printInBar "Opção inválida!"
      ;;
    esac
    clear
    printInBar "Fim da operação."
    echo -e
  done

}

main
