#!/usr/bin/env bash

setup_ftp_risco_cobranca() {

    dockerComposeUp 'ftp-risco-cobranca'

    configHost 'ftp-risco-cobranca' $FTPRISCOCOBRANCA_URL

}
