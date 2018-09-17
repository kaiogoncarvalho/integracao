FROM nginx:latest
MAINTAINER Kaio Gonçalves Carvalho
COPY DockerFiles/Nginx/Files/default.conf /etc/nginx/conf.d/default.conf
COPY DockerFiles/Nginx/Files/nginx.conf /etc/nginx/nginx.conf
COPY Dockerfiles/Agendamento/ssl /etc/ssl
CMD ["nginx", "-g", "daemon off;"]