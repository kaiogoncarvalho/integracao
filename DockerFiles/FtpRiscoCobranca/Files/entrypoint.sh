#!/usr/bin/env bash

create_user() {
    ( echo $2 ; echo $2 ) | pure-pw useradd $1 -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u ftpuser -d /home/ftpusers/$1
}

create_user $FTPRISCOCOBRANCA_BOLETOAVULSO_USER $FTPRISCOCOBRANCA_BOLETOAVULSO_PASSWORD
create_user $FTPRISCOCOBRANCA_IMPORTACAO_USER $FTPRISCOCOBRANCA_IMPORTACAO_PASSWORD

/run.sh -c 30 -C 10 -l puredb:/etc/pure-ftpd/pureftpd.pdb -E -j -R -P localhost -p 30000:30009 -s -A -j -Z -H -4 -E -R -G -X -x