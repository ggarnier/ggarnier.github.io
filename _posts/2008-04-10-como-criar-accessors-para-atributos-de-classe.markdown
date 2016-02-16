---
layout: post
comments: true
title: "Como criar accessors para atributos de classe"
date: 2008-04-10
tags: [Ruby, portuguese]
---
Os métodos `attr_reader`, `attr_writer` e `attr_accessor` do Ruby servem para simplificar a criação de setters e getters para atributos de instância. Ex:

```ruby
class Teste
  @valor = 1
  attr_accessor :valor
end
```

No código acima, o método `attr_accessor` já cria o getter e o setter para o atributo valor:

```ruby
t = Teste.new
t.valor = 10
puts t.valor #=> 10
```

Porém, como fazer o mesmo para atributos de classe? Eu fiz [essa pergunta](http://forum.rubyonbr.org/forums/1/topics/2910) no [forum RubyOnBr](http://forum.rubyonbr.org). O Shairon Toledo me respondeu com o código do método `attr_static_accessor`, que é, na prática, o equivalente ao `attr_accessor`, só que para atributos de classe. Eu complementei o código dele com os métodos `attr_static_reader` e `attr_static_writer`:

```ruby
class Module
  def attr_static_reader(*args)
    args.each do |meth|
      init_var(meth)
      set_reader(meth)
    end
  end

  def attr_static_writer(*args)
    args.each do |meth|
      init_var(meth)
      set_writer(meth)
    end
  end

  def attr_static_accessor(*args)
    args.each do |meth|
      init_var(meth)
      set_reader(meth)
      set_writer(meth)
    end
  end

  private
  def init_var(var_name)
    var = "@@#{var_name}".to_sym
    self.send(:class_variable_set, var, nil) unless self.send(:class_variable_defined?, var)
  end

  def set_reader(var_name)
    self.class.send(:define_method, var_name) {
      self.send(:class_variable_get, "@@#{var_name}".to_sym)
    }
  end

  def set_writer(var_name)
    self.class.class_eval %Q{
      def #{var_name}=(value)
        self.send(:class_variable_set, "@@#{var_name}".to_sym,value)
      end
    }
  end
end
```

Agora é possível fazer o seguinte:

```ruby
class Teste
  @@valor = 1
  attr_static_accessor :valor
end

puts Teste.valor #=> 1
Teste.valor = 10
puts Teste.valor #=> 10
```
