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

    if isValidInstall 'ALFRED_SERVER' && isValidRepository $ALFRED_CLIENT_LOCAL; then
        cd $ALFRED_CLIENT_LOCAL/src/environments
        regexFile '"alfredserver"\s*:\s*' '"http://'$ALFRED_SERVER_URL'"' environment.integration.ts
        if verifyContainerStarted $ALFRED_CLIENT_CONTAINER && [ $1 != 'restart' ] 2> /dev/null ; then
            restartContainer $ALFRED_CLIENT_CONTAINER
        fi
    fi

}

include_bpm_alfredclient(){

    if isValidInstall 'NEO_BPM' && isValidRepository $ALFRED_CLIENT_LOCAL; then
        cd $ALFRED_CLIENT_LOCAL/src/environments
        regexFile '"bpm"\s*:\s*' '"http://'$NEO_BPM_URL'",' environment.integration.ts
        if verifyContainerStarted $ALFRED_CLIENT_CONTAINER && [ $1 == 'restart' ] 2> /dev/null ; then
            restartContainer $ALFRED_CLIENT_CONTAINER
        fi

    fi

}

include_oauth_alfredclient(){

    if isValidInstall 'NEO_OAUTH' && isValidRepository $ALFRED_CLIENT_LOCAL; then
        cd $ALFRED_CLIENT_LOCAL/src/environments
        regexFile '"oauth"\s*:\s*' '"http://'$NEO_OAUTH_URL'",' environment.integration.ts
        if verifyContainerStarted $ALFRED_CLIENT_CONTAINER && [ $1 == 'restart' ] 2> /dev/null ; then
            restartContainer $ALFRED_CLIENT_CONTAINER
        fi
    fi

}


alfred_client() {

    cd $1

    npmInstall $1
    bowerInstall $1/src/assets

    msgConfig "Copiando arquivo de environment: "
    update_environment

    include_callcenter_alfredclient
    include_bpm_alfredclient
    include_oauth_alfredclient

    dockerComposeUp $ALFRED_CLIENT_CONTAINER 'neo'

    configHost $ALFRED_CLIENT_CONTAINER $ALFRED_CLIENT_URL



    chmod 777 -R $1

    msgGeneral "\nAguarde cerca de 40 segundos para que o Alfred Client funcione..." "verde" "reverso"
    msgGeneral "\nnpm serve sendo executado...\n" "branco" "reverso"

    sleep 40

    logContainer $ALFRED_CLIENT_CONTAINER





}

