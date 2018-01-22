# Integração de todos os Sistemas para Servidor

Criar o ambiente de todos os Sistemas de uma vez

### ***Pré-requisitos:
1. Ter o composer instalado e as dependências necessárias;
2. Ter o Docker instalado;
3. Ter Acesso a um dos repositórios abaixo:
    * **Observação: Somente os repositórios que tem acesso irão funcionar, mas não é necessário ter acesso a todos, se tiver acesso a somente um já é o suficiente.**
    * Backoffice: http://10.10.100.75/ideal-invest/BO-PRV
    * Portal Pravaler **(Portal Pravaler necessita do Backoffice)**: http://10.10.100.75/portalpravaler/portalpravaler.git 
    * API de Aprovação: http://10.10.100.75/pravaler/api-pravaler.git
    * API Apartada: http://10.10.100.75/ideal-invest/BO-PRV-API.git
    * CreditScore: http://10.10.100.75/bsy.jhones/credit-score.git

# Usage

1. Fazer o clone deste repositório:
    * **Observação:** Caso queira deixar usuario e senha pré-definido, 
    usar o seguinte comando:
         * `git clone http://[usuario]:[senha]@10.10.100.75/ambientes/servidor.git`
         * Se a senha ou usuario tiver caracteres especiais, 
         procurar o código do caractere, 
         por exemplo para o caractere **@** usa-se **%40**
    * Caso não queira, usar esse comando:     
        * `git clone http://10.10.100.75/ambientes/servidor.git`
2. Criar o ENV
    * Acessar a pasta deste repositório 
    * Copiar example.env para .env
        * `sudo cp example.env .env`
3. Incluir os novos hosts no arquivo hosts:
    * Abrir o hosts com algum editor (no exemplo é o vi):
        * `sudo vi /etc/hosts`
    * Incluir as seguintes linhas:
        * `127.0.0.1 [HOST BACKOFFICE] [HOST API BACKOFFICE]`
        * `127.0.0.1 [HOST PORTAL PRAVALER]`
        * `127.0.0.1 [HOST API APROVACAO]`
        * `127.0.0.1 [HOST API APARTADA]`
        * `127.0.0.1 [HOST CREDITSCORE]`
        * `127.0.0.1 [HOST AGENDAMENTO]`

## Backoffice
1. Fazer o clone do repositório do Backoffice:
    * **Observação:** Caso queira deixar usuario e senha pré-definido, 
    usar o seguinte comando:
         * `git clone http://[usuario]:[senha]@10.10.100.75/ideal-invest/BO-PRV Backoffice`
         * Se a senha ou usuario tiver caracteres especiais, 
         procurar o código do caractere, 
         por exemplo para o caractere **@** usa-se **%40**
    * Caso não queira, usar esse comando:     
        * `git clone http://10.10.100.75/ideal-invest/BO-PRV Backoffice`
2. Alterar o caminho do Backoffice dentro do ENV
    * Acessar o .env do repositório do Servidor
    * Altera a propriedade BACKOFFICE_LOCAL para o caminho do repositório do Backoffice
3. Executar script de configuração do Backoffice:
    * Acessar a pasta do script `[Diretório do Repositório da Integração]/DockerFiles/Backoffice/Files`;
    * Executar o script de configuração do Backoffice:
        * `sudo sh backoffice.sh`
        
        
## Portal Pravaler
1. Fazer o clone do repositório do Portal Pravaler:
    * **Observação:** Caso queira deixar usuario e senha pré-definido, 
    usar o seguinte comando:
         * `git clone http://[usuario]:[senha]@10.10.100.75/portalpravaler/portalpravaler.git`
         * Se a senha ou usuario tiver caracteres especiais, 
         procurar o código do caractere, 
         por exemplo para o caractere **@** usa-se **%40**
    * Caso não queira, usar esse comando:     
        * `git clone http://10.10.100.75/portalpravaler/portalpravaler.git`
2. Alterar o caminho do Portal Pravaler dentro do ENV
    * Acessar o .env do repositório do Servidor
    * Altera a propriedade PORTALPRAVALER_LOCAL para o caminho do repositório do Portal Pravaler        
3. Executar script de configuração do Portal Pravaler:
    * Acessar a pasta do script `[Diretório do Repositório da Integração]/DockerFiles/PortalPravaler/Files`;
    * Executar o script de configuração do Portal Pravaler:
        * `sudo sh portalpravaler.sh`     
        
        
