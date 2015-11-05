---
layout: post
comments: true
title: "Livros técnicos traduzidos nunca mais"
date: 2009-07-16
tags: [Java, books, software engineering, portuguese]
---
Há alguns meses atrás, eu estava interessado no livro [Effective Java, segunda edição](http://java.sun.com/docs/books/effective/). A princípio, eu pretendia comprar na [Amazon](http://www.amazon.com/Effective-Java-Edition-Joshua-Bloch/dp/0321356683/ref=sr_1_1?ie=UTF8&qid=1387404215&sr=8-1&keywords=effective+java), mas decidi pesquisar antes. Pela internet, não achei o livro mais barato em nenhum lugar, mas acabei encontrando em uma livraria perto do trabalho por um precinho camarada. Só tinha um problema: era a [edição traduzida em português](http://altabooks.tempsite.ws/product_info.php?products_id=266&amp;osCsid=utme24t86q4r7au590cfrts1n4).

Inicialmente nem pensei em comprar a edição traduzida, pois acho que livros técnicos devem ser mantidos na língua original. Algumas pessoas que discordam disto argumentam que nem todos dominam o inglês, mas, sinceramente, se você tem dificuldades com inglês e quer estudar informática, procure um curso de inglês urgente! Por mais que você procure ler somente livros em português, em algum momento vai precisar consultar alguma documentação, referência ou fórum de discussão em inglês. Além disso, acho que nas traduções, por melhores que sejam, acaba-se perdendo um pouco do original (como num filme dublado, em que algumas piadas em inglês perdem completamente o sentido quando traduzidas), aumentando a possibilidade de erros e a dificuldade de compreensão do assunto. Num livro de programação então nem se fala, pois é muito comum utilizarmos muitos termos em inglês que não têm tradução para português - ou até tem, mas o original se popularizou tanto que é usado como se fosse uma palavra do nosso vocabulário.

Na época em que fiz essa pesquisa, o livro estava mais caro na Amazon do que hoje, e ainda tinha que incluir o frete. Aquela edição traduzida sairia por menos da metade. Além disso, eu não teria que esperar a entrega, era só dar um pulo na livraria e comprar. Decidi dar uma folheada no livro, só pra ver se tinha algum erro gritante de tradução, como trechos de código traduzidos - sim, eu já vi livros com aberrações como "calculaMédia", com acento mesmo. Como não encontrei nada de mais, acabei me deixando levar pela tentação de economizar uns trocados e comprando o livro traduzido.

Quando comecei a ler, achei a tradução muito boa. Nos primeiros capítulos, o único termo que machucou os ouvidos foi "encaixotamento automático" em vez de [autoboxing](http://java.sun.com/j2se/1.5.0/docs/guide/language/autoboxing.html) - por mais que esteja correto, esse é um daqueles termos que não se costuma traduzir. Além disso, os trechos de código foram mantidos originais, e abaixo de cada um há a tradução de cada linha de comentário. Achei um pouco desnecessário, porém interessante.

Ao chegar no capítulo 4, estranhamente os comentários nos códigos passaram a ser substituídos pelos traduzidos. Isso continua até o final do livro. Aparentemente a tradução foi feita por pessoas diferentes, e faltou uma revisão mais rigorosa no final. Porém, não é nada que atrapalhe. Mais adiante, vi uma citação a uma referência bibliográfica e resolvi verificar qual era o nome do livro referenciado. Descobri que **o livro não tinha bibliografia**! Obviamente isso é uma exclusividade da edição em português. Mais uma falha de revisão, e esta é mais grave.

Quando comecei a ler o capítulo 5, que fala sobre [generics](http://java.sun.com/j2se/1.5.0/docs/guide/language/generics.html), achei o trecho abaixo bem estranho:

> Antes da versão 1.5, essa teria sido uma declaração de coleção exemplar:

> ```java
/**
 * Minha coleção de selos. Contém apenas instâncias de Stamp.
 */
private final stamps = ...;
```

Não está faltando definir o tipo de `stamps`? Tudo bem, eu não devo ter entendido direito. Sigo a leitura e, um pouco mais à frente aparece o seguinte:

> Com os genéricos, você substituiria o comentário por uma declaração de tipo aperfeiçoada para a coleção que passaria ao compilador as informações que anteriormente ficariam ocultas no comentário:

> ```java
private final stamps = ...;
```

Ué, mudou alguma coisa? Não é exatamente igual ao código anterior? Resolvi pegar o livro original em inglês emprestado com um amigo, e vejo que nele aparecem os seguintes trechos:

> Before release 1.5, this would have been an exemplary collection declaration:

> ```java
// Now a raw collection type - don´t do this!

> /**
 * My stamp collection. Contains only Stamp instances.
 */
private final <strong>Collection</strong> stamps = ... ;
```

e

> With generics, you replace the comment with an improved type declaration for the collection that tells the compiler the information that was previously hidden in the comment:

> ```java
// Parameterized collection type - typesafe
private final <strong>Collection &lt;Stamp&gt;</strong> stamps = ... ;
```

Os destaques em negrito são do livro original. Aparentemente, tudo o que estava em negrito foi omitido na tradução! E, se estava em negrito, é porque é exatamente o trecho mais importante do código! Posteriormente, descobri que isso acontece em todo o capítulo 5. Do 6 em diante os códigos voltam ao normal e não encontrei mais nenhuma bizarrice, exceto a tradução de "thread" para "segmento".

Outro erro que se repetiu bastante no livro são as referências a números de páginas (ex: "veja a página 147"). Em todas as situações em que isso ocorre, o número da página que é referenciado é o do livro original, tornando a referência inútil na edição traduzida.

A conclusão que tirei dessa situação: livro técnico traduzido nunca mais! Os trocados que resolvi economizar com o livro acabaram saindo muito caros. Vale muito mais a pena investir um pouco mais no livro original - e num curso de inglês, caso você precise - para não ter dor de cabeça com livros mal traduzidos.
