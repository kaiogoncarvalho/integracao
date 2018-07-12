#!/usr/bin/env bash

installType(){
     while true;
    do
        printInBar "Ambientes Pravaler" "verde"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        echo -e
        printInBar "Tipo de Instalação"
        echo -e
        msgGeneral "Tipo: $TIPO_INSTALACAO"
        echo -e
        printInBar "Menu" "verde"
        printLine "1  - Alterar Tipo de Instalação"
        printLine "0  - Voltar" "branco" "negrito"
        printInBar "s - Sair" "vermelho"
        read -p "| Informe a opção desejada >_ " OPTION

        clear

        case $OPTION in
          'S')
              printInBar "Execução finalizada!" "verde"
              exit
          ;;
          's')
              printInBar "Execução finalizada!" "verde"
              exit
          ;;
          0) break
          ;;
          1) databaseHost
             clear
             printInBar "Atualizado com Sucesso!" "ciano"
          ;;
          2) databasePort
             clear
             printInBar "Atualizado com Sucesso!" "ciano"
          ;;
          3) databaseName
             clear
             printInBar "Atualizado com Sucesso!" "ciano"
          ;;
          4) databaseUser
             clear
             printInBar "Atualizado com Sucesso!" "ciano"
          ;;
          5) databasePassword
             clear
             printInBar "Atualizado com Sucesso!" "ciano"
          ;;
          6)
           msgGeneral "Senha: $DATABASE_PASSWORD" "branco" "negrito"
            sleep 1
            clear
          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}