FROM nginx:latest
MAINTAINER Kaio Gonçalves Carvalho
COPY DockerFiles/Nginx/Files/default.conf /etc/nginx/conf.d/default.conf
COPY DockerFiles/Nginx/Files/nginx.conf /etc/nginx/nginx.conf
COPY DockerFiles/Agendamento/Files/ssl/phpit.crt /etc/ssl
COPY DockerFiles/Agendamento/Files/ssl/phpit.key /etc/ssl
COPY DockerFiles/Agendamento/Files/ssl/phpit.pem /etc/ssl
CMD ["nginx", "-g", "daemon off;"]