---
layout: post
comments: true
title: "Migrando do Delicious para o Google Bookmarks"
date: 2011-01-12
categories: [Delicious, Google, Firefox, Bookmarks, Chrome]
---
Alguns anos atrás, comecei a sentir necessidade de manter meus bookmarks sincronizados entre os diversos computadores que eu utilizava. Até que conheci o [Delicious](http://www.delicious.com). Isso foi em 2007, e desde então eu comecei a usá-lo constantemente. Cada vez que eu usava o Firefox em algum computador pela primeira vez, a primeira extensão que eu instalava era [a do Delicious](https://addons.mozilla.org/en-US/firefox/addon/3615/). Através desta extensão, um simples Control+D abre a janela para adicionar a página atual ao seus bookmarks do Delicious, e Control+B abre a barra lateral com seus bookmarks, organizados por tags.

Há alguns meses, eu havia pensado em migrar meus bookmarks para o [Google Bookmarks](http://www.google.com/bookmarks), mas desisti, pois eu já estava bastante acostumado com o Delicious. Até que no início de dezembro veio a bomba: o Yahoo, que havia comprado o Delicious em 2005, [anunciou que encerraria o serviço](http://techcrunch.com/2010/12/16/is-yahoo-shutting-down-del-icio-us/)! Imediatamente comecei a pensar em alternativas, e o Google Bookmarks foi minha primeira opção. Alguns dias depois, o [Yahoo voltou à cena informando que iria vender, e não fechar o serviço](http://techcrunch.com/2010/12/17/yahoo-trying-to-sell-del-icio-us-not-to-shut-it-down/), e o próprio [Delicious publicou uma nota sobre o assunto](http://blog.delicious.com/blog/2010/12/whats-next-for-delicious.html). Mas, mesmo assim, para mim foi a deixa para fazer a migração para outro serviço. Apesar de existirem [várias alternativas ao Delicious](http://bookshop.livejournal.com/1080038.html), escolhi o Google Bookmarks pela simplicidade, e por já estar integrado à minha conta no Google.

A primeira parte da migração foi fácil: exportar os bookmarks do Delicious, através da opção Settings -> [Export/Backup Bookmarks](https://secure.delicious.com/settings/bookmarks/export). Para [importá-los no Google Bookmarks](http://www.google.com/support/bookmarks/bin/answer.py?answer=178166), uma das maneiras mais simples é importar os bookmarks do Delicious no Firefox e sincronizá-los com o [Google Toolbar](http://www.toolbar.google.com/). Também é possível fazer a importação usando o [Google Chrome](http://www.google.com/chrome), ou usar algum script (como [este](http://blog.darkhax.com/2010/12/16/import-delicious-to-google-bookmarks)) ou serviço, como o [del.icio.us to Google Bookmarks](http://delicious-export.appspot.com/).

Em seguida, procurei as opções para integração com o browser (adicionar e pesquisar nos bookmarks). No Firefox existem diversas extensões para Google Bookmarks. Testei algumas, e a que achei melhor foi o [GMarks](https://addons.mozilla.org/pt-BR/firefox/addon/2888/). Com ela, é possível adicionar bookmarks com Control+D, de forma bem semelhante à extensão do Delicious, e também há uma barra lateral, acionada com Alt+M. Porém, não há integração com a barra de endereços, ou seja, não é possível pesquisar nos bookmarks digitando diretamente o endereço (como permitem as versões mais recentes da extensão do Delicious). Porém, há duas maneiras de pesquisar (além de acessar diretamente a página do Google Bookmarks para fazer a pesquisa):

1. Ao digitar a tecla Home duas vezes, aparecerá uma caixa de texto para pesquisa. É só digitar qualquer coisa e depois escolher um resultado e apertar Enter (ou Alt+Enter para abrir em outra aba)
1. Criando um atalho para a busca: acesse o [Google Bookmarks](https://www.google.com/bookmarks), clique com o botão direito sobre o campo de busca e selecione a opção "Add a keyword for this search". O Firefox adicionará a pesquisa nos bookmarks locais, e você poderá adicionar um keyword a este bookmark. Digite "gb", por exemplo, e clique em OK. Agora, ao digitar qualquer texto precedido desta keyword na barra de endereços (por exemplo: "gb teste"), o Firefox pesquisará este texto no Google Bookmarks. Mas os resultados não aparecem diretamente, você precisa escolher a opção "Search Google Bookmarks" entre as sugestões que aparecem

Para [integrar o Google Bookmarks ao Chrome](http://metaed.blogspot.com/2008/12/using-google-bookmarks-in-google-chrome.html) é ainda mais simples, pois não é necessário instalar qualquer extensão (afinal, ambos são do Google). Para adicionar bookmarks, acesse a [página de ajuda](http://www.google.com/support/chrome/bin/answer.py?hl=en&answer=100215). Ela disponibiliza um botão que pode ser arrastado para a barra de bookmarks, e ao clicar nele, a página atual será adicionada. Para adicionar a pesquisa no Google Bookmarks à barra de endereços, clique na barra com o botão direito, selecione "Edit search engines" e adicione um novo, com as seguintes configurações:

**Nome:** Google Bookmarks

**Keyword:** gb

**URL:** http://google.com/bookmarks/find?&q=%s

Agora, a pesquisa integrada à barra de endereços funcionará da mesma forma que no Firefox ("gb texto para pesquisa").
