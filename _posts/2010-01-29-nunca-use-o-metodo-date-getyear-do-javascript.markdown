---
layout: post
comments: true
title: "Nunca use o método Date.getYear() do Javascript"
date: 2010-01-29
tags: [Javascript, JSF, Opera, browsers, Tomahawk]
---
Até a década de 1990, era muito comum escrevermos datas com apenas 2 dígitos representando o ano (ex: 1996 -> 96). Como todos já sabem, esta prática levou ao famoso [bug do milênio](http://pt.wikipedia.org/wiki/Problema_do_ano_2000), pois, desta forma, o ano 2000 tornava-se 0 (ou 100, dependendo do caso), gerando uma série de problemas, especialmente em códigos que calculavam um período entre duas datas. Felizmente, hoje em dia não temos mais esta preocupação. Ou temos?

Outro dia fui testar um sistema em diversos browsers, e ao realizar o teste no [Opera](http://www.opera.com/), verifiquei que o componente [inputCalendar](http://myfaces.apache.org/tomahawk-project/tomahawk12/tagdoc/t_inputCalendar.html) do [Tomahawk](http://myfaces.apache.org/tomahawk/) abria no ano de 3910. Testei no Firefox, Google Chrome e Internet Explorer 6, 7 e 8, e todos eles funcionavam corretamente. Resolvi olhar o código fonte do componente, e descobri que ele verificava o ano atual usando o método getYear da classe [Date](http://www.w3schools.com/jsref/jsref_obj_date.asp). Este método é fonte de diversos problemas e gambiarras em códigos Javascript que manipulam datas. O motivo é que diferentes browsers interpretam o método de maneiras diferentes. De acordo com a [especificação ECMA-262](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-262.pdf), a função getYear deveria retornar o ano atual menos 1900. Nas versões mais recentes, o Firefox e o Google Chrome seguem esta especificação, retornando 110 para o ano de 2010. Já o Opera e o IE retornam 2010, contrariando a especificação e gerando os problemas já conhecidos. É muito comum encontrarmos códigos que verificam qual é o browser (com [comentários condicionais](http://www.quirksmode.org/css/condcom.html) ou [verificações por Javascript](http://www.dynamicdrive.com/forums/showthread.php?t=1057)) e, quando não for o IE, somando 1900 ao valor retornado pelo getYear. Esta verdadeira gambiarra não resolve completamente, pois, como já citado, o Opera se comporta da mesma forma que o IE.

A solução ideal para este problema é substituir o método getYear por getFullYear. Este método retorna o ano completo, com 4 dígitos, em todos os browsers, eliminando qualquer necessidade de verificação de browser. Esta recomendação, inclusive, faz parte da [especificação ECMA-262](http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-262.pdf), na página 242:

> The getFullYear method is preferred for nearly all purposes, because it avoids the "year 2000 problem."

Após corrigir este bug do Tomahawk, [abri uma issue no Jira do projeto](http://issues.apache.org/jira/browse/TOMAHAWK-1480), anexando um patch para corrigir o problema.

Outras Referências:

- [Javascript getYear fix](http://www.electrictoolbox.com/javascript-getyear-fix/)
- [getYear. No, not that year!](http://my.opera.com/hallvors/blog/show.dml/738966)
