---
layout: post
comments: true
title: "Resumo do Dev in Rio 2010"
date: 2010-10-29
tags: [eventos, Dev in Rio, HTML 5, Javascript, Nodejs, refactoring, Ruby]
---
No dia 09 de outubro aconteceu o [Dev in Rio 2010](http://www.devinrio.com.br/). Como [a edição de 2009 foi muito boa]({% post_url 2009-09-29-resumo-do-dev-in-rio %}), a expectativa para a deste ano era alta. E foi correspondida! Desta vez foram duas salas com palestras acontecendo simultaneamente. Eu fiquei na sala 2, onde assisti às seguintes palestras:

- HTML 5 e as novas JS APIs - [Leonardo Balter](http://yayquery.com.br/)

  Na primeira palestra foram apresentadas as principais APIs do HTML5. A palestra foi bem interessante, apesar de bastante prejudicada pela falta de WiFi no local, o que impediu que o palestrante mostrasse os vários exemplos que ele tinha preparado.

- NodeJS - a performance que eu sempre quis ter - [Emerson Macedo](http://codificando.com/)

  A palestra do Emerson foi excelente. Ele apresentou o problema de bloqueio de I/O no acesso a banco de dados, que é um dos principais gargalos no desempenho para a maioria das linguagens de programação. O [NodeJS](http://nodejs.org/) ajuda a resolver este problema pois usa Javascript, que é uma linguagem orientada a eventos. No final da apresentação, ele divulgou o [Nodecasts](http://nodecasts.org/), site de screencasts sobre NodeJS que ele acaba de criar. A apresentação está disponível no [blog do Emerson](http://codificando.com/2010/10/devinrio-nodecasts/).

- Lightning Talks

  Após o almoço, foi disponibilizado um horário para lightning talks, pequenas apresentações de 5 minutos para quem tivesse algo interessante para mostrar. Como o tempo foi curto, foram apenas duas apresentações: a primeira sobre desenvolvimento de aplicações Python para celular e outra sobre a Apache Foundation.

- Symfony - OO PHP para gente grande - [Luã de Souza](http://lsouza.pro.br/)

  Nesta palestra, foi apresentado o [Symfony](http://www.symfony-project.org/), um framework PHP para desenvolvimento web que vem crescendo bastante. É um framework MVC que, a exemplo de praticamente qualquer framework atual, inspira-se no Rails para simplificar o desenvolvimento de aplicações web.

- Refactoring - Porque apenas fazer funcionar não é o suficiente - [Caike Souza](http://caikesouza.com/)

  Esta foi uma das melhores palestras do evento. Caike Souza falou sobre refactoring - destacando que não existe refactoring sem testes -, apresentou as principais vantagens e alguns exemplos práticos em Ruby.

- Arquitetura: cansado da mesmice? - [Guilherme Silveira](http://blog.caelum.com.br/)

  Apesar do título não deixar claro, esta palestra foi direcionada a arquitetura com serviços Restful. Como todas as palestras dele, Guilherme Silveira foi bastante claro, mostrando as vantagens de uma arquitetura voltada para serviços, que vai além da simples troca de arquivos XML entre aplicações. Ele mostrou um exemplo bem interessante, sobre integração entre sites de viagens, reserva de hotéis e calendário, onde o compartilhamento de recursos permite que uma aplicação acesse diretamente os serviços de outra. Mais detalhes no [post que ele escreveu no blog da Caelum](http://blog.caelumobjects.com/2010/10/01/hypermedia-and-dependency-injection-a-lesson-not-to-be-forgotten/).

- Testes unitários em JavaScript: usar ou não usar mock? - Márcio Santana

  Na última palestra, foram apresentadas ferramentas para testes de código Javascript. Esta palestra também foi muito interessante, pois testes de Javascript são muito pouco comuns, mas não deveriam, já que Javascript também é código, e as aplicações web atuais possuem uma quantidade cada vez maior de código Javascript, principalmente para manipular interações com os usuários. Além do [QUnit](http://docs.jquery.com/Qunit) - framework para testar Javascript -, foram apresentadas bibliotecas de mock, como o [Chameleon](http://github.com/felipesilva/Chameleon).

Enquanto isso, na sala 1 ocorreram palestras sobre Arduino, empreendedorismo, Scum e Ruby.

Apesar de tudo, o evento teve alguns problemas de organização. Além da já citada indisponibilidade de WiFi, as duas salas ficavam em andares diferentes, e o coffee break era ao lado da sala 1, o que dificultava o deslocamento. Num determinado momento, a palestra da sala 2 terminou e todos desceram para o andar da sala 1 para o coffee break, porém não podíamos entrar, pois a palestra não havia terminado. Apesar destes pequenos problemas, o Dev in Rio deste ano manteve a qualidade da primeira edição. Agora, ficamos aguardando a edição de 2011!
