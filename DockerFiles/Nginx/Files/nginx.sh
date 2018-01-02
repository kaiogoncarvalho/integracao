#!/usr/bin/env bash


server()
{
    SERVER="
        \n server {
        \n\t listen 80;
        \n\n\t server_name  $1;
        \n\n\t location / {
        \n\t\t proxy_pass http://$2/;
        \n\t\t proxy_http_version 1.1;
        \n\t\t proxy_set_header Upgrade \$http_upgrade;
        \n\t\t proxy_set_header Connection 'upgrade';
        \n\t\t proxy_set_header Host \$host;
        \n\t\t proxy_set_header X-Real-IP  \$remote_addr;
        \n\t\t proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        \n\t\t proxy_cache_bypass \$http_upgrade;
        \n\t }
        \n }";
    echo $SERVER >> default.conf
}

setup_nginx()
{
    cd $INTEGRACAO_DIR/$NGINX_DIR
    cp default.example.conf default.conf
    chmod 777 default.conf
    server $BACKOFFICE_URL backoffice
    server $BACKOFFICE_API_URL backoffice
    server $PORTALPRAVALER_URL portal_pravaler
    server $APIAPROVACAO_URL api_aprovacao
    server $APIAPARTADA_URL api_apartada
    server $CREDITSCORE_URL creditscore
    server $AGENDAMENTO_URL agendamento
}


