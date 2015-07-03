---
layout: post
comments: true
title: "Edição de PDF no OpenOffice 3.0"
date: 2009-03-16
categories: [OpenOffice, Open Source, PDF]
---
Há muito tempo o [OpenOffice](http://www.openoffice.org/) oferece uma opção para exportação de documentos para o formato PDF. Apesar de ser muito útil, falta uma opção para importar esse formato para edição. Faltava! A extensão [PDF Import Extension](http://extensions.services.openoffice.org/project/pdfimport) da Sun faz exatamente isso: arquivos PDF podem ser importados e editados no OpenOffice Draw.

Apesar de a extensão estar em versão beta, fiz alguns testes e funcionou muito bem (apesar de alguns comentários de usuários com problemas na página da extensão). Achei a importação dos arquivos um pouco lenta, conforme alguns testes que eu fiz:

- Arquivo com 18 páginas (300 kB) =~ 10 segundos
- Arquivo com 209 páginas (6,28 MB) =~ 2 minutos
- Arquivo com 322 páginas (1,15 MB) =~ 3 minutos

Num dos arquivos, uma página que continha muitos gráficos não foi importada adequadamente, mas foi o único problema que tive.

A opção salvar utiliza o formato ODF Drawing (.odg). Para salvar novamente como PDF, é necessário utilizar a tradicional opção de exportação para este formato. Porém, percebi que num dos testes a fonte ficou um pouquinho diferente da original. Mas, mesmo assim, a exportação foi de boa qualidade.

Referência sobre o assunto (incluindo uma descrição passo-a-passo da instalação): [Modificando PDF no OpenOffice.org 3.0](http://razec.wordpress.com/2008/12/08/modificando-pdf-no-openofficeorg-30/).
