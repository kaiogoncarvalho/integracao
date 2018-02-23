#!/usr/bin/env bash

create_user_folder(){
    useradd proposta
    usermod -aG proposta proposta
    mkdir -p /var/www/html/proposta
    chmod -R 777 /var/www/html/proposta
    chmod +x /usr/local/script.sh
}

create_user_folder