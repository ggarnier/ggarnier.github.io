---
layout: post
comments: true
title: "Usando DRY no database.yml"
date: 2008-02-15
categories: [Rails, Ruby, DRY]
---
Um dos princípios do desenvolvimento em Rails é o DRY (don't repeat yourself). A idéia é que você nunca repita o código que já escreveu uma vez, procurando reaproveitar sempre que possível.

No caso das views, por exemplo, isso é bem simples de implementar, através do uso de partials. Você deve criar um arquivo de view começando com "\_" (ex: _\_item.rhtml_) e usar o comando render em outra view para carregar o partial dentro do layout (ex: _render :partial => 'item'_).

Outro dia descobri uma maneira muito interessante de usar essa técnica no arquivo _database.yml_. Esse arquivo mantém as configurações de banco de dados para cada um dos ambientes - _development_, _test_ e _production_. Porém, geralmente alguns destes parâmetros de configuração são iguais. O adapter, por exemplo, muito provavelmente é o mesmo; o username, senha e host também podem se repetir.

Segue abaixo um exemplo de como definir estas configurações sem repetições:

{% highlight ruby %}
login: &login
  adapter: mysql
  username: username
  password: password
  host: mysql.example.com

development:
  <<: *login
  database: app_dev

test:
  <<: *login
  database: app_test

production:
  <<: *login
  database: app_prod
{% endhighlight  %}

Só encontrei um problema: se você usar o [Aptana RadRails](http://www.aptana.com/rails/) para desenvolver, usando essa técnica, o modo "Data perspective", que permite analisar a estrutura do banco de dados e executar querys, retorna uma mensagem de erro ("Invalid YML syntax"). Fora isso, está tudo funcionando bem. No [NetBeans](http://www.netbeans.org/) não há este problema.
