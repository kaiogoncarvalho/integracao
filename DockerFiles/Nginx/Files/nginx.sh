#!/usr/bin/env bash


server()
{
    URL=$(getEnv "$1_URL")
    CONTAINER=$(getEnv "$1_CONTAINER")

    if isValidInstall $1 && verifyContainerStarted $CONTAINER; then
        SERVER="
            \n server {
            \n\t listen 80;
            \n\n\t server_name $URL;
            \n\n\t location / {
            \n\t\t proxy_pass http://$URL/;
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
            \n\n\t server_name $URL;
            \n\n\t location / {
            \n\t\t proxy_pass http://$URL:9000/;
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
            \n\t listen 443 ssl;
            \n\t ssl_certificate /etc/ssl/phpit.pem;
            \n\t ssl_certificate_key /etc/ssl/phpit.key;
            \n\t server_name $URL;
            \n\t return 301 http://\$host\$request_uri;
            \n}

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
    SISTEMS=$(getSystems)
    for i in $SISTEMS
    do server $i
    done
    dockerComposeUp 'nginx'
    if validFile $NEO_CONFIG;then
        sed -i -E "s/(define[(]'ENVIRONMENT'[ ]*,[ ]*?')(.*?)(')/\1$NAME_SERVER\3/g" $NEO_CONFIG
    fi

}


