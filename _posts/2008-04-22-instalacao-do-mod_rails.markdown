---
layout: post
comments: true
title: "Instalação do mod_rails"
date: 2008-04-22
categories: [Rails, Phusion Passenger, Apache, deploy]
---
Recentemente foi lançado o Phusion Passenger, mais conhecido como [mod\_rails](http://www.modrails.com). Trata-se de um módulo Apache para Rails que promete oferecer configuração e deploy de aplicações mais simplificado do que com o Mongrel, além de ser mais estável e utilizar menos memória.

Tentei instalar o mod\_rails e encontrei várias dificuldades. Inicialmente tentei instalar no CentOS 4.4, mas não consegui. Encontrei alguns conflitos de versões de pacotes (pré-requisitos do mod\_rails), e ainda não consegui concluir a instalação.

Em seguida, tentei instalar no Ubuntu 7.10. As dificuldades foram menores, mas ainda assim não foi tão simples quanto parece pelo [guia do usuário](http://www.modrails.com/documentation/Users%20guide.html). Segue o passo-a-passo da instalação:

- Instalar os pré-requisitos:

    ```bash
    sudo apt-get install apache2-mpm-prefork apache2-prefork-dev libapr1-dev
    ```

- Instalar a gem do mod\_rails:

    ```bash
    sudo gem install passenger
    ```

- Definir as seguintes variáveis de ambiente:

    ```bash
    export HTTPD=/path/to/httpd
    export APXS=/path/to/apxs (ou apxs2)
    ```

- Executar o script de instalação do módulo Apache:

    ```bash
    sudo /usr/lib/ruby/gems/1.8/gems/passenger-1.0.1/bin/passenger-install-apache2-module
    ```

- Habilitar o mod\_rails no arquivo `httpd.conf` do Apache, adicionando as linhas a seguir:

    ```apache
    LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-1.0.1/ext/apache2/mod_passenger.so
    RailsSpawnServer /usr/lib/ruby/gems/1.8/gems/passenger-1.0.1/bin/passenger-spawn-server
    RailsRuby /usr/bin/ruby1.8
    RailsEnv PROD
    ```

A última linha acima define o ambiente Rails que será utilizado. Se você omitir esta linha, será usado o ambiente padrão (production).

- Criar um virtual host no Apache:

    ```apache
    <virtualHost *:80>
      ServerName localhost
      DocumentRoot /var/www/rails/public
    </virtualHost>
    ```

Na configuração acima, `DocumentRoot` é o diretório public da sua aplicação Rails.

Ao concluir estas configurações e reiniciar o Apache, minha aplicação funcionou, porém os arquivos que estão no diretório `public` (arquivos javascript, CSS e imagens) não estavam acessíveis. Para resolver este problema:

- habilite o mod\_rewrite
- adicione à configuração do virtual host:

    ```apache
    <directory "/var/www/rails/public">
        Options         FollowSymLinks
        AllowOverride   All
    </directory>
    ```

- reinicie o Apache

Assim, finalmente consegui fazer a aplicação funcionar corretamente. Ainda não fiz nenhum benchmark comparando o mod\_rails com o Mongrel, mas todos os que encontrei até agora são favoráveis ao mod\_rails, como estes:

- [Benchmarking mod\_rails against mongrel](http://s2.diffuse.it/blog/show/53_Benchmarking+mod_rails+against+mongrel)
- [Phusion Passenger (mod\_rails) Test-Drive](http://www.akitaonrails.com/2008/4/16/phusion-passenger-mod_rails-test-drive)
