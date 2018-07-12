#!/usr/bin/env bash

main(){
     while true;
    do
        printInBar "Ambientes Pravaler" "verde"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        echo -e
        printInBar "Banco de Dados"
        echo -e
        msgGeneral "Host: 10.10.100.21"
        msgGeneral "Porta: 5432"
        msgGeneral "Banco: iipravaler"
        msgGeneral "Usuário: iipravaler"
        echo -e
        printInBar "Menu" "verde"
        printLine "1  - Alterar Host"
        printLine "2  - Alterar Porta"
        printLine "3  - Alterar Nome do Banco"
        printLine "4  - Alterar Usuário"
        printLine "5  - Alterar Senha"
        printLine "0  - Voltar" "branco" "negrito"
        printInBar "s - Sair" "vermelho"
        read -p "| Informe a opção desejada >_ " OPTION

        clear

        printInBar "Inicio da operação"
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
          1) installSystem "Alfred Client" "ALFRED_CLIENT" "alfred_client"
          ;;
          *) printInBar "Opção inválida!"
          ;;
        esac
        printInBar "Fim da operação."
        echo -e
    done

}

main