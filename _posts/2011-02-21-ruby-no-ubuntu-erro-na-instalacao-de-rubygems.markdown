---
layout: post
comments: true
title: "Ruby no Ubuntu - erro na instalação de Rubygems"
date: 2011-02-21
categories: [Ruby, Rubygems, Linux, Ubuntu]
---
Dica rápida de Ruby: se ao tentar instalar uma [Rubygem](http://rubygems.org) no Ubuntu você receber uma mensagem como essa:

```sh
guilherme@guilherme-desktop:~$ sudo gem install mechanize
Building native extensions.  This could take a while...
ERROR:  Error installing mechanize:
    ERROR: Failed to build gem native extension.

/usr/bin/ruby1.8 extconf.rb
extconf.rb:5:in `require': no such file to load -- mkmf (LoadError)
    from extconf.rb:5
```

A solução é simples: basta instalar o pacote ruby-dev: `sudo apt-get install ruby-dev`. Este pacote é necessário para a instalação de gems nativas, que precisam ser compiladas na instalação.
