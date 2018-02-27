#!/usr/bin/env bash

setup_ftp_risco_cobranca() {

    dockerComposeUp 'ftp-risco-cobranca'

    configHost $FTPRISCOCOBRANCA_IP $FTPRISCOCOBRANCA_URL

}
