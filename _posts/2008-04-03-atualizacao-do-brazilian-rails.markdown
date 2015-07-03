---
layout: post
comments: true
title: "Atualização do Brazilian Rails"
date: 2008-04-03
categories: [Rails, Ruby]
---
Quem já tentou tratar caracteres acentuados em Ruby deve ter percebido que a linguagem não considera estes caracteres como letras. Métodos como upcase e downcase são "locale insensitive", como diz a descrição destes métodos no [manual do Ruby](http://www.ruby-doc.org/core/):

{% blockquote %}
  str.downcase => Returns a copy of str with all uppercase letters replaced with their lowercase counterparts. The operation is locale insensitive—only characters ``A’’ to ``Z’’ are affected.
{% endblockquote %}

O projeto [Brazilian Rails](http://brazilian-rails.rubyforge.org/) foi criado com o objetivo de resolver este e outros problemas. O projeto é instalado como um plugin para Rails, e define novos métodos para a classe String, como o upcase_br e o downcase_br, que podem ser usados em substituição aos métodos originais. O plugin acrescenta ainda outras funcionalidades, como data, hora, feriados, dinheiro e mensagens de erro, todas adaptadas ao português brasileiro.

Ontem enviei um patch para o projeto, contribuindo com alguns novos métodos para Strings. Em breve a versão atualizada deverá ser disponibilizada, conforme o post do [Celestino Gomes](http://tinogomes.wordpress.com/2008/04/03/atualizacao-do-brazilian-rails/).
