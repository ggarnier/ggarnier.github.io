---
layout: post
comments: true
title: "Script para verificar o status da conexão PPPoE"
date: 2008-11-24
categories: [Ubuntu, Linux, Internet, rede, PPPoE, scripts, Shell]
---
No meu computador pessoal, o acesso a Internet é através de um link de rádio. A autenticação no provedor utiliza PPPoE. Para configurar a autenticação no Windows XP, basta usar o cliente PPPoE que vem por padrão. No Ubuntu também é muito simples, basta executar o comando `pppoeconf`, e seguir os passos de configuração. Na maioria das perguntas só precisei selecionar a opção default. Fora isso, são solicitados username e senha do provedor. Ao término da configuração, a interface PPP já está configurada, e é ativada automaticamente na inicialização.

Apesar de a configuração acima ter funcionado no Ubuntu, a conexão parava de funcionar com frequência (a cada 20 ou 30 minutos, aproximadamente). Apesar de continuar aparecendo como ativa, eu não conseguia acessar nada. Quando isto ocorria, eu precisava executar o comando `poff` para encerrar a conexão e, em seguida, `pon dsl-provider` para restabelecê-la. A princípio, achei que fosse algum problema do provedor; porém, isso não ocorre no Windows XP.

Encontrei algumas referências a esse problema nos forums do Ubuntu, mas nenhuma solução definitiva. Para resolver, criei um script que verifica periodicamente se a conexão está ativa (na verdade, tenta pingar o site do provedor 3 vezes, aumentando o timeout a cada tentativa). Em caso negativo, executa os comandos `poff` e `pon`, conforme descrito acima, e repete o procedimento. Segue o script abaixo (salvei-o como `/home/guilherme/scripts/internet.sh`):

```sh
#!/bin/bash

cmd_ping="/bin/ping"
cmd_pon="/usr/bin/pon"
cmd_poff="/usr/bin/poff"
provider="dsl-provider"
host="www.radlink.com.br"
frequency="10s"
verbose=0

while [ true ]
do
    ok=0
    for timeout in 1 2 3
    do
        `$cmd_ping -q -c 1 -W $timeout $host > /dev/null 2>&1`
        if [ $? -eq 0 ]
        then
            ok=1
            break
        fi
    done

    if [ $ok -eq 1 ]
    then
        sleep $frequency
        continue
    fi

    `$cmd_poff $provider > /dev/null 2>&1`
    `$cmd_pon $provider > /dev/null 2>&1`
    if [ $? -ne 0 ]
    then
        $verbose && echo "Erro na conexão com o provedor"
        exit 1
    fi

    sleep $frequency
done

exit 0
```

Os parâmetros no início do script definem os paths para os comandos utilizados (`ping`, `pon` e `poff`), o nome do provedor, conforme foi especificado no comando `pppoeconf` (o default é `dsl-provider`), o host que será pingado e a frequência de execução do loop.

Para completar, coloquei este script na inicialização. Primeiro é necessário criar um script shell e salvá-lo no diretório `/etc/init.d` (usei [este artigo](http://articles.slicehost.com/2007/10/17/ubuntu-lts-adding-an-nginx-init-script) como modelo):

```sh
#! /bin/sh

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/home/guilherme/scripts/internet.sh
PIDFILE=/home/guilherme/scripts/internet.pid
NAME=internetd
DESC="Internet"

test -f $DAEMON || exit 0

set -e

. /lib/lsb/init-functions

case "$1" in
  start)
    log_begin_msg "Starting $DESC: $NAME"
    start-stop-daemon --start --quiet --background -m --pidfile "$PIDFILE" --exec $DAEMON
    log_end_msg $?
    ;;
  stop)
    log_begin_msg "Stopping $DESC: $NAME"
    start-stop-daemon --stop --quiet --pidfile $PIDFILE
    rm -f $PIDFILE
    log_end_msg $?
    ;;

  restart|force-reload)
    log_begin_msg "Restarting $DESC: $NAME"
    if start-stop-daemon --stop --quiet --pidfile $PIDFILE; then
        start-stop-daemon --start --quiet --background -m --pidfile "$PIDFILE" --exec $DAEMON
    fi
    log_end_msg $?
    ;;
  status)
    echo -n "Status of $DESC: "
    if [ ! -r "$PIDFILE" ]; then
        echo "$NAME is not running."
        exit 3
    fi
    if read pid < "$PIDFILE" && ps -p "$pid" > /dev/null 2>&1; then
        echo "$NAME is running."
        exit 0
    else
        echo "$NAME is not running but $PIDFILE exists."
        exit 1
    fi
    ;;
  *)
    N=/etc/init.d/${0##*/}
    echo "Usage: $N {start|stop|restart|force-reload|status}" >&2
    exit 1
    ;;
esac

exit 0
```

Em seguida, dê permissão de execução ao script (salvei o arquivo com o nome `internetd`):

```sh
sudo chmod +x /etc/init.d/internetd
```

Finalmente, para colocar o script na inicialização, o comando é:

```sh
sudo /usr/sbin/update-rc.d -f internetd defaults
```

Caso seja necessário interromper ou reiniciar o script, use o comando `sudo /etc/init.d/internetd start/stop/restart`.

Depois que atualizei o Ubuntu para 8.04 não tive mais esse problema, porém no Ubuntu 7.10 acontecia constantemente. Além disso, este procedimento só é necessário caso o seu ponto de Internet esteja conectado diretamente ao micro, o que era o meu caso na época. Como posteriormente comprei um roteador com Wi-Fi, todo esse procedimento tornou-se desnecessário, pois o próprio roteador passou a fazer a autenticação PPPoE. Para desfazer as configurações, primeiramente retire o script do init.d com o comando:

```sh
sudo /usr/sbin/update-rc.d -f internetd remove
```

Em seguida, remova a interface PPP que foi criada pelo `pppoeconf` editando o arquivo `/etc/network/interfaces` e removendo ou comentando as linhas correspondentes a essa interface. No meu caso, as linhas eram as seguintes:

```sh
auto dsl-provider
iface dsl-provider inet ppp
pre-up /sbin/ifconfig eth0 up # line maintained by pppoeconf
provider dsl-provider
```

**UPDATE:** os scripts acima estão disponíveis no [meu GitHub](http://github.com/ggarnier/pppoe-connection).
