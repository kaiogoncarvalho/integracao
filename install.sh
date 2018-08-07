#!/bin/bash
#!/usr/bin/env bash

# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
#Variáveis do ENV
ENV=./.env

. $ENV
. $HELPERS

verifySudo

if [ -h "/bin/integracao" ]; then
    rm -r /bin/integracao
fi

updateEnv "INTEGRACAO_DIR=" $(pwd)
ln -rs ambientes.sh /bin/integracao

if [ -h "/bin/integracao" ]; then
    msgGeneral 'Instalado com Sucesso' 'verde' 'reverso'
else
    msgGeneral 'Erro ao realizar a instalação' 'vermelho' 'reverso'
fi
