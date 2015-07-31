---
layout: post
comments: true
title: "Feeds autenticados no Google Reader"
date: 2009-07-31
tags: [Google Reader, feed, Internet]
---
Há muito tempo eu uso o [Google Reader](http://www.google.com.br/reader/) como leitor de feeds. A principal vantagem sobre as demais alternativas para desktop é o fato de não necessitar de instalação, podendo ser acessado diretamente pelo browser.

Outro dia, tentei cadastrar o feed do [Twitter](http://twitter.com/) no Google Reader, e recebi a seguinte mensagem: "Sorry, an unexpected condition has occurred which is preventing Google Reader from fulfilling the request". Tentei acessar o feed diretamente no Firefox, e, após solicitação de login e senha, os feeds apareceram normalmente. Após uma rápida pesquisa, descobri que o Google Reader não suporta feeds autenticados, o que é o caso do Twitter.

Uma das alternativas a este problema seria utilizar um leitor de feeds que suporta autenticação, como a extensão [NewsFox](http://newsfox.mozdev.org/) para Firefox ou [algum outro](http://getsatisfaction.com/twitter/topics/rss_feeds_down#reply_510009). Porém, para poder continuar utilizando o Google Reader, uma solução é o [FreeMyFeed](http://freemyfeed.com/), um serviço que funciona como uma espécie de proxy para feeds autenticados: você informa a URL, o login e a senha do feed que exige autenticação, e ele gera um novo endereço de feed que permite acesso direto, inclusive pelo Google Reader.
