---
layout: post
comments: true
title: "Gerenciando múltiplas versões de Ruby no Windows"
date: 2011-05-19
categories: [Ruby, JRuby, Pik, RVM, Windows]
---
O [RVM](https://rvm.io/) já se tornou a opção padrão para gerenciar múltiplas versões de Ruby. Ele permite instalar várias versões, alternar entre elas, instalar gems em cada versão independentemente... mas não funciona em ambiente Windows. Eu sei que este não é um ambiente muito popular para desenvolvimento Ruby, mas existem usuários de Windows (seja por opção ou por obrigação) programando em Ruby. Para estes, uma alternativa ao RVM é o [Pik](https://github.com/vertiginous/pik).

O Pik funciona de forma bastante semelhante ao RVM. Para instalá-lo, primeiro é necessário instalar o [Ruby Installer](http://rubyinstaller.org/), um pacote pré-configurado especialmente para instalar o Ruby no Windows. A documentação do Pik recomenda a versão 1.8.7. Em seguida, instale as gems `rake`, `isolate` e o próprio `pik`:

```bat
gem install rake isolate pik
```

Antes de instalar o `isolate`, talvez seja necessário atualizar o [Rubygems](http://rubygems.org/) com o comando abaixo:

```bat
gem update --system
```

O próximo passo é instalar o Pik no diretório de sua preferência. Um detalhe importante que já me custou um bom tempo é que o path completo não deve conter espaços. Execute o seguinte comando para instalar em `C:\Ruby\pik`, por exemplo:

```bat
pik_install C:\Ruby\pik
```

Concluída a instalação, o comando `pik help commands` exibe uma lista com os comandos disponíveis. Quem já usou o RVM não terá dificuldades, pois os comandos são bem semelhantes. Os comandos mais comuns são:

- `pik install ruby/jruby/ironruby [versão]` -> instala a versão desejada do Ruby, JRuby ou IronRuby. A versão é opcional; se for omitida, será instalada a versão mais recente. Importante: antes de executar este comando, instale o [7zip](http://www.7-zip.org/) e adicione-o ao path
- `pik list` -> exibe as versões de Ruby atualmente instaladas
- `pik use [versão]` -> seleciona uma versão instalada
- `pik gem [comando]` -> executa um comando do Rubygems em todas as versões instaladas
- `pik ruby [parâmetros]` -> executa Ruby em todas as versões instaladas

Inicialmente, o comando `pik list` exibe apenas a versão 1.8.7:

```bat
C:\Ruby\pik>pik list
* 187: ruby 1.8.7 (2011-02-18 patchlevel 334) [i386-mingw32]
```

Decidi instalar a última versão do Ruby e do JRuby. Após instalar estas duas versões, a saída do comando `pik list` ficou assim (o asterisco mostra a versão atualmente em uso):

```bat
C:\Ruby\pik>pik install ruby
...
C:\Ruby\pik>pik install jruby
...
C:\Ruby\pik>pik list
  161: jruby 1.6.1 (ruby-1.8.7-p330) (2011-04-12 85838f6) (Java HotSpot(TM) Client VM 1.6.0_24) [Windows XP-x86-java]
* 187: ruby 1.8.7 (2011-02-18 patchlevel 334) [i386-mingw32]
  192: ruby 1.9.2dev (2010-05-31) [i386-mingw32]
```

Para selecionar o JRuby, por exemplo, use o comando `pik use 161` (é importante lembrar que neste caso os comandos mudam de nome: `irb` vira `jirb`, `ruby` vira `jruby`):

```bat
C:\Ruby\pik>pik use 161

C:\Ruby\pik>ruby -v
'ruby' não é reconhecido como um comando interno
ou externo, um programa operável ou um arquivo em lotes.

C:\Ruby\pik>jruby -v
jruby 1.6.1 (ruby-1.8.7-p330) (2011-04-12 85838f6) (Java HotSpot(TM) Client VM 1.6.0_24) [Windows XP-x86-java]
```

Para instalar gems, basta usar o comando `gem install` normalmente. A gem será instalada na versão atual do Ruby (ou seja, a que você selecionou com o comando `pik use`). O comando `pik gem` permite instalar uma gem em todas as versões:

```bat
C:\Ruby\pik>pik gem install mongo
jruby 1.6.1 (ruby-1.8.7-p330) (2011-04-12 85838f6) (Java HotSpot(TM) Client VM 1.6.0_24) [Windows XP-x86-java]

Fetching: bson-1.3.1-jruby.gem (100%)
Fetching: mongo-1.3.1.gem (100%)
Successfully installed bson-1.3.1-java
Successfully installed mongo-1.3.1
2 gems installed

ruby 1.8.7 (2011-02-18 patchlevel 334) [i386-mingw32]

Fetching: bson-1.3.1.gem (100%)
Fetching: mongo-1.3.1.gem (100%)
Successfully installed bson-1.3.1
Successfully installed mongo-1.3.1
2 gems installed
Installing ri documentation for bson-1.3.1...
Installing ri documentation for mongo-1.3.1...
Installing RDoc documentation for bson-1.3.1...
Installing RDoc documentation for mongo-1.3.1...

ruby 1.9.2dev (2010-05-31) [i386-mingw32]

Successfully installed bson-1.3.1
Successfully installed mongo-1.3.1
2 gems installed
Installing ri documentation for bson-1.3.1...
Installing ri documentation for mongo-1.3.1...
Installing RDoc documentation for bson-1.3.1...
Installing RDoc documentation for mongo-1.3.1...

```

O comando `pik ruby` permite executar um código em todas as versões instaladas, útil para verificar incompatibilidades entre as versões, como por exemplo [o construtor com parâmetros da classe Time]({% post_url 2011-03-01-representacao-de-data-e-hora-em-ruby-1-8-7-e-1-9 %}):

```bat
C:\Ruby\pik>pik ruby -e "puts Time.new('2011-01-01')"
jruby 1.6.1 (ruby-1.8.7-p330) (2011-04-12 85838f6) (Java HotSpot(TM) Client VM 1.6.0_24) [Windows XP-x86-java]

ArgumentError: wrong number of arguments (1 for 0)
  (root) at -e:1

ruby 1.8.7 (2011-02-18 patchlevel 334) [i386-mingw32]

-e:1:in `initialize': wrong number of arguments (1 for 0) (ArgumentError)
        from -e:1:in `new'
        from -e:1

ruby 1.9.2dev (2010-05-31) [i386-mingw32]

2011-01-01 00:00:00 -0200

```

Mais detalhes sobre o funcionamento do Pik podem ser encontrados no [Github do projeto](https://github.com/vertiginous/pik).
