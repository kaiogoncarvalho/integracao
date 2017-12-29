#!/usr/bin/env bash

BACKOFFICE=$(grep -E "BACKOFFICE_URL=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_URL=*//p' ../../../.env)
BACKOFFICE_API=$(grep -E "BACKOFFICE_API_URL=(.*)" ../../../.env | sed -n 's/^BACKOFFICE_API_URL=*//p' ../../../.env)
PORTALPRAVALER=$(grep -E "PORTALPRAVALER_URL=(.*)" ../../../.env | sed -n 's/^PORTALPRAVALER_URL=*//p' ../../../.env)
APIAPROVACAO=$(grep -E "APIAPROVACAO_URL=(.*)" ../../../.env | sed -n 's/^APIAPROVACAO_URL=*//p' ../../../.env)
APIAPARTADA=$(grep -E "APIAPARTADA_URL=(.*)" ../../../.env | sed -n 's/^APIAPARTADA_URL=*//p' ../../../.env)
CREDITSCORE=$(grep -E "CREDITSCORE_URL=(.*)" ../../../.env | sed -n 's/^CREDITSCORE_URL=*//p' ../../../.env)

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

cp default.example.conf default.conf
server $BACKOFFICE backoffice
server $BACKOFFICE_API backoffice
server $PORTALPRAVALER portal_pravaler
server $APIAPROVACAO api_aprovacao
server $APIAPARTADA api_apartada
server $CREDITSCORE creditscore

