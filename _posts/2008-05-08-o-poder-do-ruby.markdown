---
layout: post
comments: true
title: "O poder do Ruby"
date: 2008-05-08
categories: [Ruby, linguagens de programação, algoritmos]
---
Muito se fala das vantagens do Ruby sobre muitas das linguagens atuais, por ser uma [linguagem de altíssimo nível](http://darynholmes.wordpress.com/2008/04/07/very-high-level-language-%E2%80%93-so-what/). Mas muitas vezes não percebemos grandes diferenças entre as linguagens, além das usuais diferenças de sintaxe - se as linhas de comando precisam de ponto-e-vírgula no final, se as variáveis precisam de $ no início do nome, se estas são tipadas ou não, se precisam ser declaradas ou não, etc. Porém, em algumas situações específicas, enxergamos o verdadeiro poder do Ruby.

Hoje precisei implementar uma paginação de resultados de busca. Eu sei que existem plugins para Rails que [simplificam esta tarefa](http://errtheblog.com/posts/47-i-will-paginate), porém como esta busca não é feita no banco de dados, e sim através de um indexador que já retorna resultados paginados, optamos por fazer manualmente a lista de links para as páginas.

Por exemplo: ao realizar uma busca, são exibidos os 10 primeiros resultados, com um link para a próxima página e a lista de links para cada página. Como o número de páginas, teoricamente, não tem limite, fiz o seguinte:

- caso o resultado tenha até 10 páginas, todas são exibidas
- caso o resultado tenha mais de 10 páginas, são exibidas apenas 10, sendo que:
  - caso a página atual seja uma das 6 primeiras, exibe os links para as páginas 1 a 10
  - caso a página atual seja maior que 6, exibe da página atual - 5 até a página atual + 4
  - caso a página atual seja uma das 10 últimas, exibe as 10 últimas

Pela descrição acima, percebemos que é uma lógica bem simples, porém meio chata para ser implementada - na maioria das linguagens atuais, isto exigiria um grande número de if's aninhados, para verificarmos se as condições descritas acima são atendidas. Porém, em Ruby o código ficou muito simples e enxuto:

```ruby
if (num_pages > 1)
  page_start = [1, page-5].max
  page_end = [num_pages, page+4].min
  if num_pages > 10
    page_start = [page_start, num_pages-9].min
    page_end = [page_end, 10].max
  end
  page_start.upto(page_end) {|p|
    # Exibe os links
  }
end
```
