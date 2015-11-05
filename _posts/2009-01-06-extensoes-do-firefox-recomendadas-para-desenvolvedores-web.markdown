---
layout: post
comments: true
title: "Extensões do Firefox recomendadas para desenvolvedores web"
date: 2009-01-06
tags: [Firefox, debug, CSS, Internet, Javascript, Greasemonkey, Firebug, portuguese]
---
Quase todo usuário de Firefox que tem um blog já postou uma lista de extensões recomendadas. Chegou a minha vez! Sei que muitas aqui já são velhas conhecidas da maioria, mas acho interessante ressaltar a importância. Hoje em dia é difícil imaginar o desenvolvimento web sem o auxílio do Firefox. Segue abaixo a lista de extensões que eu recomendo:

- [Firebug](https://addons.mozilla.org/en-US/firefox/addon/1843)

    Como não poderia deixar de ser, o primeiro da lista, e totalmente indispensável, é o Firebug. Seria até exagero chamá-lo de extensão, pois o Firebug é uma verdadeira plataforma para debug de aplicações web. Com ele é possível, além de inspecionar visualmente o código HTML, seja diretamente pelo código, seja selecionando o componente visual associado a ele, é possível modificar o código, alterando, excluindo ou incluindo tags, e o resultado aparece em tempo real. O mesmo pode ser feito com os códigos Javascript e CSS da página. Há também um console para debug; é possível utilizar o comando `console.log("texto")` no seu código Javascript, e durante a execução, o texto será exibido no console do Firebug. Também é possível visualizar o resultado de todas as requisições, incluindo arquivos carregados (imagens, arquivos CSS, Javascript e Flash) e chamadas assíncronas (Ajax), exibindo o cabeçalho da requisição, o resultado, o tamanho do arquivo e o tempo de resposta. Esta extensão é tão poderosa que há extensões para ela, como o [YSlow](https://addons.mozilla.org/en-US/firefox/addon/5369), do Yahoo, que exibe estatísticas de desempenho da página.

    Como o Firebug é só para Firefox, foi lançada uma [versão Lite](http://getfirebug.com/lite.html) que também funciona com IE, Opera e Safari. Nunca testei esta versão, porém acredito que seja uma boa alternativa para debugar problemas que aconteçam num destes browsers mas não no Firefox. Nesse mesmo link é disponibilizada uma versão do Firebug Lite como bookmarklet. Basta arrastar o link para a barra de bookmarks do Firefox para poder utilizá-lo sem precisar instalar o Firebug.

- [Web Developer](https://addons.mozilla.org/en-US/firefox/addon/60)

    Esta extensão é uma das mais úteis no desenvolvimento web. Entre as opções disponíveis, ela permite visualizar o CSS da página, cookies, bloquear imagens e muitas outras funções.

- [Poster](https://addons.mozilla.org/en-US/firefox/addon/2691)

    O Poster é uma extensão simples, porém muito útil para testar Web Services. Ele exibe uma janela com opções para digitar a URL de destino, o tipo de requisição (GET, POST, PUT ou DELETE), o body e os parâmetros. Feita a requisição, é possível visualizar a resposta recebida.

- [JavaScript Debugger](https://addons.mozilla.org/en-US/firefox/addon/216)

    Extensão muito poderosa, que exibe uma janela listando todos os arquivos Javascript da página atual. Pode-se definir breakpoints no código e executá-lo passo a passo, verificar e alterar valores de variáveis e tudo o que se espera de uma ferramenta de debug.

    <a href="/images/firefox-javascript_debugger.png" class="post-image-link">![Javascript Debugger](/images/firefox-javascript_debugger.png)</a>

- [Greasemonkey](https://addons.mozilla.org/en-US/firefox/addon/748)

    Uma das extensões mais conhecidas, permite criar scripts usando Javascript para modificar o comportamento de sites específicos. O site [Userscripts.org](http://userscripts.org/) possui centenas de scripts pré-definidos para vários sites conhecidos. Com o Greasemonkey, você pode até mesmo [ajudar a Vivo a adicionar suporte a HTML no Firefox]({% post_url 2008-12-23-ajude-a-vivo-a-adicionar-suporte-a-html-no-firefox %}).

- [Greasefire](https://addons.mozilla.org/en-US/firefox/addon/8352)

    Extensão que adiciona ao Greasemonkey uma funcionalidade de busca automática de scripts para o domínio atual no [Userscripts.org](http://userscripts.org/). Ao clicar no ícone do Greasemonkey, aparece uma nova opção no menu, que, ao ser selecionada, exibe em uma nova janela a lista de scripts encontrados.

- [CSSViewer](https://addons.mozilla.org/en-US/firefox/addon/2104)

    O CSSViewer exibe todas as propriedades CSS dos elementos da página atual num div flutuante, conforme o cursor do mouse é movido pela tela.

- [X-Ray](https://addons.mozilla.org/en-US/firefox/addon/1802)

    Mais uma extensão simples e útil. O X-Ray permite visualizar o código fonte de uma página sobre a própria. Desta forma, as tags HTML se misturam aos elementos da página, permitindo visualizar exatamente onde se localiza cada elemento do fonte, apesar de a visualização ficar um pouco confusa.

- [Live HTTP Headers](https://addons.mozilla.org/en-US/firefox/addon/3829)

    Exibe numa janela os cabeçalhos HTTP de cada requisição, auxiliando na verificação de erros de rede. As informações dos cabeçalhos também podem ser exibidas numa barra lateral, e as URLs das requisições que serão analisadas podem ser definidas como expressões regulares.

    <a href="/images/firefox-live_http_headers.png" class="post-image-link">![Live HTTP Headers](/images/firefox-live_http_headers.png)</a>

- [Aardvark](https://addons.mozilla.org/en-US/firefox/addon/4111)

    Esta extensão permite excluir elementos da página com um clique. É muito útil para acessar sites muito poluídos, com excesso de elementos na tela, ou quando há algum elemento sobrepondo outro, no caso de erros de visualização de sites que não foram testados no Firefox. Também pode ser utilizado para remover elementos desnecessários antes de imprimir uma página.

- [MeasureIt](https://addons.mozilla.org/en-US/firefox/addon/539)

    Exibe uma régua para contagem de pixels de um elemento. Útil para ajustes finos no design.

- [JSView](https://addons.mozilla.org/en-US/firefox/addon/2076)

    Exibe um ícone no rodapé do Firefox. Ao clicar nele, é possível visualizar automaticamente todos os arquivos CSS e Javascript da página atual. Pouco útil caso você já utilize o Firebug.

- [ErrorZilla Mod](https://addons.mozilla.org/en-US/firefox/addon/3336)

    Quando uma página estiver inacessível, esta extensão exibirá uma tela alternativa de erro, com opções para consultar esta página no Google Cache, tentar ping e trace, entre outras opções.

    <a href="/images/firefox-errorzilla.png" class="post-image-link">![ErrorZilla Mod](/images/firefox-errorzilla.png)</a>

- [CheckBoxMate](http://dragtotab.mozdev.org/checkboxmate/)

    Permite marcar vários checkboxes de uma vez, através de drag &amp; drop. Esta extensão não tem qualquer relação com desenvolvimento web, mas resolvi incluir na lista pois acredito que pode ser útil, por exemplo, quando se deseja selecionar vários emails no seu webmail.

- [Stylish](https://addons.mozilla.org/en-US/firefox/addon/2108)

    Praticamente um Greasemonkey para CSS. Permite criar folhas de estilo para URLs específicas e pesquisar no [Userstyles.org](http://userstyles.org/) por estilos pré-definidos para o domínio atual.

- [ColorZilla](https://addons.mozilla.org/en-US/firefox/addon/271)

    Permite descobrir o código RGB da cor do elemento atual, fazer zoom de até 1000% na página (para facilitar a seleção de um elemento específico) e selecionar cores numa paleta, entre outras opções.

- [PDF Download](https://addons.mozilla.org/en-US/firefox/addon/636)

    Converte páginas Web para PDF, além de permitir selecionar a ação desejada ao clicar em um arquivo PDF (download, abrir com o programa padrão, abrir no browser).

Além de muitas extensões úteis, existem outras nem tanto. A extensão mais inútil para Firefox, na minha opinião, é o [Fast Close Tabs](https://addons.mozilla.org/en-US/firefox/addon/9893): você acha irritante ter que clicar no X à direita de uma aba para fechá-la? Com esta extensão, você pode fechá-la clicando no X da própria janela do Firefox!

Finalizando, um site que acho muito interessante é o [Firefox Facts](http://www.firefoxfacts.com/), que traz muitas dicas sobre o Firefox, principalmente sugestões de novas extensões e temas.
