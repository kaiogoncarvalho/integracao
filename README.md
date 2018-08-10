# Integração de todos os Sistemas

Criar o ambiente de todos os Sistemas de uma vez

### ***Pré-requisitos:

1. Ter o Docker instalado:
    * `sudo apt-get install docker.io`
    * `sudo groupadd docker`
    * `sudo gpasswd -a $(whoami) docker`
2. Ter Docker-Compose instalado;
    * sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-\`uname -s\`-\`uname -m` -o /usr/bin/docker-compose
    * sudo chmod +x /usr/bin/docker-compose
3. Ter Acesso o repositório do projeto que vai ser instalado;


# Usage

1. Fazer o clone deste repositório:
    * **Observação:** Caso queira deixar usuario e senha pré-definido, 
    usar o seguinte comando:
         * `git clone http://[usuario]:[senha]@10.10.100.75/ambientes/integracao.git`
         * Se a senha ou usuario tiver caracteres especiais, 
         procurar o código do caractere, 
         por exemplo para o caractere **@** usa-se **%40**
    * Caso não queira, usar esse comando:     
        * `git clone http://10.10.100.75/ambientes/integracao.git`

       
## Instalar Integração
1. Acessar o diretório do repositório do Integração:
2. Instalar Integração:
    * `sudo bash install.sh` 
    * **Importante: Ser executado em sudo**     

## Usar Integração   
1. Em qualquer diretório, executar o seguinte comando:
    * `sudo integracao` 
    * **Importante: Ser executado em sudo** 
2. Escolher as opções desejadas de acordo com o que for instalar;     
        
## Testar os sistemas
1. Para testar é necessário acessar a seguinte URL:
    * **Ambientes** 
        * **Backoffice:** http://backoffice.desenv/portal/pravaler   
        * **Agendamento de Homologação:** http://agendamento.pravaler.desenv
        * **API Apartada:** http://api.apartada.desenv/portal/pravaler_v2/api/
        * **API Pravaler:** http://api.pravaler.desenv        
        * **CDN:** http://cdn.portalpravaler.desenv
        * **CreditScore:** http://creditscore.desenv
        * **FTP Risco e Cobrança:** http://ftp.risco-cobranca.desenv
        * **MarketPlace:** http://marketplace.desenv         
        * **Portal Pravaler:** http://portalpravaler.desenv        
        * **Nova Proposta Backend:** http://cadastro.creditouniversitario.desenv
        * **Nova Proposta Frontend:** http://cadastro.portalpravaler.desenv        
        * **Seguros:** http://seguros.idealinvest.desenv     
    * **Ambientes Neo** 
        * **Alfred Client:** http://lo.atendimento.pravaler.com.br
        * **Alfred Server:** http://lo.callcenter.pravaler.srv.br
        * **BPM:** http://lo.bpm.pravaler.srv.br
        * **Integration:** http://lo.integration.pravaler.srv.br
        * **Log:** http://lo.log.pravaler.srv.br
        * **Negotiation:** http://lo.negotiation.pravaler.srv.br
        * **Neo Api:** http://lo.api.pravaler.srv.br
        * **Oauth:** http://lo.oauth.pravaler.srv.br
        * **People:** http://lo.people.pravaler.srv.br           
        * **Proposal:** http://lo.proposal.pravaler.srv.br
        * **Retorno Mec:** http://lo.retornomec.pravaler.srv.br        
        * **Student:** http://lo.student.pravaler.srv.br                
    
# Opcional: Instalar o Xdebug
1. Para instalar o xdebug no **PHPSTORM**, use o seguinte passo a passo:
    * https://slimwiki.com/ideal-invest/instalar-o-xdebug-no-phpstorm
2. Para instalar o xdebug no **NETBEANS**, use o seguinte passo a passo:
    * https://slimwiki.com/ideal-invest/instalar-o-xdebug-no-netbeans-com-docker