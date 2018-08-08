#!/usr/bin/env bash
update_environment(){
    if isNotValidFile $ALFRED_CLIENT_LOCAL/src/environments/environment.integration.ts; then
        cp $INTEGRACAO_DIR/DockerFiles/Neo/AlfredClient/Files/environment.integration.ts $ALFRED_CLIENT_LOCAL/src/environments/
        msgConfigItemSucess "Arquivo de environment foi criado.\n"
    else
        msgConfigItemWarning "Arquivo de environment já existe.\n"
    fi

}
include_callcenter_alfredclient(){

    if isValidInstall 'ALFRED_SERVER' && isValidInstall 'ALFRED_CLIENT'; then
        cd $ALFRED_CLIENT_LOCAL/src/environments
        regexFile '"alfredserver"\s*:\s*' '"http://'$ALFRED_SERVER_URL'"' environment.integration.ts
        restartContainer $ALFRED_CLIENT_CONTAINER
    fi

}

include_bpm_alfredclient(){

    if isValidInstall 'NEO_BPM' && isValidInstall 'ALFRED_CLIENT'; then
        cd $ALFRED_CLIENT_LOCAL/src/environments
        regexFile '"bpm"\s*:\s*' '"http://'$NEO_BPM_URL'",' environment.integration.ts
        restartContainer $ALFRED_CLIENT_CONTAINER

    fi

}

include_oauth_alfredclient(){

    if isValidInstall 'NEO_OAUTH' && isValidInstall 'ALFRED_CLIENT'; then
        cd $ALFRED_CLIENT_LOCAL/src/environments
        regexFile '"oauth"\s*:\s*' '"http://'$NEO_OAUTH_URL'",' environment.integration.ts
        restartContainer $ALFRED_CLIENT_CONTAINER
    fi

}


alfred_client() {

    cd $1

    msgConfig "Copiando arquivo angular-cli.json: "
    if isNotValidFile angular-cli.json; then
        cp .angular-cli.json angular-cli.json
        msgConfigItemSucess "Arquivo angular-cli.json foi criado.\n"
    else
        msgConfigItemWarning "Arquivo angular-cli.json já existe.\n"
    fi

    npmInstall $1
    bowerInstall $1/src/assets

    msgConfig "Copiando arquivo de environment: "
    update_environment


    dockerComposeUp $ALFRED_CLIENT_CONTAINER 'neo'

    configHost $ALFRED_CLIENT_CONTAINER $ALFRED_CLIENT_URL

    chmod 777 -R $1

    msgGeneral "\nAguarde cerca de 45 segundos para que o Alfred Client funcione..." "verde" "reverso"
    msgGeneral "\nnpm serve sendo executado...\n" "branco" "reverso"

    sleep 45

    logContainer $ALFRED_CLIENT_CONTAINER

    include_callcenter_alfredclient
    include_bpm_alfredclient
    include_oauth_alfredclient



}

