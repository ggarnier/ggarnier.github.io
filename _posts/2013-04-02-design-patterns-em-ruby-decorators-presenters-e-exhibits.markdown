---
layout: post
comments: true
title: "Design patterns em Ruby - Decorators, Presenters e Exhibits"
date: 2013-04-02
tags: [Ruby, design patterns, Rails, engenharia de software, portuguese]
---
Ao criar um novo projeto Rails, o generator cria uma estrutura padrão de diretórios. Dentro de `app`, ele cria os diretórios `models`, `controllers`, `views` e `helpers`. Os três primeiros tem papéis bem definidos, mas mesmo assim há uma certa confusão quando surge algum arquivo "fora do padrão".

Numa aplicação típica, um model geralmente estende a classe `ActiveRecord::Base` ou inclui um módulo, como `Mongoid::Document`, no caso do [Mongoid](http://mongoid.org), por exemplo, para mapear a estrutura do banco de dados. Além disso, o model contém as regras de negócio associadas a ele. O controller tem a responsabilidade de mapear a ação atual numa view - por exemplo, ao submeter um formulário para criação de um novo objeto, um controller típico renderiza uma view exibindo uma mensagem de sucesso, ou renderiza a mesma view do formulário com as mensagens de erro, caso haja algum. Já a view é responsável por exibir os dados correspondentes à página atual.

Essa estrutura básica funciona bem numa aplicação simples. O problema é quando a view começa a conter muita lógica. Por exemplo, uma view para exibir dados de um usuário poderia ser simples assim:

```ruby
@usuario.nome
```

Porém, se o conteúdo muda dependendo do tipo de usuário (ex: usuário comum e admin), precisamos de um if dentro da view:

```erb
<% if @usuario.admin? %>
  admin
<% else %>
  @usuario.nome
<% end %>
```

Quando mais diferenças houver, mais complexa fica a view. Consequentemente, fica mais difícil de gerenciar. Além disso, normalmente fazemos testes unitários para o model e o controller, e testamos a view somente com testes de aceitação, que são muito mais lentos (é preciso carregar todo o ambiente, Rails, banco de dados, e dependendo do teste, abrir um browser). Fica impraticável testar todos os fluxos de uma view cheia de if's usando testes de aceitação.

Uma solução comum no mundo Rails é usar os helpers. No exemplo acima, eu poderia ter o seguinte helper:

```ruby
class UsuarioHelper
  def titulo_usuario(usuario)
    usuario.admin? ? "admin" : usuario.nome
  end
end
```

Isso deixa o código da view mais simples:

```ruby
titulo_usuario(@usuario)
```

E, além disso, posso testar a lógica num teste unitário do helper. Mas essa solução também tem problemas: o helper não está associado diretamente ao objeto em questão. Isso ficou claro no exemplo acima, onde precisei passar o usuário como parâmetro para o método do helper. Isso se repetiria para cada método.

Uma boa solução para este caso é utilizar o [design pattern](http://en.wikipedia.org/wiki/Software_design_pattern) [Decorator](http://en.wikipedia.org/wiki/Decorator_pattern). Para isso, criamos uma classe que recebe o model como parâmetro no construtor e implementa todos os métodos necessários para lógicas de visualização (ou seja, que não estão associados ao negócio e não devem ficar no model). Um exemplo de decorator é o seguinte:

```ruby
class UsuarioDecorator
  attr_reader :usuario

  def initialize(usuario)
    @usuario = usuario
  end

  def titulo
    @usuario.admin? ? "admin" : @usuario.nome
  end
end
```

Outra opção é criar um decorator que também implementa o padrão [Delegation](http://en.wikipedia.org/wiki/Delegation_pattern). Neste caso, quando é chamado um método que não existe, o Decorator delega a chamada para o model. Segue um exemplo de implementação:

```ruby
module Decorator
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def method_missing(meth, *args)
    if @model.respond_to?(meth)
      @model.send(meth, *args)
    else
      super
    end
  end

  def respond_to?(meth)
    @model.respond_to?(meth)
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def decorate(object)
      if object.is_a? Enumerable
        object.map {|obj| self.new(obj)}
      else
        self.new(object)
      end
    end
  end
end


class UsuarioDecorator
  include Decorator

  def titulo
    @model.admin? ? "admin" : @model.nome
  end
end
```

Desta forma, temos uma classe que recebe o model no construtor ou no método de classe `decorate`. A implementação do método `titulo_usuario` no Decorator ficou muito mais simples. Para utilizá-la, basta decorar o model no controller:

```ruby
class UsuariosController
  def show
    @usuario = UsuarioDecorator.decorate(Usuario.find(params[:id]))
  end
end
```

A implementação da view fica assim:

```ruby
@usuario.titulo
```

Em casos mais simples, o Decorator atende bem. Mas e quando temos uma página mais complexa, envolvendo diversos objetos? Precisaríamos criar um Decorator para cada model, e lembrar de decorar cada objeto na criação, assim como fizemos com o usuário no exemplo anterior. Outro problema é que podemos ter visualizações diferentes de um objeto em cada tela da aplicação. Como tratar este caso? Poderíamos criar métodos diferentes no Decorator, mas com o tempo o Decorator poderia virar um monstro. Outra opção é criar vários Decorators para aquele model, onde cada um se aplica a uma página. Ou podemos usar um outro padrão, o Presenter.

O Presenter é um padrão também conhecido por outros nomes, como [View Object](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/), mas na comunidade Ruby o nome Presenter se popularizou com [um post de Jay Fields](http://blog.jayfields.com/2007/03/rails-presenter-pattern.html). O Presenter é muito parecido com o Decorator, mas envolve vários objetos. O contexto do Presenter é uma página específica da aplicação, e recebe como parâmetro todos os objetos necessários à exibição daquela página. Desta forma, toda a lógica de apresentação fica numa única classe. Segue um exemplo de uso do Presenter:

```ruby
class PedidoPresenter
  def initialize(usuario, pedidos)
    @usuario = usuario
    @pedidos = pedidos
  end

  def titulo
    "Usuário #{@usuario.nome} - #{@pedidos.size} pedidos"
  end

  def links
    @pedidos.map { |pedido| link_to pedido.nome, pedido_url(pedido) }
  end
end
```

Ainda há uma outra opção além do Presenter, que foi apresentada no livro [Objects on Rails](http://objectsonrails.com). É o padrão Exhibit. A diferença em relação ao Presenter é que, enquanto o Presenter disponibiliza métodos para serem chamados pela view (como no exemplo acima), o Exhibit é responsável pela renderização. Para isso, ele precisa receber um contexto:

```ruby
class Exhibit
  def initialize(obj, context)
    @obj = obj
    @context = context
  end

  def render_header
    @context.render :partial => "header", :locals => {:obj => @obj}
  end
end
```

Este contexto pode ser o `view_context` do controller:

```ruby
class Controller
  def show
    @usuario = Exhibit.new(Usuario.find(params[:id]), view_context)
  end
end
```

Outra maneira de instanciar o Exhibit é através de um helper, como mostrado no livro [The Rails View](http://pragprog.com/book/warv/the-rails-view):

```ruby
class Helper
  def exhibit
    Exhibit.new(Usuario.find(params[:id]), self)
  end
end
```

São muitos padrões que tem a mesma função: encapsular a lógica de visualização num único local, que seja facilmente testável. E qual é a melhor opção entre os três? A resposta depende da situação. Não adianta querer encontrar um padrão perfeito para todos os casos. Na minha opinião, o Decorator funciona bem em páginas mais simples, que envolvem apenas um model. Quando a página é mais complexa e envolve vários models, o Presenter e o Exhibit são mais adequados. E a diferença entre os dois é uma questão de gosto.

Links relacionados:

- [Decorators compared to Strategies, Composites, and Presenters](http://robots.thoughtbot.com/post/20964851591/decorators-compared-to-strategies-composites-and)
- [Evaluating alternative Decorator implementations in Ruby](http://robots.thoughtbot.com/post/14825364877/evaluating-alternative-decorator-implementations-in)
- [Better Ruby Presenters](http://blog.steveklabnik.com/posts/2011-09-09-better-ruby-presenters)
- [Explorando as views Rails](https://speakerdeck.com/rodrigoospinto/explorando-as-views-rails)
