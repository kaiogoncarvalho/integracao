#!/usr/bin/env bash

tipoInstalacao(){
     while true;
    do
        printInBar "Ambientes Pravaler" "ciano"
        echo -e
        printInBar "Criado por Kaio Gonçalves Carvalho"
        echo -e
        printInBar "Tipo de Instalação" 'amarelo'
        echo -e
        echo -e "\033[01;37mTipo: \033[00;37m\033[01;32m$TIPO_INSTALACAO\033[00;37m"
        echo -e
        printInBar "Menu" "verde"
        printLine "1  - Alterar Tipo de Instalação"

        if [ $TIPO_INSTALACAO == 'servidor' ]; then
            printLine "2  - Alterar URL's em massa"
        fi

        printLine "0  - Voltar" "branco" "negrito"
        printInBar "s - Sair" "vermelho"
        read -p "| Informe a opção desejada >_ " OPTION

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
          1)
            echo -e
            printInBar "Tipo de Instalação" "verde"
            printLine "1  - Normal"
            printLine "2  - Servidor"
            printLine "0  - Voltar" "branco" "negrito"
            printInBar "s - Sair" "vermelho"
            read -p "| Informe a opção desejada >_ " TIPO
            case $TIPO in
            'S')
                clear
                printInBar "Execução finalizada!" "verde"
                 exit
              ;;
              's')
              clear
                  printInBar "Execução finalizada!" "verde"
                  exit
              ;;
            0) clear
            ;;
            1)
               updateEnv "TIPO_INSTALACAO=" 'normal'
               reloadEnv
               clear
               printInBar "Tipo de Instalação Atualizado com Sucesso!" "verde"
            ;;
            2)
               updateEnv "TIPO_INSTALACAO=" 'servidor'
               reloadEnv
               clear
               printInBar "Tipo de Instalação  Atualizado com Sucesso!" "verde"
            ;;
            *) printInBar "Opção inválida!" "vermelho"
            ;;
            esac
          ;;
          2)
           if [ $TIPO_INSTALACAO == 'servidor' ]; then
             echo -e
            printInBar "Escolha o Tipo de URL" "verde"
            printLine "1  - Risco e Financeiro"
            printLine "2  - Escolher Prefixo/Sufixo"
            printLine "0  - Voltar" "branco" "negrito"
            printInBar "s - Sair" "vermelho"
            read -p "| Informe a opção desejada >_ " TIPO_URL
            case $TIPO_URL in
            'S')
                clear
                printInBar "Execução finalizada!" "verde"
                 exit
              ;;
              's')
              clear
                  printInBar "Execução finalizada!" "verde"
                  exit
              ;;
            0) clear
            ;;
            1)
               clear
               updateUrlLote 'rf'
               printInBar "URL's Atualizadas com Sucesso!" "verde"
            ;;
            2)
               clear
               read -p "| Informe o Prefixo/Sufixo das URL's >_ " PREFIX
               updateUrlLote "$PREFIX"
               printInBar "URL's Atualizadas com Sucesso!" "verde"
            ;;
            *) printInBar "Opção inválida!" "vermelho"
            ;;
            esac
           else
            printInBar "Opção inválida!" "vermelho"
           fi

          ;;
          *) printInBar "Opção inválida!" "vermelho"
          ;;
        esac
    done

}
