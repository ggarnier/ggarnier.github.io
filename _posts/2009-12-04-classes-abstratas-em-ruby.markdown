---
layout: post
comments: true
title: "Classes abstratas em Ruby?"
date: 2009-12-04
tags: [Ruby, linguagens de programação, engenharia de software]
---
Como eu estava há algum tempo sem mexer com Ruby, resolvi fazer o ótimo curso online gratuito [Core Ruby](http://www.rubylearning.org/class/), do [Satish Talim](http://satishtalim.com/) (também conhecido como [Indian Guru](http://twitter.com/IndianGuru)) para relembrar algumas coisas. Ao chegar no tópico [Ruby Overriding Methods](http://rubylearning.com/satishtalim/ruby_overriding_methods.html), há um item sobre classes abstratas, que diz o seguinte:

> **Abstract class**

> In Ruby, we can define an abstract class that invokes certain undefined "abstract" methods, which are left for subclasses to define. For example:

> ``` ruby
# This class is abstract; it doesn't define hello or name
# No special syntax is required: any class that invokes methods
# that are intended for a subclass to implement is abstract
class AbstractKlass
  def welcome
    puts "#{hello} #{name}"
  end
end

> # A concrete class
class ConcreteKlass < AbstractKlass
  def hello; "Hello"; end
  def name; "Ruby students"; end
end

> ConcreteKlass.new.welcome # Displays "Hello Ruby students"
```

Assim que li esse código, fiquei com uma pulga atrás da orelha. Ele mostra como um exemplo de classe abstrata uma classe que faz referência a métodos não definidos, explicando que seria necessário criar uma classe concreta estendendo esta classe e implementando os métodos necessários.

Eu sempre pensei que classes abstratas fossem classes que não poderiam ser instanciadas, o que não é o caso do exemplo. É perfeitamente possível criar objetos da classe `AbstractKlass`. Só ocorrerá uma exceção se o método `welcome` do objeto criado for executado:

```irb
irb(main):006:0> obj = AbstractKlass.new
=> #<AbstractKlass:0x37d490>
irb(main):007:0> obj.class
=> AbstractKlass
irb(main):008:0> obj.welcome
NameError: undefined local variable or method `hello' for #<AbstractKlass:0x37d490>
        from (irb):9
```

Resolvi levantar esta questão no forum do curso, e recebi uma resposta de um dos participantes dizendo que em Ruby o conceito de classes abstratas seria diferente daquele que apresentei acima. De acordo com a [definição da Wikipedia](http://en.wikipedia.org/wiki/Class_%28computer_science%29#Abstract_classes): "An abstract class, or abstract base class (ABC), is a class that cannot be instantiated".

Pesquisando sobre o assunto, encontrei referências apresentando algumas sugestões de como implementar classes abstratas em Ruby de diferentes maneiras (herança, módulos e até uma gem):

- [How to implement an abstract class in ruby?](http://stackoverflow.com/questions/512466/how-to-implement-an-abstract-class-in-ruby)
- [Abstract Classes, For Ruby: Abstraction](http://peeja.com/journal/2009/4/12/abstract-classes-for-ruby-abstraction.html)

Uma das possibilidades mostradas nos links acima seria desta forma:

```ruby
class AbstractClass
  class AbstractClassInstiationError < RuntimeError
  end

  def initialize
    raise AbstractClassInstiationError, "Cannot instantiate this class directly"
  end
end

class ConcreteClass < AbstractClass
  def initialize
  end
end
```

Isso teoricamente resolveria o problema:

```irb
irb(main):043:0> obj1 = AbstractClass.new
AbstractClass::AbstractClassInstiationError: Cannot instantiate this class directly
        from (irb):36:in `initialize'
        from (irb):44
irb(main):044:0> obj1.class
=> NilClass
irb(main):045:0> obj2 = ConcreteClass.new
=> #<ConcreteClass:0x309f9f>
irb(main):046:0> obj2.class
=> ConcreteClass
```

Porém, há um detalhe importantíssimo: em Ruby todas as classes são abertas, ou seja, sempre será possível reimplementar métodos ou adicionar módulos que alteram o comportamento da classe, tornando impossível proibir completamente a instanciação e, consequentemente, a implementação de classes abstratas (pelo menos de acordo com o conceito apresentado aqui).

A linguagem Ruby possui alguns conceitos diferentes dos utilizados em outras linguagens, em função de algumas de suas características, como classes abertas e meta programação. Isso nos força a pensar em maneiras diferentes de implementar soluções para os mesmos problemas, o que é muito bom.

Para concluir, segue um trecho do livro ["Programming Ruby"](http://www.amazon.com/Programming-Ruby-Pragmatic-Programmers-Second/dp/0974514055/ref=sr_1_2?ie=UTF8&amp;s=books&amp;qid=1260179532&amp;sr=8-2) que foi apresentado na discussão sobre este assunto no forum do curso:

> The issue of types is actually somewhat deeper than an ongoing debate between strong typing advocates and the hippie-freak dynamic typing crowd. The real issue is the question, what is a type in the first place?

> If you’ve been coding in conventional typed languages, you’ve probably been taught that the type of an object is its class—all objects are instances of some class, and that class is the object’s type. The class defines the operations (methods) that the object can support, along with the state (instance variables) on which those methods operate.

> In Ruby, the class is never (OK, almost never) the type. Instead, the type of an object is defined more by what that object can do. In Ruby, we call this duck typing. If an object walks like a duck and talks like a duck, then the interpreter is happy to treat it as if it were a duck.
