#!/bin/bash
#!/usr/bin/env bash

# Funções Helpers do instalador de ambientes
HELPERS=./helpers.sh
#Variáveis do ENV
ENV=./.env

. $ENV
. $HELPERS

if [ -e "/bin/integracao" ]; then
    rm -r /bin/integracao
fi

updateEnv "INTEGRACAO_DIR=" $(pwd)

ln -rs ambientes.sh /bin/integracao
echo 'Instalado com Sucesso'