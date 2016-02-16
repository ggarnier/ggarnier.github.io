---
layout: post
comments: true
title: "Configurações fora do padrão em Rails"
date: 2008-03-18
tags: [Rails, Ruby, Active Record, tests, portuguese]
---
O framework Rails é excelente na tarefa de automatizar o máximo possível o desenvolvimento de aplicações web. Todos os detalhes que podem ser implementados automaticamente são abstraídos do desenvolvedor, facilitando e agilizando muito o trabalho.

Porém, toda essa automatização e abstração de detalhes internos tem um custo, que é a padronização. Por exemplo, ao usar o script `generate` para criar um model, o Rails cria uma classe derivada de `ActiveRecord::Base`. Os nomes do arquivo, da classe e da tabela são automaticamente gerados a partir do parâmetro passado. Ex:

```bash
ruby script/generate model tipo_usuario
```

Arquivo: `tipo_usuario.rb`

Classe: `TipoUsuario`

Tabela: `tipo_usuarios`

Neste caso, a partir do parâmetro passado para o script, o nome do arquivo é o próprio parâmetro com ".rb" no final, o nome da classe é gerado retirando-se os "\_" e colocando a primeira letra de cada palavra em maiúscula, e o nome da tabela é o plural - que pode ser redefinido no arquivo `config/initializers/inflections.rb`:

```ruby
Inflector.inflections do |inflect|
  inflect.irregular 'tipo_usuario', 'tipos_usuario'
end
```

Com a configuração acima, o nome da tabela será `tipos_usuario` - desde que esta configuração seja realizada antes do generate!

O principal problema que esta padronização traz é que nem sempre queremos/podemos seguir o padrão de configuração gerado pelo Rails. Na maioria das situações, é possível definir explicitamente quando se quer usar uma configuração diferente, como no caso do plural da tabela acima. O nome da tabela associado a um model também pode ser alterado, através do método `set_table_name`. Desta forma, o Rails não amarra totalmente o desenvolvedor aos seus padrões.

Porém, apesar da flexibilidade, essas configurações fora dos padrões nem sempre funcionam como deveriam. Muitas vezes, ocorre algum "efeito colateral" que faz com que algum outro módulo não funcione corretamente. Conforme escrevi no post [Acessando múltiplos bancos de dados em Rails]({% post_url 2008-03-11-acessando-multiplos-bancos-de-dados-em-rails %}), ao configurar o acesso a múltiplos bancos de dados, os unit tests pararam de funcionar. Mais uma vez, precisei passar algum tempo pesquisando no Google para encontrar uma solução.

O primeiro problema é com os fixtures. Quando o nome da tabela é diferente do model, o nome do arquivo de fixtures deve ser igual ao nome da tabela seguido por ".yml". Nos unit tests, o símbolo passado para o método `fixtures` deve ter este nome. No [artigo sobre acesso a múltiplos bancos de dados]({% post_url 2008-03-11-acessando-multiplos-bancos-de-dados-em-rails %}), citei como exemplo uma tabela `usuario_tb`. Neste caso, o arquivo de fixtures deveria se chamar `usuario_tb.yml`, e o arquivo com unit tests deveria carregar esses fixtures assim:

```ruby
class UsuarioTest < ActiveSupport::TestCase
  fixtures :usuario_tb
end
```

Em casos onde a única configuração fora do padrão seja o nome da tabela, a configuração acima é suficiente. Porém, no caso do exemplo citado no artigo anterior, onde o model não é mapeado numa tabela local, e sim num outro banco de dados, surgem outros problemas. O primeiro é que, ao tentar executar os testes, o rake informa que a tabela não existe. A única maneira que descobri para corrigir este problema foi criar esta tabela no ambiente de desenvolvimento. Ela não é usada para nada, mas se não for criada, os testes não funcionarão.

O segundo problema com esta configuração é que não é possível carregar os fixtures da maneira descrita acima. Em vez disso, é necessário usar o método `create_fixtures` da classe `Fixtures`. Para simplificar, como podem haver mais models configurados desta maneira, fiz a seguinte configuração:

1. criar o método `set_fixtures` no arquivo `test/test_helper.rb`:

```ruby
def set_fixtures (table, base)
  return unless (table && base.kind_of?(ActiveRecord::Base))

  ActiveRecord::Base.connection = base.connection
  Fixtures.create_fixtures(File.join(RAILS_ROOT, 'test', 'fixtures'), table) { base.connection }
end
```

2. criar o método `setup` nos unit tests, utilizando esse método para cada arquivo de fixtures que será carregado:

```ruby
def setup
  set_fixtures('usuario_tb', AutenticacaoDatabase)
end
```

No código acima, `AutenticacaoDatabase` é a classe abstrata usada como base para o model `Usuario`.

Com essas configurações é possível realizar os testes, com um único problema: não é possível referenciar os fixtures pelos labels. Para simplificar, como ainda não descobri uma maneira de corrigir isto, eu costumo definir os labels dos fixtures como números sequenciais, começando em 0. Assim eu posso buscar todos os dados da tabela (ex: `Usuario.find(:all)`) e referenciar o array pelos índices, que, neste caso, correspondem aos labels. Mas cuidado: o `find(:all)` não garante que o array retornado terá a mesma ordem do arquivo de fixtures. O ideal é criar fixtures com id sequencial, e adicionar o parâmetro `order` ao `find`.

Referências:

- [Rails fixtures with models using set\_table\_name](http://www.missiondata.com/blog/uncategorized/80/rails-fixtures-with-models-using-set_table_name)
- [How to Use Multiple Databases With Fixtures](http://wiki.rubyonrails.org/rails/pages/HowtoUseMultipleDatabasesWithFixtures)
