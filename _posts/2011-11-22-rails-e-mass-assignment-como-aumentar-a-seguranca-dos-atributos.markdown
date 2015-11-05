---
layout: post
comments: true
title: "Rails e mass assignment: como aumentar a segurança dos atributos"
date: 2011-11-22
tags: [Ruby, Rails, mass assignment, security, Active Model, Active Record, portuguese]
---
Ao utilizar o scaffold do Rails, ele criará todos os métodos necessários no controller. Depois que o usuário preenche os dados do formulário e envia, é executado o método create do controller. Este método faz algo semelhante ao código abaixo (no exemplo é um CRUD de usuário):

```ruby
@usuario = Usuario.new(params[:usuario])
```

Na forma em que o Rails cria o formulário, os atributos do usuário são passados ao controller como um hash. O valor do params acima é algo parecido com isso:

```ruby
{ "authenticity_token" => "xI1Cy+LvUZzg6FR/1Y/JHcaHVPRyWsHmRII8BhMOr0E=",
 "utf8" => "?",
 "action" => "create",
 "controller" => "usuarios",
 "usuario" => { "nome" => "Novo usuario", "email" => "novo@usuario.com" } }
```

Além da definição do token de segurança, codificação em utf-8, nome do controller e da action que será executada, o parâmetro usuario contém todos os atributos que foram preenchidos no formulário. Desta forma, é muito simples atribuir os parâmetros preenchidos a um objeto Usuario, seja criando um novo (`@usuario = Usuario.new(params[:usuario])`) ou editando (`@usuario.update_params(params[:usuario])`). O Rails chama isso de [_mass assignment_](http://guides.rubyonrails.org/security.html#mass-assignment).

O problema desta abordagem é que o usuário poderia facilmente inserir novos parâmetros neste hash, simplesmente adicionando tags input hidden no formulário (usando o [Firebug](http://getfirebug.com/), por exemplo):

```html
<input type="hidden" name="usuario[admin]" id="usuario_admin" value="true" />
```

Adicionando o código acima, o novo usuário criado receberia o valor `true` no atributo `admin`, o que representa uma falha grave na segurança da aplicação.

O Rails oferece um mecanismo para garantir a segurança nestes casos, usando os métodos [`attr_protected`](http://apidock.com/rails/ActiveModel/MassAssignmentSecurity/ClassMethods/attr_protected) e [`attr_accessible`](http://apidock.com/rails/ActiveModel/MassAssignmentSecurity/ClassMethods/attr_accessible) do [ActiveModel](http://apidock.com/rails/ActiveModel). O primeiro permite definir atributos que não podem ser alterados através de _mass assignment_:

```ruby
class Usuario
  attr_protected :admin
end
```

E o `attr_accessible` é uma forma mais segura: somente os atributos passados para este método poderão ser alterados com _mass assignment_. Os demais ficam protegidos:

```ruby
class Usuario
  attr_accessible :nome, :email
end
```

Obviamente estes dois métodos não podem ser usados simultaneamente, pois um exclui o outro.

Se você quiser atualizar um objeto com _mass assignment_ ignorando a segurança fornecida pelo `attr_accessible` e pelo `attr_protected`, basta utilizar o parâmetro `without_protection` (somente no Rails 3.1):

```ruby
Usuario.create(
  {:nome => "Novo usuario", :email =>"novo@usuario.com", :admin => true},
  :without_protection => true)
```

No exemplo acima, o usuário criado terá o atributo `admin` igual a `true`, mesmo que tenha sido usado o método `attr_protected` ou o `attr_accessible` para evitar a alteração deste atributo.

Outra opção interessante para evitar a alteração de atributos indesejados é o método [`attr_readonly`](http://apidock.com/rails/ActiveRecord/Base/attr_readonly/class). Os atributos passados para este método só poderão ser definidos na criação do objeto, e não poderão ser alterados depois. Porém, este método faz parte do [ActiveRecord::Base](http://apidock.com/rails/ActiveRecord/Base), e não do ActiveModel, ou seja, ele não estará disponível se você usar outro ORM. [Há uma issue aberta no Github](https://github.com/rails/rails/issues/3376) solicitando que este método seja movido para o ActiveModel.

Link relacionado: [Recebendo dados do usuário: attr\_accessible e attr\_protected](http://simplesideias.com.br/recebendo-dados-do-usuario-attr_accessible-e-attr_protected/)
