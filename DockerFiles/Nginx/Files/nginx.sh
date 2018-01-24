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

            \n\n upstream $3_xdebug {
            \n\t server http://$4:9000;
            \n}\n\n

            \n server {
            \n\t listen 9000;
            \n\n\t server_name  $2;
            \n\n\t location / {
            \n\t\t proxy_pass http://$3_xdebug/;
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

    echo -e "\n\tCriando o arquivo de configução do nginx:\n"
    cd $INTEGRACAO_DIR/$NGINX_DIR
    cp default.example.conf default.conf
    chmod 777 default.conf
    server $BACKOFFICE_LOCAL $BACKOFFICE_URL backoffice $BACKOFFICE_IP
    server $BACKOFFICE_LOCAL $BACKOFFICE_API_URL backoffice $BACKOFFICE_IP
    server $PORTALPRAVALER_LOCAL $PORTALPRAVALER_URL portal_pravaler $BACKOFFICE_IP
    server $APIPRAVALER_LOCAL $APIPRAVALER_URL api_pravaler $BACKOFFICE_IP
    server $APIAPARTADA_LOCAL $APIAPARTADA_URL api_apartada $BACKOFFICE_IP
    server $CREDITSCORE_LOCAL $CREDITSCORE_URL creditscore $BACKOFFICE_IP
    server $AGENDAMENTO_LOCAL $AGENDAMENTO_URL agendamento $BACKOFFICE_IP

    dockerComposeUp 'nginx'
}


