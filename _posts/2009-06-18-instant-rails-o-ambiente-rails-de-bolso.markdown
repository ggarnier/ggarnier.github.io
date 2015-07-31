---
layout: post
comments: true
title: "Instant Rails, o ambiente Rails de bolso"
date: 2009-06-18
tags: [Rails, Ruby, Windows, Linux, portable apps]
---
Com a proliferação dos pen drives com alguns GB de capacidade e a preços acessíveis, aplicativos que rodam sem necessitar de instalação tornaram-se igualmente populares. Estes aplicativos "portáteis", mais conhecidos como Portable Apps, podem ser executados diretamente do pen drive, geralmente com todas as funções dos equivalentes instaláveis. Eles são mais comuns em ambiente Windows (o site mais conhecido é o [PortableApps](http://portableapps.com/), mas existem outros, como o [The Portable Freeware Collection](http://www.portablefreeware.com/)), porém também existem [Portable Apps para Mac OS X](http://www.freesmug.org/portableapps/). Até onde eu sei, não existem Portable Apps para Linux, porém, é possível [executar os Portable Apps de Windows via Wine](http://www.linuxfortravelers.com/running-portable-apps-on-linux).

Como não poderia deixar de ser, existem também muitos ambientes de desenvolvimento portáteis. Talvez o mais conhecido seja o [XAMPP](http://portableapps.com/apps/development/servers/xampp), que inclui um servidor Apache com MySQL, PHP e Perl, entre outras ferramentas. Basta descompactar e executar.

Para Ruby on Rails, também existe um ambiente portátil. É o [Instant Rails](http://rubyforge.org/projects/instantrails/), infelizmente disponível somente para Windows. A exemplo do XAMPP, basta descompactar um arquivo zip para se ter um ambiente Rails totalmente funcional, com Mongrel, Apache e MySQL. É possível, inclusive, instalar [RubyGems](http://rubygems.org/) e plugins Rails normalmente, como num ambiente Rails comum. O pacote inclui ainda o [SQLite](http://www.sqlite.org/), [PHP](http://www.php.net/), [phpMyAdmin](http://www.phpmyadmin.net/), o editor [SciTE](http://www.scintilla.org/SciTE.html) e o [typo](http://typosphere.org/), sobre o qual [já escrevi aqui no blog]({% post_url 2008-10-31-ferramenta-em-rails-para-criacao-de-blogs %}).

A principal desvantagem do Instant Rails é que ele está bastante desatualizado - a versão atual, 2.0, é de dezembro de 2007, e inclui as seguintes versões:

- Ruby 1.8.6
- Rails 2.0.2
- Mongrel 1.1.2
- RubyGems 1.0.1
- Rake 0.8.1
- Apache 1.3.33
- MySQL 5.0.27
- SQLite 3.5.4
- PHP 4.3.10
- SciTE 1.72
- phpMyAdmin 2.10.0.2

Segundo o [wiki do projeto](http://instantrails.rubyforge.org/wiki/wiki.pl), há uma petição solicitando o upgrade para a versão 1.9.1 do Ruby.

**UPDATE:** Só agora vi que o [Urubatan](http://www.urubatan.com.br/) escreveu sobre [o mesmo assunto](http://www.urubatan.com.br/carregando-o-rails-no-bolso-e-programando-em-qualquer-lugar/) no blog dele. Só que ele citou o [Ruby on Rails Portable](http://sourceforge.net/projects/railsportable/), um projeto muito semelhante ao InstantRails, porém um pouco mais atualizado: a versão do Rails atualmente é 2.1.0 (a do Ruby é 1.8.6).

Outro projeto semelhante que encontrei, mas ainda não testei, é o [Flash Rails](http://rubyforge.org/projects/flashrails).
