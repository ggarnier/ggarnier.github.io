---
layout: post
comments: true
title: "Como montar diretórios remotos via ssh"
date: 2008-03-24
categories: [Linux, Ubuntu, ssh, fuse, mount, rede]
---
O sshfs é um comando muito útil para quem precisa acessar servidores (ou máquinas virtuais) remotos. Com este comando, em vez de precisarmos executar o ssh para logarmos ou o scp para copiarmos arquivos entre o desktop e os servidores, podemos montar localmente um diretório remoto.

Para instalar esse pacote no Ubuntu, basta executar o comando `sudo apt-get install sshfs`. Em seguida, adicione seu login ao grupo fuse:

`sudo usermod -a -G fuse login`

Apenas usuários deste grupo terão permissão para montar e desmontar diretórios. Para montar um diretório remoto:

`sudo sshfs user@server:/usr/local/test ./server-test`

O comando acima mapeia o diretório _/usr/local/test_ do servidor _server_ no diretório local _./server-test_, como usuário remoto _user_. Há uma série de parâmetros opcionais, como forçar sincronização e cache. Verifique o man do comando para mais detalhes.

Para desmontar o diretório, basta executar:

`fusermount -u ./server-test`

Referências:

- [Mount directories via SSH](http://liquidat.wordpress.com/2008/02/23/short-tip-mount-directories-via-ssh/)
- [Mount remote folders via SSH](http://www.ducea.com/2008/02/29/mount-remote-folders-via-ssh/)
