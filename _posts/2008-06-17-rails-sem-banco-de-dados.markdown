---
layout: post
comments: true
title: "Rails sem banco de dados"
date: 2008-06-17
tags: [Rails, Ruby, tests, Active Record, portuguese]
---
O Active Record é um dos principais componentes do Rails, pois é exatamente o model do MVC. Ele mapeia automaticamente uma classe numa tabela do banco de dados, criando métodos para acesso a cada atributo. Porém, e se quisermos desenvolver uma aplicação sem banco de dados?

Passei por esta situação recentemente: a aplicação acessa um servidor diretamente, via [Atom](http://atompub.org/), e, portanto, não precisa armazenar dados localmente. Porém, não basta comentar todas as linhas do arquivo `config/database.yml`, pois o Rails mostrará uma mensagem de erro informando que não encontrou o banco de dados correspondente.

Para resolver este problema, resolvi, inicialmente, tentar não utilizar o Active Record. Para isso, primeiramente precisei modificar o model que eu tinha na aplicação, retirando a herança de `ActiveRecord::Base`. Porém, ao tentar executar o servidor, recebi mensagens de erro informando que o banco de dados não foi encontrado. Isso ocorre porque, apesar de não haver qualquer classe herdando de `ActiveRecord::Base` no projeto, este módulo estava sendo carregado. Consequentemente, o Rails tentava ler o arquivo `config/database.yml`, que não estava configurado, resultando na mensagem de erro. Para evitar este problema, foi necessário evitar o carregamento do Active Record explicitamente, acrescentando a linha abaixo ao arquivo `config/environment.rb`:

{% highlight ruby %}
config.frameworks -= [ :active_record ]
{% endhighlight %}

Feito isto, o Rails passa a funcionar sem banco de dados e sem Active Record. Porém, surgiu um outro problema: os testes unitários do Rails pararam de funcionar, pois a classe `ActiveSupport::TestCase`, que é a classe base para os testes unitários, não funciona sem Active Record. Para resolver, troquei a herança desta classe para `Test::Unit::TestCase`, que era utilizada como padrão antes da versão 2 do Rails. Não sei exatamente quais são as diferenças entre as duas, mas só consegui resolver este problema desta forma - se alguém descobrir alguma outra solução, me avise!

Também precisei carregar explicitamente o model no arquivo de teste, pois o Rails deixou de fazer a referência automática a esta classe. Feitas as alterações, o arquivo de teste (ex: `test/unit/usuario_test.rb`) ficou assim:

{% highlight ruby %}
require 'test/test_helper'
require 'test/unit'
require 'app/models/usuario'

class UsuarioTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
{% endhighlight %}
