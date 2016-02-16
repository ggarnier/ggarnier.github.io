---
layout: post
comments: true
title: "Como fazer configurações de rede permanentes no Ubuntu"
date: 2008-02-13
tags: [Ubuntu, Linux, networks, portuguese]
---
Um detalhe muito incômodo no Ubuntu é que as configurações de rede realizadas através da opção "Network" (no menu System -> Administration) não são permanentes. Qualquer alteração realizada no endereço IP, gateway, DNS ou domínios é perdida após um reboot. Se você editar as configurações de uma interface de rede via `ifconfig`, o mesmo problema ocorrerá. Não sei se isso é um bug ou uma característica desejada, mas eu acho muito inconveniente.

Para tornar as configurações de rede permanentes, você deve editar os seguintes arquivos (como root ou sudo):

- Configurações de DNS: arquivo `/etc/dhcp3/dhclient.conf`. Para definir servidores DNS, retire o comentário da linha `prepend domain-name-servers` e acrescente os IPs após `127.0.0.1`, separados por espaço. Para definir domínios de busca, retire o comentário da linha `supersede domain-name` e digite os domínios entre aspas, separados por espaço;

- Configurações de interface de rede: arquivo `/etc/network/interfaces`. Para configurar a interface eth0, por exemplo, acrescente as seguintes linhas no final do arquivo, substituindo os endereços IP pelos valores correspondentes:

{% highlight bash %}
auto eth0
iface eth0 inet static
address 192.168.254.3
netmask 255.255.255.0
gateway 192.168.254.254
{% endhighlight %}

Após concluir as alterações, reinicie o serviço de rede com o comando
`/etc/init.d/networking restart`.
