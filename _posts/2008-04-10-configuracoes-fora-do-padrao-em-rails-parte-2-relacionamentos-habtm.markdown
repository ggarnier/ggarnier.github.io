---
layout: post
comments: true
title: "Configurações fora do padrão em Rails, parte 2 - Relacionamentos HABTM"
date: 2008-04-10
categories: [Rails, Ruby, Active Record, testes]
---
Há um mês escrevi um post sobre [configurações fora do padrão em Rails](http://blog.guilhermegarnier.com/2008/03/18/configuracoes-fora-do-padrao-em-rails/), onde descrevi como executar testes com models cujas tabelas não existem no banco de dados local, e sim em uma base externa. Porém, depois de postar, verifiquei que há um outro problema não resolvido com a configuração que descrevi nesse post: relacionamentos HABTM (has and belongs to many).

Nos relacionamentos HABTM, normalmente, há dois models, um correspondente a cada tabela do banco de dados. Como a relação entre eles é de muitos para muitos, há uma terceira tabela no banco de dados, que é responsável pela associação das demais tabelas. Como essa tabela só costuma ter dois campos, que são FK's correspondentes às PK's dessas tabelas, ela não precisa ter um model; basta criar o relacionamento dos dois models como has_and_belongs_to_many, passando como parâmetro join_table essa tabela intermediária.

A configuração descrita no [post anterior](http://blog.guilhermegarnier.com/2008/03/18/configuracoes-fora-do-padrao-em-rails/) carrega manualmente os fixtures de cada model, porém não carrega fixtures correspondentes à tabela intermediária. Para isso, precisei implementar um novo método na classe Test::Unit::TestCase (arquivo test/test_helper.rb):

```ruby
def set_habtm_fixtures(class1, class2)
  return unless (class1.reflections && class1.reflections.values)
  id1 = nil
  id2 = nil
  table = nil

  # Verifica qual dos relacionamentos do model class1 está associado à tabela class2
  class1.reflections.values.each do |r|
    # Se a classe associada for class2 e for uma relação HABTM, le os FK's e o nome da tabela
    if (r.klass == class2 && !r.instance_values['options'][:join_table].nil?)
      id1 = r.primary_key_name
      id2 = r.association_foreign_key
      table = r.instance_values['options'][:join_table]
      break
    end
  end
  return if table.nil?
  connection = class1.connection

  data = File.open(File.join(RAILS_ROOT, 'test', 'fixtures', "#{table}.yml")).readlines.join
  result = ERB.new(data).result
  parsed = YAML.load(result)

  # Exclui todos os registros da tabela
  connection.execute "DELETE FROM #{table}"

  parsed.values.each do |value|
    value1 = value[id1] || 'NULL'
    value2 = value[id2] || 'NULL'
    connection.execute "INSERT INTO #{table} (#{id1}, #{id2}) values (#{value1}, #{value2})"
  end
end
```

Este método ficou bem "feio", pois, como não existe um model correspondente a esta tabela, precisei criar a query manualmente. O método recebe dois nomes de classes (ActiveRecord) como parâmetro. Primeiramente é verificado qual dos relacionamentos do model class1 está associado a class2, para descobrir quais são as FK's e o nome da tabela. Em seguida, os registros desta tabela são excluídos, e cada linha do arquivo de fixtures é carregada (usando a conexão de um dos ActiveRecords).

Além disso, modifiquei o método set_fixtures desta mesma classe, criado no [post anterior](http://blog.guilhermegarnier.com/2008/03/18/configuracoes-fora-do-padrao-em-rails/), pois percebi que não era necessário passar o nome da tabela como parâmetro, basta usar o método table_name:

```ruby
def set_fixtures (class_name)
  table = class_name.table_name
  return unless class_name.kind_of?(ActiveRecord::Base)

  # Define a conexao usada pela classe
  ActiveRecord::Base.connection = base.connection
  Fixtures.create_fixtures(File.join(RAILS_ROOT, 'test', 'fixtures'), table) { base.connection }
end
```

Para exemplificar como usar estes métodos, imagine um cadastro de usuários com grupos, onde um usuário pode fazer parte de mais de um grupo. Neste exemplo, teríamos um model Usuario (tabela usuarios), um model Grupo (tabela grupos) e uma tabela usuarios_grupos, sem um model correspondente. Na classe de teste do model Usuario, teríamos o seguinte:

```ruby
class UsuarioTest < ActiveSupport::TestCase
  def setup
    set_fixtures(Usuario)
    set_fixtures(Grupo)
    set_habtm_fixtures(Usuario, Grupo)
  end

  # Testes
end
```

No método setup, que é executado automaticamente quando os testes são executados, as duas chamadas a set_fixtures carregam as fixtures das tabelas de usuários e grupos, respectivamente; a chamada a set_habtm_fixtures atualiza a tabela usuarios_grupos.
