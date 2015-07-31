---
layout: post
title: "Variáveis de classe e de instância de classe em Ruby"
date: 2014-02-24
comments: true
tags: [Ruby]
---
Por ser uma linguagem orientada a objetos, Ruby possui variáveis de instância e de classe. As primeiras se referem a cada instância de uma determinada classe e as segundas à própria classe:

```ruby
class Funcionario
  @@dias_de_ferias = 30

  def salario=(valor)
    @salario = valor
  end

  def salario
    @salario
  end
end
```

Como esperado, cada instância da classe `Funcionario` possui uma instância da variável `@salario`, e a variável `@@dias_de_ferias` possui uma única instância:

```ruby
Funcionario.class_variable_get(:@@dias_de_ferias)  # 30

funcionario1 = Funcionario.new
funcionario1.salario = 2000
funcionario1.salario  # 2000

funcionario2 = Funcionario.new
funcionario2.salario = 2500
funcionario2.salario  # 2500
```

Até aqui nada de novo. Porém, um tipo de variável menos conhecida e usada é a variável de _instância de classe_.

Como tudo em Ruby é um objeto, todas as classes (tanto as classes padrão do Ruby quanto as criadas pelo usuário) são objetos - instâncias da classe `Class`:

```ruby
String.class  # Class

Funcionario.class  # Funcionario
```

E, como são objetos, as classes também podem ter variáveis de instância. Para definí-las e acessá-las, basta prefixar o nome da variável com "@", da mesma forma como é feito com variáveis de instância, porém no escopo de classe (ou num método de classe):

```ruby
class Funcionario
  @bonus = 1000

  def self.atualiza_bonus
    @bonus = 2000
  end
end
```

O comportamento de variáveis de instância de classe é semelhante às variáveis de classe, com uma diferença: quando usamos herança, as variáveis de classe são compartilhadas entre todas as classes da hierarquia, e as variáveis de instância de classe tem uma instância para cada classe:

```ruby
class Funcionario
  @@dias_de_ferias = 30
  @bonus = 1000
end

class Gerente < Funcionario
  @bonus = 5000
end


Funcionario.class_variable_get(:@@dias_de_ferias)  # 30
Funcionario.instance_variable_get(:@bonus)  # 1000

Gerente.class_variable_get(:@@dias_de_ferias)  # 30
Gerente.instance_variable_get(:@bonus)  # 5000

Gerente.class_variable_set(:@@dias_de_ferias, 45)
Gerente.class_variable_get(:@@dias_de_ferias)  # 45
Funcionario.class_variable_get(:@@dias_de_ferias)  # 45
```

No exemplo acima, a variável de classe `@@dias_de_ferias` é compartilhada entre as classes `Funcionario` e `Gerente`. Por isso, ao alterar o valor desta variável na subclasse, o valor na superclasse também mudou. Para confirmar que a instância é a mesma, basta verificar que o `object_id` da variável em ambas as classes:

```ruby
Funcionario.class_variable_get(:@@dias_de_ferias).object_id  # 70139308064800
Gerente.class_variable_get(:@@dias_de_ferias).object_id  # 70139308064800
```

No caso da variável de instância de classe `@bonus`, há uma instância para a classe `Funcionario` e outra para a classe `Gerente`:

```ruby
Funcionario.instance_variable_get(:@bonus).object_id  # 70139307998300
Gerente.instance_variable_get(:@bonus).object_id  # 70139308064780
```
