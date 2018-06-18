#!/usr/bin/env bash

create_user_folder(){
    useradd alfred-client
    usermod -aG alfred-client alfred-client
    mkdir -p /var/www/html/alfred-client
    chmod -R 777 /var/www/html/alfred-client
    chmod +x /usr/local/script.sh
}

create_user_folder