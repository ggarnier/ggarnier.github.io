---
layout: post
comments: true
title: "Solução de problema com o Flash Player no Ubuntu com Firefox >= 3.6.4"
date: 2010-08-06
tags: [Firefox, Flash, Ubuntu, Linux]
---
Desde a versão 3.6.4, o Firefox possui um recurso chamado [Crash protection](https://wiki.mozilla.org/Firefox/Crash_Protection) (somente para Windows e Linux). Agora o browser cria um processo à parte chamado `plugin-container` para execução dos plugins do Flash, QuickTime e Silverlight. O objetivo é impedir que um erro na execução de um destes plugins trave o browser - caso isto ocorra, somente o plugin será interrompido.

Depois que atualizei o Firefox para esta versão - na verdade, atualizei diretamente do 3.6.3 para o 3.6.6 - no Ubuntu 10.04, o Flash simplesmente parou de funcionar, exibindo a mensagem ["The Adobe Flash plugin has crashed"](http://support.mozilla.com/en-US/kb/The+Adobe+Flash+plugin+has+crashed). Tentei reinstalar o Flash diversas vezes, tanto pelos pacotes `adobe-flashplugin` e `flashplugin-installer` usando o apt-get quando baixando um arquivo .deb diretamente. A página [plugin check](http://www.mozilla.com/pt-BR/plugincheck/) informava que o Flash estava instalado, porém com uma versão desatualizada (9.x). Também tentei reinstalar o Firefox e nada.

Depois de alguns dias de tentativas frustradas, finalmente tive a ideia de testar com outro browser. Pelo Chrome o Flash funcionava perfeitamente, ou seja, o problema estava diretamente relacionado com o Firefox.

Após mais algumas pesquisas, encontrei o artigo [Plugin-container and out-of-process plugins](http://kb.mozillazine.org/Plugin-container_and_out-of-process_plugins). Descobri que há um parâmetro na configuração do Firefox (digite `about:config` na barra de endereços para acessá-la) chamado `dom.ipc.plugins.enabled` que permite habilitar ou desabilitar o crash protection para plugins de terceiros. Este parâmetro serve para qualquer plugin não especificado, e o valor padrão é `false`. Há um parâmetro específico para o plugin do Flash: no Linux é o `dom.ipc.plugins.enabled.libflashplayer.so`, e no Windows é `dom.ipc.plugins.enabled.npswf32.dll`. Este parâmetro tem o valor padrão `true`; depois que mudei para `false`, o Flash passou a funcionar na maioria dos sites; porém, os [vídeos da Globo.com](http://video.globo.com), por exemplo, continuaram não funcionando, mas passaram a exibir uma mensagem dizendo que o Flash estava desatualizado.

Para descobrir mais informações sobre os plugins, digitei `about:plugins` na barra de endereços. [A página que apareceu](http://kb.mozillazine.org/About:plugins) mostrou duas versões de Flash instaladas: uma era a mais recente (10.x) e a outra estava desatualizada (9.x). Porém, esta tela não mostrava a localização de cada plugin. Para descobrir o path completo para cada plugin, voltei para a tela de configuração (`about:config`) e alterei o valor do parâmetro `plugin.expose_full_path` para `true`. Agora, a tela do `about:plugins` passa a exibir o path de cada plugin instalado.

Desta forma, descobri que havia uma versão mais antiga do Flash instalada no meu home (em `/home/guilherme/.mozilla/plugins/libflashplayer.so`). Não sei a ordem em que o Firefox procura os plugins, mas aparentemente este estava sendo utilizado em vez do mais atual, que fica em `/usr/lib/flashplugin-installer/libflashplayer.so`. Removi a versão que estava no home e o Flash voltou a funcionar perfeitamente, inclusive depois de reativar o crash protection.

Outras referências úteis não citadas:

- [Flash - MozillaZine Knowledge Base](http://kb.mozillazine.org/Flash)
- [Managing the Flash plugin ](http://support.mozilla.com/pt-BR/kb/Managing+the+Flash+plugin?bl=n)
