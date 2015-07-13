---
layout: post
comments: true
title: "Representação de data e hora em Ruby 1.8.7 e 1.9"
date: 2011-03-01
categories: [Ruby, JRuby]
---
A classe [Time](http://www.ruby-doc.org/core/classes/Time.html) do Ruby é usada, como esperado, para representar uma data e hora. Existem várias formas de criar uma nova instância, a mais óbvia é usando `Time.new` (ou `Time.now`), que cria uma nova instância com a data e hora atuais:

```irb
irb(main):007:0> Time.new
=> Wed Feb 09 13:23:52 -0200 2011
irb(main):008:0> Time.now
=> Wed Feb 09 13:23:53 -0200 2011
```

Também é possível criar uma instância usando métodos como [Time.at(time)](http://www.ruby-doc.org/core/classes/Time.html#M000334), que recebe um timestamp como parâmetro, [Time.local(year, month, day, hour, min, sec\_with\_frac)](http://www.ruby-doc.org/core/classes/Time.html#M000337) e outros. Também há um construtor que recebe como parâmetro uma string representando a data:

```irb
irb(main):001:0> Time.new('2011-01-01')
=> Sat Jan 01 00:00:00 -0200 2011
```

Eu havia escrito um código que usava esse construtor no [pidgin-logs-compressor](https://github.com/ggarnier/pidgin-logs-compressor), mas quando testei no [JRuby](http://jruby.org) 1.5.5, recebi uma exceção "ArgumentError: wrong number of arguments (1 for 0)". Achei que fosse algum bug do JRuby, e realmente [havia esse bug](http://jira.codehaus.org/browse/JRUBY-5008) na versão que eu usava, mas já estava corrigido no JRuby 1.6RC1. Atualizei para esta versão, mas o erro continuou. Descobri que o erro que eu estava cometendo era relacionado com a versão do Ruby, e não do JRuby. Esse construtor com parâmetros é aceito no Ruby 1.9, mas não no 1.8.7, que é a versão usada por padrão pelo JRuby. Para fazer com que ele utilize a versão 1.9, basta acrescentar o parâmetro `--1.9` na linha de comando:

```sh
jruby --1.9 -e 'puts Time.new("2011-02-16")'
```

Para manter compatibilidade com versões anteriores, é necessário usar algum dos outros métodos, como eu optei por fazer no [pidgin-logs-compressor](https://github.com/ggarnier/pidgin-logs-compressor).

Para um overview de algumas novidades do Ruby 1.9: [New Ruby 1.9 Features, Tips & Tricks](http://www.igvita.com/2011/02/03/new-ruby-19-features-tips-tricks/).
