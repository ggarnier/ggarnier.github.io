---
layout: post
comments: true
title: "Definição de nomes de atributos \"humanizados\""
date: 2008-04-17
tags: [Ruby, Rails, Active Record, portuguese]
---
A classe `ActiveRecord::ConnectionAdapters::Column` tem um método `human_name` que cria uma versão "humanizada" para os nomes das colunas de tabelas (atributos de um model). Porém, nem sempre o nome criado é o que desejamos. Por exemplo, se temos uma coluna `num_usuarios`, o método `human_name` retornará "Num Usuarios", que, provavelmente, não é o que queremos. Para configurar o `human_name` manualmente, há duas soluções:

1. criar um hash e [redefinir o método human\_attribute\_name](http://henrik.nyh.se/2007/12/change-displayed-column-name-in-rails-validation-messages):

{% highlight ruby %}
class Model < ActiveRecord::Base
  HUMANIZED_ATTRIBUTES = {
    num_usuarios => 'Número de usuários'
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
{% endhighlight %}

2. usar o plugin [human\_attribute\_override](http://agilewebdevelopment.com/plugins/human_attribute_override). Esta solução é mais simples e elegante:

{% highlight ruby %}
class Model < ActiveRecord::Base
  attr_human_name :num_usuarios => 'Número de usuários'
end
{% endhighlight %}
