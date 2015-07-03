---
layout: post
comments: true
title: "Sprites automáticos com Compass"
date: 2012-07-26
categories: [Ruby, Rails, CSS, SASS, sprites, Compass]
---
Um dos temas mais atuais no desenvolvimento web é a [otimização de sites](http://blog.caelum.com.br/por-uma-web-mais-rapida-26-tecnicas-de-otimizacao-de-sites/). A motivação para reduzir o tempo de carregamento das páginas vem não só de estudos que mostram que [quando maior o tempo de carregamento, maior o número de usuários que abandonam o site](http://www.webperformancetoday.com/2010/06/15/everything-you-wanted-to-know-about-web-performance/), mas também do fato de que [o Google considera o tempo de resposta na criação do PageRank](http://googlewebmastercentral.blogspot.com.br/2010/04/using-site-speed-in-web-search-ranking.html).

Um dos itens mais importantes ao otimizar um site, [de acordo com Steve Souders](http://developer.yahoo.com/blogs/ydn/posts/2007/04/rule_1_make_few/), é diminuir o número de requests. Um recurso muito útil para isso é a criação de sprites, ou seja, um único arquivo contendo várias imagens que são utilizadas no site. Nos locais que fazem referência a estas imagens, são definidos a largura, altura e offset do sprite. Desta forma, é feito um único request para obter todas as imagens. O uso de sprites é muito comum em [grandes sites como Twitter, Facebook, Google e Yahoo](http://en.webmolot.com/sprite-2/).

A criação de um sprite manualmente é uma tarefa bem trabalhosa. É necessário criar uma imagem utilizando uma ferramenta como o Photoshop, por exemplo, e colar cada imagem uma abaixo (ou ao lado) da outra, deixando alguns pixels entre imagens. Sempre que se quiser adicionar uma nova imagem, será necessário abrir o sprite novamente no Photoshop e repetir o processo para inserir a nova imagem.

Para simplificar esta tarefa, é possível utilizar uma ferramenta para geração automática de sprites. Uma das melhores ferramentas para isso é o [Compass](http://compass-style.org/). Após instalar e configurar, basta colocar as imagens num diretório e o sprite será gerado automaticamente. A instalação num projeto Rails é extremamente simples, e está bem explicada no [help do Compass](http://compass-style.org/help/).

A configuração básica do Compass para geração de sprites segue o padrão abaixo:

```ruby
$imagens-spacing: 2px
$imagens-sprite-dimensions: true
@import "imagens/*.png"
```

No exemplo acima, todas as propriedades são configuradas com o prefixo _imagens_. O sprite é configurado com espaçamento de 2 pixels entre cada imagem, para evitar sobreposição no limite entre as imagens. A segunda linha habilita a inclusão das dimensões das imagens no CSS gerado, o que é útil para manter fixo o tamanho ocupado pela imagem enquanto ela é carregada. A terceira linha informa quais imagens serão adicionadas. Neste caso, são todas as imagens com extensão png que estão no diretório _imagens_. É importante lembrar que o nome deste diretório deve ser igual ao prefixo utilizado nas propriedades.

Além de gerar o sprite, o Compass cria classes CSS para referenciar cada imagem. Os nomes das classes começam com o prefixo utilizado acima, seguido por hífen e o nome da imagem sem extensão. Por exemplo, para uma imagem chamada _excluir.png_, a classe teria o nome _imagens-excluir_.

O uso as imagens do sprite no seu CSS pode ser feito de duas formas: usando diretamente as classes criadas pelo Compass (como _imagens-excluir_, no exemplo anterior) ou utilizando um mixin do Compass no seu arquivo [Sass](http://sass-lang.com/):

```css
.minha-classe { @include imagens-sprite(excluir); }
```

Ao utilizar uma destas configurações, a imagem será configurada como background do elemento.

Para criar um segundo sprite, para a parte administrativa da aplicação, por exemplo, é necessário utilizar um prefixo diferente, como no exemplo abaixo:

```ruby
$imagens-admin-spacing: 2px
$imagens-admin-sprite-dimensions: true
@import "admin/imagens-admin/*.png"
```

Neste exemplo, as imagens do sprite estão no diretório _admin/imagens-admin_, e o prefixo segue o nome do último diretório (_imagens-admin_). Isso significa que, no exemplo acima, não seria possível manter o sprite do admin em _admin/imagens_, pois haveria conflito de nomes com o outro sprite.

Os sprites gerados pelo Compass são arquivos png que tem como nome o prefixo utilizado na configuração seguido por um hash (ex: _imagens-b03bdb7a79370e7ff107e7b37fe7df6e.png_). Quando o sprite é modificado (em ambiente de desenvolvimento o Compass verifica automaticamente a cada request se alguma imagem foi adicionada ou removida, e em produção é necessário executar um `rake task` para isso), o Compass gera um novo hash para o nome do arquivo. Isto é feito para evitar que o sprite seja cacheado pelo browser. Se isso acontecesse, o browser não buscaria o sprite atualizado, mantendo o arquivo anterior.

Os exemplos descritos acima descrevem apenas as configurações básicas para geração de sprites. A [documentação de sprites](http://compass-style.org/help/tutorials/spriting/) traz mais detalhes sobre as opções de configuração. Além disso, o Compass tem muitas outras funcionalidades. Vale a pena pesquisar a [referência no site do Compass](http://compass-style.org/reference/compass/) para mais detalhes.

**UPDATE:** outra configuração útil para os sprites é o [layout das imagens](http://compass-style.org/help/tutorials/spriting/sprite-layouts/). Por padrão, o layout dos sprites é vertical, ou seja, cada imagem é colocada abaixo da anterior. Porém, o Compass também permite definir layout horizontal, diagonal ou smart. Neste último, a disposição das imagens é feita de acordo com o tamanho de cada uma, e o resultado é uma imagem menor do que com o layout padrão. No meu projeto, ao trocar o layout vertical pelo smart, o sprite ficou cerca de 10% menor. No primeiro exemplo deste post, a configuração do layout ficaria assim:

```ruby
$imagens-layout: smart
```
