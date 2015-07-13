---
layout: post
comments: true
title: "Problema com múltiplos joins em Criteria"
date: 2009-11-12
categories: [Java, Hibernate, Criteria]
---
O [Criteria](https://www.hibernate.org/hib_docs/v3/api/org/hibernate/Criteria.html) é uma API do [Hibernate](https://www.hibernate.org/) que facilita muito quando precisamos montar uma query complexa com filtros opcionais. Adicionar restrições ou criar joins com esta API é muito mais simples de gerenciar do que concatenando Strings, como faríamos ao trabalhar com SQL puro.

Apesar das vantagens, o Criteria também tem alguns problemas. O último que encontrei foi ao tentar fazer 2 joins entre as mesmas 2 tabelas. No meu caso, eu tinha no banco as tabelas `projeto` e `historico`. A segunda tabela é populada através de uma trigger no banco: sempre que o status do projeto muda, a tabela `historico` registra o status anterior do projeto com data/hora da mudança. Eu precisava fazer uma query que buscasse um projeto com status "iniciado" num determinado período de datas e com status "finalizado" em outro período. Inicialmente, pensei simplesmente em criar 2 joins entre as tabelas, cada um com um alias diferente e filtrando pelas datas específicas:

```java
Criteria criteria = getSession().createCriteria(Projeto.class);

// Primeiro join
criteria.createCriteria("historicoList", "historicoIniciado", Criteria.LEFT_JOIN)
        .add(Restrictions.eq("historicoIniciado.status", Status.INICIADO.value()))
        .add(Restrictions.ge("historicoIniciado.data", dataIniciadoDe))
        .add(Restrictions.le("historicoIniciado.data", dataIniciadoAte));

// Segundo join
criteria.createCriteria("historicoList", "historicoFinalizado", Criteria.LEFT_JOIN)
        .add(Restrictions.eq("historicoFinalizado.status", Status.FINALIZADO.value()))
        .add(Restrictions.ge("historicoFinalizado.data", dataFinalizadoDe))
        .add(Restrictions.le("historicoFinalizado.data", dataFinalizadoAte));
```

O código acima, apesar de semelhante ao que eu já havia criado para adicionar outros filtros à query de projetos, fazendo joins com outras tabelas, não funcionava. Tentei retirar um dos joins com a tabela `historico` e funcionou. Ou seja, o problema estava na criação do segundo join com as mesmas tabelas, mesmo utilizando aliases diferentes. Ao pesquisar este problema, descobri que não é um bug. Na verdade, o [Criteria não suporta múltiplos joins para a mesma associação](http://opensource.atlassian.com/projects/hibernate/browse/HB-555?focusedCommentId=11570&amp;page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#action_11570).

Sendo assim, a solução que encontrei para este problema foi criar uma subquery para a tabela `historico`, utilizando um [DetachedCriteria](https://www.hibernate.org/hib_docs/v3/api/org/hibernate/criterion/DetachedCriteria.html):

```java
DetachedCriteria historicoCriteria = DetachedCriteria.forClass(Historico.class, "historicoIniciado")
        .setProjection(Projections.distinct(Projections.property("projeto")))
        .add(Restrictions.eq("historicoIniciado.status", Status.INICIADO.value()));
        .add(Restrictions.ge("historicoIniciado.data", dataIniciadoDe));
        .add(Restrictions.le("historicoIniciado.data", dataIniciadoAte));
criteria.add(Subqueries.propertyIn("id", historicoCriteria));
```

Desta forma, apenas um dos joins precisa ser substituído por uma subquery. O outro join pode ser mantido sem problemas.
