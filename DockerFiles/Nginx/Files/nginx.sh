#!/usr/bin/env bash


server()
{
    if isValidRepository $1; then
        SERVER="
            \n server {
            \n\t listen 80;
            \n\n\t server_name  $2;
            \n\n\t location / {
            \n\t\t proxy_pass http://$3/;
            \n\t\t proxy_http_version 1.1;
            \n\t\t proxy_set_header Upgrade \$http_upgrade;
            \n\t\t proxy_set_header Connection 'upgrade';
            \n\t\t proxy_set_header Host \$host;
            \n\t\t proxy_set_header X-Real-IP  \$remote_addr;
            \n\t\t proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            \n\t\t proxy_cache_bypass \$http_upgrade;
            \n\t }
            \n }

            \n server {
            \n\t listen 9000;
            \n\n\t server_name  $2;
            \n\n\t location / {
            \n\t\t proxy_pass http://$3:9000/;
            \n\t\t proxy_http_version 1.1;
            \n\t\t proxy_set_header Upgrade \$http_upgrade;
            \n\t\t proxy_set_header Connection 'upgrade';
            \n\t\t proxy_set_header Host \$host;
            \n\t\t proxy_set_header X-Real-IP  \$remote_addr;
            \n\t\t proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            \n\t\t proxy_cache_bypass \$http_upgrade;
            \n\t }
            \n }

            ";
        echo -e $SERVER >> default.conf
    fi
}

setup_nginx()
{

    msgConfig "Criando o arquivo de configução do nginx: "
    cd $INTEGRACAO_DIR/$NGINX_DIR
    cp default.example.conf default.conf
    chmod 777 default.conf
    server $BACKOFFICE_LOCAL $BACKOFFICE_URL backoffice
    server $BACKOFFICE_LOCAL $BACKOFFICE_API_URL backoffice
    server $PORTALPRAVALER_LOCAL $PORTALPRAVALER_URL portal_pravaler
    server $APIPRAVALER_LOCAL $APIPRAVALER_URL api_pravaler
    server $APIAPARTADA_LOCAL $APIAPARTADA_URL api_apartada
    server $CREDITSCORE_LOCAL $CREDITSCORE_URL creditscore
    server $CDN_LOCAL $CDN_URL cdn
    server $NOVAPROPOSTA_BACKEND_LOCAL $NOVAPROPOSTA_BACKEND_URL nova_proposta_backend
    server $NOVAPROPOSTA_FRONTEND_LOCAL $NOVAPROPOSTA_FRONTEND_URL nova_proposta_frontend
    server $AGENDAMENTO_LOCAL $AGENDAMENTO_URL agendamento
    server $SEGUROS_LOCAL $SEGUROS_URL seguros
    server $RETORNO_MEC_LOCAL $RETORNO_MEC_URL retorno_mec
    server $MARKETPLACE_API_LOCAL $MARKETPLACE_API_URL marketplace
    dockerComposeUp 'nginx'
}


