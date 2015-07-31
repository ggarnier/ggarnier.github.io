---
layout: post
comments: true
title: "Acessando múltiplos bancos de dados em Rails"
date: 2008-03-11
tags: [Rails, Ruby, Active Record]
---
Esta semana me deparei com uma situação no projeto em Rails em que estou trabalhando, onde necessitei acessar um banco de dados de outra aplicação, para fazer algumas consultas simples. Eu poderia simplesmente fazer a conexão com o banco e as querys em SQL. Porém, eu obviamente queria aproveitar as facilidades que o Rails proporciona ao abstrair estes detalhes com a classe `ActiveRecord::Base`.

Quando criamos um novo model em Rails, a nova classe criada, derivada de `ActiveRecord::Base`, é mapeada por padrão em uma tabela no banco de dados da aplicação - o Rails assume o nome da classe no plural, mas permite que você especifique um nome diferente. Na migration que também é criada automaticamente, a tabela correspondente é definida. Porém, neste caso, eu não queria criar uma tabela, pois ela já existe. Além disso, é um servidor de banco de dados diferente, com usuário e senha diferentes.

Após alguma pesquisa, descobri como resolver este problema. Suponha que você queira acessar uma base de usuários para compartilhar login e senha:

1. especificar a nova conexão no arquivo `config/database.yml`. No exemplo abaixo, defini o nome `autenticacao_development`, supondo que tenhamos outras conexões para teste e produção:

```ruby
autenticacao_development:
  adapter: mysql
  host: autenticacao_dev
  username: login
  password: senha
  database: autenticacao
```

2. criar uma classe abstrata (model), derivada de `ActionRecord::Base`, e usar o método `establish_connection` para referenciar a conexão. O parâmetro `autenticacao_#{RAILS_ENV}` usa a variável `RAILS_ENV` para especificar a conexão relativa ao ambiente (`autenticacao_development`, `autenticacao_test` ou `autenticacao_production`):

```ruby
class AutenticacaoDatabase < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "autenticacao_#{RAILS_ENV}"
end
```

3. para cada tabela deste banco de dados que será acessada, criar uma nova classe (model) derivada da classe `AutenticacaoDatabase` recém-criada. Caso o nome da tabela seja diferente do padrão (o nome da classe no plural), use o método `set_table_name` para especificar o nome correto. E se a primary key não for `id`, use `set_primary_key` para definir o nome correto deste campo.

```ruby
class Usuario < AutenticacaoDatabase
  set_table_name 'usuario_tb'
  set_primary_key 'usuario_id'
end
```

Feitas as configurações acima, o banco de dados externo ficará acessível como o da aplicação, com todos os métodos usados normalmente. Por exemplo:

```ruby
Usuario.find(:all)
Usuario.find_by_usuario_id(1)
Usuario.create
```

Detalhe importante: com esta configuração, é necessário fazer uma série de alterações nos unit tests para que estes funcionem. Em breve farei outro post detalhando estes passos.

Seguem abaixo os links que eu usei como base:

- <http://wiki.rubyonrails.org/rails/pages/HowtoUseMultipleDatabases> (seção "Accessing Multiple Databases")

- <http://api.rubyonrails.org/classes/ActiveRecord/Base.html> (seção "Connection to multiple databases in different models")
