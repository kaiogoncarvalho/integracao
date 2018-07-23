#!/usr/bin/env bash

setup_ftp_risco_cobranca() {

    dockerComposeUp $FTPRISCOCOBRANCA_CONTAINER

    configHost $FTPRISCOCOBRANCA_CONTAINER $FTPRISCOCOBRANCA_URL

}
