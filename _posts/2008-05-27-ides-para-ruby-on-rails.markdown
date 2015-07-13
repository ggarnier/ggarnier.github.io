---
layout: post
comments: true
title: "IDEs para Ruby on Rails"
date: 2008-05-27
categories: [Ruby, Rails, IDE]
---
O uso de IDEs para desenvolvimento em Rails é um assunto bastante controverso. Devido às diversas facilidades no desenvolvimento com este framework, muitas pessoas afirmam que uma IDE não é necessária, basta um editor de textos simples e um terminal. Outros acreditam que, apesar do alto grau de automação do Rails, ainda é vantajoso usar uma IDE. No meio desta discussão, acredito que, no caso do Ruby on Rails, a escolha torna-se um gosto pessoal.

Para os que estão no primeiro caso, a escolha do editor de texto também é uma questão de gosto pessoal. Alguns se sentem confortáveis com o vi, outros com o Emacs. Estes casos são mais comuns quando já há uma intimidade com estes editores - dificilmente alguém vai aprender a usar Emacs para desenvolver em Rails. Para quem prefere um editor mais amigável, há opções para todos os sistemas operacionais: no Linux, o [Gedit](http://www.gnome.org/projects/gedit/), quando bem configurado com alguns dos diversos plugins disponíveis, torna-se uma poderosa ferramenta de desenvolvimento, com code completion, por exemplo. No Mac há o [TextMate](http://macromates.com/) e no Windows o [SciTe](http://www.scintilla.org/SciTE.html) (também disponível para Linux). Para tarefas como rodar o servidor web, executar migrations e generates, debugar a aplicação ou trabalhar com uma ferramenta de controle de versão (CVS, SVN, GIT, etc), usa-se o terminal.

Para quem prefere usar uma IDE, a principal vantagem é não precisar recorrer ao terminal para executar as tarefas acima. Tudo é integrado, facilitando o trabalho. Realmente algumas dessas tarefas são extremamente simples, como executar migrations. Nestes casos, pouca diferença há entre usar a IDE ou o terminal. Porém, trabalhar com uma ferramenta de controle de versão e executar um debug por linha de comando pode ser trabalhoso. Acredito que estas sejam as principais vantagens de se usar uma IDE. Por outro lado, as IDEs requerem bastante memória do desktop, ao contrário dos editores de texto, e costumam ser mais instáveis.

As opções de IDE para Rails também são variadas, e as duas principais são o [Aptana RadRails](http://www.radrails.org/) e o [NetBeans](http://www.netbeans.org/features/ruby/index.html). Nos últimos meses trabalhei com ambos alternadamente, e encontrei diversas vantagens e desvantagens em cada um.

Aptana RadRails
---------------

O Aptana RadRails pode ser instalado como um plugin do Eclipse ou isoladamente, caso você não o tenha instalado. Na primeira vez que o testei, há alguns meses, achei o plugin bastante instável, e com alguns bugs incômodos. Recentemente, ao verificar que havia uma nova versão disponível, testei novamente, e verifiquei que esta nova versão está bem melhor. Há alguns meses atrás, escrevi [neste post]({% post_url 2008-02-15-usando-dry-no-databaseyml %}) que o RadRails não conseguia ler arquivos database.yml usando o formato descrito. Conforme [este comentário]({% post_url 2008-02-15-usando-dry-no-databaseyml %}#comment-1156492925) do Chris Williams, um dos desenvolvedores do RadRails, a nova versão corrigiu este problema e outros que eu havia encontrado. A versão mais recente também possui um Ruby Shell bastante útil, inclusive com autocomplete de comandos e parâmetros, porém instável - já o vi travar algumas vezes. Outras vantagens do RadRails são:

- Botões para acesso rápido ao Model, View, Controller, Helper e Test equivalentes ao arquivo ativo
- Problema do DRY no database.yml corrigido
- Suporte a testes mais completo (permite executar apenas um arquivo de testes de cada vez)

As principais desvantagens do RadRails são:

- Problemas no autocomplete (não mostra todos os métodos)
- O console não aceita a tecla para cima para acessar os últimos comandos, como no shell
- Ruby shell instável (trava com frequência)
- Server não permite selecionar um environment diferente dos 3 defaults (development, test e production), mesmo que você tenha algum outro environment definido no arquivo `database.yml`

NetBeans
--------

O suporte do NetBeans ao Rails tornou-se estável há mais tempo que o RadRails, com um editor para código Ruby bem completo. Atualmente, ambos diferenciam-se nos detalhes. Principais vantagens do NetBeans:

- Ao selecionar um texto e digitar (, o editor envolve o texto selecionado com parênteses
- Ao selecionar um texto e digitar #, o editor envolve o texto selecionado com #{ e }
- Ao colocar o cursor sobre um end, o editor destaca o inicio desse bloco/método/classe
- O find é mais fácil de usar (estilo Firefox, com highlight  automático dos termos conforme você digita)

Principais desvantagens do NetBeans:

- Problemas no autocomplete (mostra os métodos que não deveriam aparecer)
- O console não aceita a tecla para cima para acessar os últimos comandos, como no shell
- Suporte a SVN bastante limitado
- A execução do server não permite selecionar o environment (sempre utiliza o development)
- A opção Test executa todos os testes (não há opção para executar apenas um arquivo, ou apenas os testes unitários, por exemplo)

Concluindo, o editor do NetBeans me parece mais completo para tratamento de código Ruby. Porém, o ambiente do RadRails é mais completo para execução de testes, integração com SVN e outras tarefas. Um ponto onde ambos apresentam problemas é o autocomplete - às vezes aparecem métodos de mais, outras vezes de menos. Porém, devemos reconhecer que, por se tratar de uma linguagem dinâmica, onde uma variável não tem tipo fixo, é bastante complicado termos um autocomplete realmente preciso.