## API de Aprovação
1. Fazer o clone do repositório da Api de Aprovação:
    * **Observação:** Caso queira deixar usuario e senha pré-definido, 
    usar o seguinte comando:
         * `git clone http://[usuario]:[senha]@10.10.100.75/pravaler/api-pravaler.git`
         * Se a senha ou usuario tiver caracteres especiais, 
         procurar o código do caractere, 
         por exemplo para o caractere **@** usa-se **%40**
    * Caso não queira, usar esse comando:     
        * `git clone http://10.10.100.75/pravaler/api-pravaler.git`
2. Alterar o caminho da Api de Aprovação dentro do ENV
    * Acessar o .env do repositório do Servidor
    * Altera a propriedade APIPRAVALER_LOCAL para o caminho do repositório da Api da Aprovação         
3. Executar script de configuração da Api de Aprovação:
    * Acessar a pasta do script `[Diretório do Repositório da Integração]/DockerFiles/ApiAprovacao/Files`;
    * Executar o script de configuração da Api de Aprovação:
        * `sudo sh api_aprovacao.sh`  
        
        
## Api Apartada
1. Fazer o clone do repositório da API Apartada:
    * **Observação:** Caso queira deixar usuario e senha pré-definido, 
    usar o seguinte comando:
         * `git clone http://[usuario]:[senha]@10.10.100.75/ideal-invest/BO-PRV-API.git`
         * Se a senha ou usuario tiver caracteres especiais, 
         procurar o código do caractere, 
         por exemplo para o caractere **@** usa-se **%40**
    * Caso não queira, usar esse comando:     
        * `git clone http://10.10.100.75/ideal-invest/BO-PRV-API.git`
2. Alterar o caminho da Api Apartada dentro do ENV
    * Acessar o .env do repositório do Servidor
    * Altera a propriedade APIAPARTADA_LOCAL para o caminho do repositório da Api Apartada            
3. Executar script de configuração da API Apartada:
    * Acessar a pasta do script `[Diretório do Repositório da Integração]/DockerFiles/ApiApartada/Files`;
    * Executar o script de configuração da API Apartada:
        * `sudo sh api_apartada.sh`          

## CreditScore
1. Fazer o clone do repositório do CreditScore:
    * **Observação:** Caso queira deixar usuario e senha pré-definido, 
    usar o seguinte comando:
         * `git clone http://[usuario]:[senha]@10.10.100.75/bsy.jhones/credit-score.git`
         * Se a senha ou usuario tiver caracteres especiais, 
         procurar o código do caractere, 
         por exemplo para o caractere **@** usa-se **%40**
    * Caso não queira, usar esse comando:     
        * `git clone http://10.10.100.75/bsy.jhones/credit-score.git`
2. Alterar o caminho do CreditScore dentro do ENV
    * Acessar o .env do repositório do Servidor
    * Altera a propriedade CREDITSCORE_LOCAL para o caminho do repositório do CreditScore           
3. Executar script de configuração do CreditScore:
    * Acessar a pasta do script `[Diretório do Repositório da Integração]/DockerFiles/CreditScore/Files`;
    * Executar o script de configuração do CreditScore:
        * `sudo sh creditscore.sh`  
        
        
## Integração
1. Acessar a pasta do repositório da Integração:
2. Executar o docker-compose:
    * Criar as imagens e serviços
        * `docker-compose build`
    * Subir os containers:
        * `docker-compose up -d`
3. Agora somente é necessário subir os containers quando necessário:
    * Acessar a pasta do repositório da Integração;
    * Subir os containers:
        * `docker-compose up -d`
    * **Opcional**:
        * Caso Queira subir somente o Backoffice:
            * `docker-compose up -d backoffice`
        * Caso Queira subir somente o Portal Pravaler + Backoffice:
            * `docker-compose up -d portalpravaler`
        * Caso Queira subir somente o API de Aprovação:
            * `docker-compose up -d api_aprovacao    
        * Caso Queira subir somente o API Apartada:
            * `docker-compose up -d api_apartada`
        * Caso Queira subir somente o CreditScore:
            * `docker-compose up -d creditscore`    
        
        
## Testar os sistemas
1. Para testar é necessário acessar a seguinte URL:
    * **Backoffice:** [HOST DO BACKOFFICE]
    * **Portal Pravaler:** [HOST DO PORTALPRAVALER]
    * **API de Aprovação:** [HOST DA API DE APROVAÇÃO]
    * **API Apartada:** [HOST DA API APARTADA]
    * **CreditScore:** [HOST DO CREDITSCORE]