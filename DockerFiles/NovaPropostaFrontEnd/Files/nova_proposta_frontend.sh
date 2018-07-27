#!/usr/bin/env bash
update_environment_novaproposta(){
    if isNotValidFile $NOVAPROPOSTA_FRONTEND_LOCAL/src/environments/environment.integration.ts; then
        cp $INTEGRACAO_DIR/DockerFiles/NovaPropostaFrontend/Files/environment.ts $NOVAPROPOSTA_FRONTEND_LOCAL/src/environments/
        msgConfigItemSucess "Arquivo de environment foi criado.\n"
    else
        msgConfigItemWarning "Arquivo de environment já existe.\n"
    fi

}
include_novapropostabackend_novapropostafrontend()
{

    if isValidInstall 'NOVAPROPOSTA_BACKEND' && isValidInstall 'NOVAPROPOSTA_FRONTEND'; then
        cd $$NOVAPROPOSTA_FRONTEND_LOCAL//src/environments
        regexFile '"host"\s*:\s*' '"http://'$NOVAPROPOSTA_BACKEND_URL'"' environment.ts
    fi
}

include_apipravaler_novapropostafrontend()
{
    if isValidInstall 'APIPRAVALER' && isValidInstall 'NOVAPROPOSTA_FRONTEND'; then
        cd $$NOVAPROPOSTA_FRONTEND_LOCAL//src/environments
        regexFile '"api"\s*:\s*' '"http://'$APIPRAVALER_URL'"' environment.ts
    fi
}
setup_nova_proposta_frontend() {

    cd $1

    msgConfig "Copiando arquivo angular-cli.json: "
    if isNotValidFile angular-cli.json; then
        cp ~angular-cli.json angular-cli.json
        msgConfigItemSucess "Arquivo angular-cli.json foi criado.\n"
    else
        msgConfigItemWarning "Arquivo angular-cli.json já existe.\n"
    fi

    npmInstall $1

    msgConfig "Copiando arquivo de environment: "
    update_environment_novaproposta


    dockerComposeUp $NOVAPROPOSTA_FRONTEND_CONTAINER

    configHost $NOVAPROPOSTA_FRONTEND_CONTAINER $NOVAPROPOSTA_FRONTEND_URL

    chmod 777 -R $1

    msgGeneral "\nAguarde cerca de 45 segundos para que o Frontend da Nova Proposta funcione..." "verde" "reverso"
    msgGeneral "\nng serve sendo executado...\n" "branco" "reverso"

    sleep 45

    logContainer $NOVAPROPOSTA_FRONTEND_CONTAINER

    include_novapropostabackend_novapropostafrontend
    include_apipravaler_novapropostafrontend

    include_novapropostafrontend_novapropostabackend

}

