FROM node:9
MAINTAINER Kaio Gonçalves Carvalho

COPY DockerFiles/NovaPropostaFrontEnd/Files/npm.sh /scripts/npm.sh

RUN chmod +x /scripts/npm.sh

WORKDIR /home/httpd/html/NovaPropostaFrontEnd


CMD ["/scripts/npm.sh"]
