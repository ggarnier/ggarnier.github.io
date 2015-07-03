---
layout: post
comments: true
title: "Criando e compartilhando componentes Facelets"
date: 2010-07-23
categories: [Java, JSF, Facelets]
---
Atualmente estou trabalhando em alguns projetos que possuem diversas características em comum. Para facilitar o reaproveitamento de código, criamos um módulo à parte, uma espécie de framework, com todo o código comum aos projetos, e modularizamos os projetos usando [Maven](http://maven.apache.org/).

Quando chegamos na camada de apresentação, percebemos que não estávamos reaproveitando código como nas demais camadas. Pelo contrário, os XHTMLs de várias telas eram bastante parecidos, e estávamos basicamente copiando e colando quando surgia uma tela nova. Inclusive dentro de um mesmo XHTML, muita parte do código era copiada, pois vários elementos se repetiam (ex: elementos de formulário, com um label e um campo de texto ao lado). Decidimos então criar componentes [Facelets](https://facelets.dev.java.net/).

A criação de componentes Facelets é muito simples, basta seguir os passos abaixo:

<ol>
<li>
<p>Criar o componente. Como exemplo, criei um chamado <em>itemFormulario</em>, que exibe um label, um campo de texto e as mensagens de erro correspondentes:</p>

```xml
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
    xmlns:ui="http://java.sun.com/jsf/facelets"
    xmlns:h="http://java.sun.com/jsf/html"
    xmlns:f="http://java.sun.com/jsf/core"
    xmlns:t="http://myfaces.apache.org/tomahawk"
    xmlns:c="http://java.sun.com/jstl/core"
    xmlns:fn="http://java.sun.com/jsp/jstl/functions">

<ui:component>
    <h:outputLabel for="#{id}" value="#{label}" />
    <h:inputText id="#{id}" value="#{value}" />
    <h:message for="#{id}" />
</ui:component>
</html>
```

<p>Esse arquivo será salvo em <em>/WEB-INF/facelets/</em> com o nome <em>itemFormulario.xhtml</em>. Neste exemplo, o componente utiliza os parâmetros <em>id</em>, <em>label</em> e <em>value</em>.</p>
</li>

<li>
<p>Criar um arquivo de taglib para registrar os componentes criados. Este arquivo, que vou chamar de <em>projeto.taglib.xml</em>, será criado no diretório <em>/WEB-INF/facelets</em> do projeto, e será como no exemplo abaixo:</p>

```xml
<?xml version="1.0"?>
<!DOCTYPE facelet-taglib PUBLIC "-//Sun Microsystems, Inc.//DTD Facelet Taglib 1.0//EN" "https://facelets.dev.java.net/source/browse/*checkout*/facelets/src/etc/facelet-taglib_1_0.dtd">
<facelet-taglib>
    <namespace>http://exemplo.com.br/jsf</namespace>
    <tag>
        <tag-name>itemFormulario</tag-name>
        <source>itemFormulario.xhtml</source>
    </tag>
</facelet-taglib>
```

<p>Neste exemplo, registrei o componente itemFormulario. Sempre que criar um novo componente, ele deverá ser registrado neste arquivo, através de uma nova tag <em>&lt;tag&gt;</em>.</p>
</li>

<li>
<p>Registrar a biblioteca de taglib no projeto, adicionando o trecho abaixo ao arquivo <em>web.xml</em>:</p>

```xml
<context-param>
    <param-name>facelets.LIBRARIES</param-name>
    <param-value>/WEB-INF/facelets/projeto.taglib.xml</param-value>
</context-param>
```

<p>Desta forma, os componentes declarados no arquivo de taglib poderão ser usados no seu projeto, como neste exemplo:</p>

```xml
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
 xmlns:ui="http://java.sun.com/jsf/facelets"
 xmlns:h="http://java.sun.com/jsf/html"
 xmlns:f="http://java.sun.com/jsf/core"
 xmlns:t="http://myfaces.apache.org/tomahawk"
 xmlns:c="http://java.sun.com/jstl/core"
 xmlns:fn="http://java.sun.com/jsp/jstl/functions"
 xmlns:custom="http://exemplo.com.br/jsf">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
    </title>
</head>
<body>
    <custom:itemFormulario id="username" label="Digite seu login:" value="#{loginController.username}" />
</body>
</html>
```
</li>
</ol>

A partir deste ponto, precisamos compartilhar estes componentes entre os diferentes projetos. Para isso, seguimos os passos abaixo:

<ol>
<li>
<p>Mover o conteúdo do diretório <em>/WEB-INF/facelets</em> (arquivo de taglib e componentes criados) para o módulo compartilhado. Colocar estes arquivos na raiz do diretório <em>/META-INF</em></p></li>

<li><p>Atualizar no arquivo <em>web.xml</em> o trecho que registra a taglib:</p>

```xml
<context-param>
    <param-name>facelets.LIBRARIES</param-name>
    <param-value>/META-INF/projeto.taglib.xml</param-value>
</context-param>
```

<p>Se for utilizar mais de uma taglib, declare-as separadas por ";" no trecho acima.</p>
</li>

<li><p>Repetir o passo anterior para cada projeto que irá utilizar os componentes criados</p></li>
</ol>

Nas versões atuais do Facelets, a declaração da taglib no arquivo _web.xml_ é desnecessária caso este arquivo esteja na raiz do diretório _/META-INF_. Os arquivos de componentes poderão ficar em outro diretório (ex: _/META-INF/facelets_), bastanto atualizar o arquivo de taglib de acordo com o diretório escolhido:

```xml
<?xml version="1.0"?>
<!DOCTYPE facelet-taglib PUBLIC "-//Sun Microsystems, Inc.//DTD Facelet Taglib 1.0//EN" "https://facelets.dev.java.net/source/browse/*checkout*/facelets/src/etc/facelet-taglib_1_0.dtd">
<facelet-taglib>
    <namespace>http://exemplo.com.br/jsf</namespace>
    <tag>
        <tag-name>itemFormulario</tag-name>
        <source>/META-INF/facelets/itemFormulario.xhtml</source>
    </tag>
</facelet-taglib>
```

Há ainda um passo opcional, que é a criação de um arquivo TLD (taglib descriptor) para que a IDE possa validar os componentes que você criou. Um arquivo TLD tem o seguinte formato:

```xml
<!DOCTYPE taglib PUBLIC "-//Sun Microsystems, Inc.//DTD JSP Tag Library 1.2//EN"
"http://java.sun.com/dtd/web-jsptaglibrary_1_2.dtd">

<taglib xmlns="http://java.sun.com/JSP/TagLibraryDescriptor">
    <tlib-version>1.0</tlib-version>
    <jsp-version>2.0</jsp-version>
    <short-name>Componentes</short-name>
    <uri>http://exemplo.com.br/jsf</uri>
    <display-name>Minha biblioteca de componentes</display-name>
    <tag>
        <name>itemFormulario</name>
        <tag-class />
        <body-content>empty</body-content>
        <description>
            Cria um item de formulário com label, campo de texto e mensagens de erro.
        </description>
        <attribute>
            <name>id</name>
            <required>true</required>
            <rtexprvalue>false</rtexprvalue>
            <type>java.lang.String</type>
            <description>
                Identificação do componente
            </description>
        </attribute>
        <attribute>
            <name>label</name>
            <required>false</required>
            <rtexprvalue>false</rtexprvalue>
            <type>java.lang.String</type>
            <description>
                Texto exibido no label do componente
            </description>
        </attribute>
        <attribute>
            <name>value</name>
            <required>true</required>
            <rtexprvalue>false</rtexprvalue>
            <type>java.lang.String</type>
            <description>
                Valor associado ao inputText do componente
            </description>
        </attribute>
    </tag>
</taglib>
```

Salve esse arquivo com o nome _projeto.taglib.tld_, no mesmo diretório do arquivo _projeto.taglib.xml_. Agora, ao abrir um arquivo XHTML que esteja usando o componente itemFormulario, a IDE exibirá os erros de validação (ex: um atributo marcado como required não foi definido). Com este arquivo criado, ao abrir um XHTML no Eclipse usando o editor de JSP, você terá também o recurso de autocomplete (Control + espaço), que exibirá todos os atributos do componente, assim como a descrição de cada um.

Referências:

- [Create a Common Facelets Tag Library: Share it across projects](http://ocpsoft.com/opensource/create-common-facelets-jar/)
- [Reuse facelets xhtml files and taglibs from jar archives](http://thomaswabner.wordpress.com/2008/06/25/reuse-facelets-xhtml-files-and-taglibs-from-jar-archives/)
