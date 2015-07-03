---
layout: post
comments: true
title: "Instalação do Firefox 3.0 no Ubuntu"
date: 2008-06-18
categories: [Firefox, Ubuntu, Linux]
---
Ontem foi lançada a versão final do Firefox 3.0. Porém, como esta versão ainda não está disponível nos respositórios oficiais do Ubuntu, resolvi fazer o download e a instalação manualmente. Por segurança, optei por manter instalada a versão 2, para o caso de encontrar algum problema, ou alguma extensão que considero essencial não funcionar.

Primeiramente, fiz o [download do Firefox 3.0](http://pt-br.www.mozilla.com/pt-BR/firefox/). Em seguida, movi o diretório da versão anterior para outro nome:

```sh
cd /usr/lib
sudo mv firefox firefox-2.0
```

Descompactei o Firefox 3.0 neste mesmo local, e movi o diretório para _firefox-3.0_, criando em seguida um link simbólico para firefox. Desta forma, fica mais fácil voltar a utilizar o Firefox 2 caso eu necessite:

```sh
sudo tar xvfj firefox-3.0.tar.bz2
sudo mv firefox firefox-3.0
sudo ln -s firefox-3.0 firefox
```

Em seguida, você deve habilitar os plugins. Verifique no diretório plugins do Firefox 2 os plugins que estão habilitados:

```sh
ls -l /usr/lib/firefox-2.0/plugins/
total 12
lrwxrwxrwx 1 root root   37 2008-05-26 10:03 flashplugin-alternative.so -> /etc/alternatives/firefox-flashplugin
lrwxrwxrwx 1 root root   39 2008-02-28 14:19 libjavaplugin.so -> /etc/alternatives/firefox-javaplugin.so
lrwxrwxrwx 1 root root   36 2008-02-28 14:10 libtotem-basic-plugin.so -> ../../totem/libtotem-basic-plugin.so
lrwxrwxrwx 1 root root   37 2008-02-28 14:10 libtotem-basic-plugin.xpt -> ../../totem/libtotem-basic-plugin.xpt
lrwxrwxrwx 1 root root   34 2008-02-28 14:10 libtotem-gmp-plugin.so -> ../../totem/libtotem-gmp-plugin.so
lrwxrwxrwx 1 root root   35 2008-02-28 14:10 libtotem-gmp-plugin.xpt -> ../../totem/libtotem-gmp-plugin.xpt
lrwxrwxrwx 1 root root   36 2008-02-28 14:10 libtotem-mully-plugin.so -> ../../totem/libtotem-mully-plugin.so
lrwxrwxrwx 1 root root   37 2008-02-28 14:10 libtotem-mully-plugin.xpt -> ../../totem/libtotem-mully-plugin.xpt
lrwxrwxrwx 1 root root   42 2008-02-28 14:10 libtotem-narrowspace-plugin.so -> ../../totem/libtotem-narrowspace-plugin.so
lrwxrwxrwx 1 root root   43 2008-02-28 14:10 libtotem-narrowspace-plugin.xpt -> ../../totem/libtotem-narrowspace-plugin.xpt
-rw-r--r-- 1 root root 9104 2008-04-18 13:43 libunixprintplugin.so
lrwxrwxrwx 1 root root   43 2008-02-28 14:15 mplayerplug-in-dvx.so -> ../../mozilla/plugins/mplayerplug-in-dvx.so
lrwxrwxrwx 1 root root   44 2008-02-28 14:15 mplayerplug-in-dvx.xpt -> ../../mozilla/plugins/mplayerplug-in-dvx.xpt
lrwxrwxrwx 1 root root   42 2008-02-28 14:15 mplayerplug-in-qt.so -> ../../mozilla/plugins/mplayerplug-in-qt.so
lrwxrwxrwx 1 root root   43 2008-02-28 14:15 mplayerplug-in-qt.xpt -> ../../mozilla/plugins/mplayerplug-in-qt.xpt
lrwxrwxrwx 1 root root   42 2008-02-28 14:15 mplayerplug-in-rm.so -> ../../mozilla/plugins/mplayerplug-in-rm.so
lrwxrwxrwx 1 root root   43 2008-02-28 14:15 mplayerplug-in-rm.xpt -> ../../mozilla/plugins/mplayerplug-in-rm.xpt
lrwxrwxrwx 1 root root   39 2008-02-28 14:15 mplayerplug-in.so -> ../../mozilla/plugins/mplayerplug-in.so
lrwxrwxrwx 1 root root   43 2008-02-28 14:15 mplayerplug-in-wmp.so -> ../../mozilla/plugins/mplayerplug-in-wmp.so
lrwxrwxrwx 1 root root   44 2008-02-28 14:15 mplayerplug-in-wmp.xpt -> ../../mozilla/plugins/mplayerplug-in-wmp.xpt
lrwxrwxrwx 1 root root   40 2008-02-28 14:15 mplayerplug-in.xpt -> ../../mozilla/plugins/mplayerplug-in.xpt
```

Você deve criar esses mesmos links simbólicos no diretório plugins do Firefox 3:

```sh
cd /usr/lib/firefox-3.0/plugins/
sudo ln -s /etc/alternatives/firefox-flashplugin .
sudo ln -s /etc/alternatives/firefox-javaplugin.so .
sudo ln -s ../../totem/libtotem-* .
sudo ln -s ../../mozilla/plugins/mplayerplug-in* .
```

Finalmente, fiz um backup do diretório de configurações que fica no meu home:

```sh
cd ~
cp -r .mozilla FIREFOX-2.0_BACKUP
```

Pronto, o Firefox 3.0 já está instalado. Para retornar à versão 2, basta remover o link _/usr/lib/firefox_ e criar outro apontando para _firefox2.0_:

```sh
cd /usr/lib
sudo rm firefox
sudo ln -s firefox-2.0 firefox
```

Ao executar a nova versão pela primeira vez, como em qualquer atualização, o Firefox verifica a compatibilidade das extensões que estão instaladas. Algumas extensões apareceram como não compatíveis com o Firefox 3. O Autocomplete Manager, por exemplo, é incompatível, mas foi incorporado ao Firefox 3 e não é mais necessário. Já o Firebug, ferramenta essencial para qualquer desenvolvedor web, tem duas versões: 1.05 para Firefox 2 e 1.2 para Firefox 3. Ao iniciar o Firefox 3 pela primeira vez, você receberá uma mensagem informando que o Firebug é incompatível, e que não foram encontradas versões mais recentes da extensão. Você deve procurá-lo na página de add-ons e clicar em "add to Firefox" para instalar a versão mais recente.

Referência: [Instalando Firefox 3 no Centos/RHEL e Fedora](http://marcellino.wordpress.com/2008/06/17/instando-firefox-3-no-centosrhel-e-fedora/)
