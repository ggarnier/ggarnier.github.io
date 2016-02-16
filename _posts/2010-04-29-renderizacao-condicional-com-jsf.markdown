---
layout: post
comments: true
title: "Renderização condicional com JSF"
date: 2010-04-29
tags: [Java, JSF, Tomahawk, portuguese]
---
Muitos componentes [JSF](http://java.sun.com/javaee/javaserverfaces/), como os do [Tomahawk](http://myfaces.apache.org/tomahawk/index.html), por exemplo, possuem o atributo `rendered`. Este atributo, como diz o nome, indica se o componente será renderizado ou não. No valor deste atributo, é possível utilizar expressões [JSF EL](http://developers.sun.com/docs/jscreator/help/jsp-jsfel/jsf_expression_language_intro.html); desta forma, a lógica que indicará se o elemento será exibido ou não pode (e deve) ser transferida para um Managed Bean. Isso permite que evitemos colocar muita lógica nos XHTMLs, deixando-os mais limpos e organizados.

Porém, em determinados momentos, precisamos fazer a renderização condicional de elementos que os componentes JSF não oferecem. Uma possível solução seria inserir este elemento num `<t:div>`, por exemplo, pois este componente do Tomahawk possui o atributo `rendered`. Porém, estaríamos criando um `<div>` em torno do elemento desejado sem necessidade. O melhor neste caso seria utilizar o componente [<t:htmlTag>](http://myfaces.apache.org/tomahawk-project/tomahawk/tagdoc/t_htmlTag.html).

O `<t:htmlTag>` possui um atributo `value` que define a tag HTML que será renderizada em seu lugar, caso o atributo `rendered` seja igual a `true`. Se o `value` for vazio, ele não criará nenhuma tag adicional; assim, o `<t:htmlTag>` servirá somente para a renderização condicional de tudo o que estiver dentro deste componente.

Atenção: o atributo `value` é obrigatório; se você omití-lo, o componente não funcionará! Para que ele não gere nenhuma tag, é necessário definir `value=""`, como no exemplo abaixo:

{% highlight html %}
<t:htmlTag rendered="#{tipo.exibeDescricao}" value="">
    <div id="divDescricao_#{tipo.id}">
        <h:outputText value=" #{messages.descricao}" />
        <h:inputTextarea styleClass="inputAreaTexto" id="descricao" value="#{descricaoTipo}" />
    </div>
</t:htmlTag>
{% endhighlight %}
