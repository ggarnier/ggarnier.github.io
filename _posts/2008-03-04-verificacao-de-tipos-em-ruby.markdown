---
layout: post
comments: true
title: "Verificação de tipos em Ruby"
date: 2008-03-04
tags: [Ruby, portuguese]
---
Uma das principais características do Ruby é ser uma linguagem dinâmica, o que significa que a tipagem é dinâmica, ou seja, a linguagem permite que uma variável seja usada sem ser previamente declarada, assuma um valor de uma classe qualquer e depois possa ter seu valor alterado para um objeto de outra classe.

Apesar da simplicidade que esta característica traz, frequentemente precisamos verificar o tipo de classe de uma variável, para termos certeza de que em uma chamada de função não é passada uma variável contendo um objeto de uma classe diferente da esperada, por exemplo. Isto não é necessário em linguagens como C e Java, onde cada variável precisa ser declarada antes do uso, e na declaração é necessário especificar o tipo de variável.

[Este artigo](http://www.codecommit.com/blog/ruby/adding-type-checking-to-ruby) apresenta um módulo Ruby chamado Types, que simplifica bastante o trabalho de verificação do tipo de classe passado em cada parâmetro de uma função. É possível, inclusive, verificar se a classe passada implementa um método específico. Qualquer tipo de verificação é feito acrescentando-se uma linha antes da definição da função, eliminando a necessidade de verificarmos o tipo de cada parâmetro no código da função. Não cheguei a testar o módulo ainda, porém, de acordo com o artigo, parece ser uma solução muito simples e flexível para problemas de tipagem.
