---
layout: post
comments: true
title: "Executando testes em partes"
date: 2008-04-04
categories: [Ruby, Rails, testes]
---
A execução de testes em Rails é feita, normalmente, com o comando `rake test`. Este comando executa automaticamente todos os testes unitários e funcionais. Porém, algumas vezes queremos executar apenas uma parte dos testes, seja porque sabemos que outra parte do sistema está dando algum erro que pretendemos tratar depois, seja porque acabamos de alterar um trecho do código (ou dos testes) e queremos verificar se estes estão OK.

Para executar apenas os testes unitários, executamos o comando `rake test:units`. Para os testes funcionais, `rake test:funcionals`. Mas se quisermos executar um arquivo de testes específico, devemos trocar o rake pelo próprio ruby:

```ruby
ruby test/unit/usuario_test.rb
```

Para ser ainda mais específico e executar um único método, basta acrescentar o parâmetro `--name`:

```ruby
ruby test/unit/usuario_test.rb --name test_dados
```

Outra vantagem de testar executando o Ruby diretamente (sem o rake) é que não ocorre o problema de [tabelas não existentes no ambiente de desenvolvimento]({% post_url 2008-03-18-configuracoes-fora-do-padrao-em-rails %}), como ocorre com o rake.

Referência: [Rails: Unit Test without Rails](http://blog.jayfields.com/2007/10/rails-unit-test-without-rails.html)
