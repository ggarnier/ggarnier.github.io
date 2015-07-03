---
layout: post
comments: true
title: "Vídeos com HTML 5 e a nova guerra dos browsers"
date: 2010-02-22
categories: [HTML 5, Firefox, Internet, videos]
---
No final do século 20, a disputa entre os dois browsers mais populares da época, Netscape e Internet Explorer, ficou conhecida como [guerra dos browsers](http://pt.wikipedia.org/wiki/Guerra_dos_browsers). Nos últimos anos, após um período negro de domínio do IE, outros browsers começaram a crescer e recuperar o espaço que era ocupado pelo falecido Netscape.

Mais recentemente, desde o ano passado, os browsers mais modernos começaram a dar suporte ao HTML 5 - [o Firefox, por exemplo, suporta desde a versão 3.5](http://blog.guilhermegarnier.com/2009/07/03/suporte-a-html-5-no-firefox-3-5/). Entre diversas novidades, o recurso mais popular do HTML 5 é a tag _<video>_, que permite a execução de vídeos sem o uso de plugins. A imensa maioria dos sites de vídeo usam Flash, que é uma tecnologia proprietária, e não é suportada em plataformas como o iPhone/iPod Touch. Porém, juntamente com esta nova tag surgiu uma polêmica.

No mês passado, o [Youtube](http://www.youtube.com/) - seguido posteriormente por outros sites de vídeos - [anunciou que começaria a oferecer vídeos em HTML 5](http://youtube-global.blogspot.com/2010/01/introducing-youtube-html5-supported.html), porém usando o codec [H.264](http://en.wikipedia.org/wiki/H.264). Apesar de suportar HTML 5, o Firefox não tem suporte a este codec, pelo fato de ele ser proprietário, e exigir o pagamento de licenças caríssimas. O Firefox suporta somente o codec [OGG Theora](http://en.wikipedia.org/wiki/Theora), que é open source. Esta atitude do Youtube criou uma grande polêmica: por que eles deixariam de usar uma tecnologia proprietária (Flash) para adotar outra igualmente proprietária (H.264)? O uso de HTML 5 deixa a impressão de que o Youtube partiu para tecnologias abertas, mas isto não ocorreu, devido ao codec escolhido.

Enquanto isso, o Safari (incluindo aí o iPhone) suporta o codec H.264, mas não suporta Theora; o Google Chrome suporta ambos os formatos; o Opera começará a suportar vídeos com codec Theora a partir da versão 10.50; e o IE 8 nem suporta HTML 5, criando um cenário totalmente heterogêneo. Um dos problemas desta divisão é que começamos a nos distanciar da padronização - que é o objetivo principal do [W3C](http://www.w3.org/) - e criar um ambiente onde cada browser suporta diferentes formatos de vídeo, retornando à época da guerra dos browsers, onde dificilmente uma página era igualmente visualizada no IE e no Netscape. Outro problema é que, como o Firefox não consegue exibir os vídeos em HTML 5 do Youtube, muita gente diz erradamente que o Firefox não suporta HTML 5, quando na verdade é um problema de codec.

A solução para os desenvolvedores é oferecer seus vídeos em mais de um formato, multiplicando, desta forma, o espaço necessário e o trabalho de codificação dos vídeos. O [Video For Everybody](http://camendesign.com/code/video_for_everybody) ajuda a resolver este problema, oferecendo um trecho de código HTML que deixa a cargo do browser a escolha da opção mais adequada - se o browser suportar HTML 5 e Theora, este vídeo será exibido; se suportar HTML 5 e H.264, usará este formato; caso contrário, usará o plugin de Flash ou QuickTime, caso estejam instalados. Em último caso, exibe uma imagem do vídeo com um link para download. Esta solução exige o armazenamento do vídeo em dois formatos, mas parece uma boa solução diante de tantas variantes.

Referências:

- [Dive Into HTML5 - Video on the Web - What Works on the Web](http://diveintohtml5.org/video.html#what-works)
- [The Dark Side of HTML 5 Video](http://www.sitepoint.com/blogs/2010/01/25/the-dark-side-of-html-5-video/)
