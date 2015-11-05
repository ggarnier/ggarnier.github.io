---
layout: post
comments: true
title: "Ubuntu Netbook Remix no HP Mini"
date: 2010-12-20
tags: [Ubuntu, Linux, netbook, portuguese]
---
Outro dia um amigo me pediu para instalar o Ubuntu no netbook dele, um HP Mini (não lembro exatamente qual modelo). Baixei o [Ubuntu Netbook Remix 10.10](http://www.ubuntu.com/netbook) e instalei no pen drive, seguindo as instruções que aparecem na [página de download](http://www.ubuntu.com/netbook/get-ubuntu/download). Em seguida, fiz o boot pelo pen drive e iniciei a instalação. Tudo ia bem até que em determinado momento recebi uma mensagem de erro. Não lembro qual era a mensagem, mas parecia ser algo relacionado a disco. Tentei novamente e o erro se repetiu.

Em seguida, lembrei que quando eu havia instalado este mesmo sistema operacional num outro netbook HP Mini, mas a versão do Ubuntu era 10.04. Como a página principal do Ubuntu só disponibiliza links para download da última versão, encontrei as versões anteriores na página [Ubuntu Releases](http://releases.ubuntu.com/). Na página específica da [versão 10.04 (Lucid Lynx)](http://releases.ubuntu.com/lucid/) o link aparece como [PC (Intel x86) netbook live CD](http://releases.ubuntu.com/lucid/ubuntu-10.04-netbook-i386.iso).

Após baixar esta versão e instalá-la no pen drive, tudo funcionou. Aparentemente é algum problema relacionado com a versão 10.10 mesmo. Tudo funciona de primeira, sem necessitar qualquer configuração (bluetooth, som, webcam, etc.), exceto o wifi. A página [Hardware support](https://wiki.ubuntu.com/HardwareSupport/Machines/Netbooks) do wiki do Ubuntu traz a solução: basta conectar o netbook à Internet via porta Ethernet e reinstalar o driver `bcmwl`, digitando no terminal: `sudo apt-get install bcmwl-kernel-source`. Após a instalação, reinicie o netbook e tudo funcionará.
