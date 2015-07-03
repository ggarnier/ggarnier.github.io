---
layout: post
comments: true
title: "Impressão para PDF no Ubuntu - correção de problemas"
date: 2008-04-04
categories: [Ubuntu, Linux, PDF]
---
Alguns programas no Ubuntu permitem a impressão para o formato PDF, como o Evince e o Gedit. Para ter essa opção disponível em qualquer programa, basta instalar uma impressora virtual de PDF, usando o pacote cups-pdf. Se ele não estiver instalado na sua distribuição, instale-o com o comando `sudo apt-get install cups-pdf`.

Para criar uma impressora de PDF, acesse a opção "System" -> "Administration" -> "Printing" e depois "New Printer". Depois selecione "Print into PDF file" como tipo de impressora, e na tela seguinte, "Generic" como fabricante e "PDF file generator" como modelo. Finalmente, dê um nome para a impressora. Feito isso, a impressora de PDF ficará disponível para qualquer programa que tenha a opção de impressão. Os PDFs serão criados no diretório PDF dentro do home do usuário.

O processo acima já foi descrito diversas vezes, em vários blogs e sites sobre Linux. Porém, decidi escrever sobre isso porque a maioria dos artigos pára por aí, não informando como alterar as configurações do cups-pdf e nem como resolver alguns dos problemas mais comuns.

Configurações
-------------

O arquivo de configuração do cups-pdf fica em _/etc/cups/cups-pdf.conf_. Neste arquivo, ficam definidos o diretório de destino dos PDFs, o diretório de spool, as regras para formação dos nomes de arquivos a partir do nome do documento impresso, configurações de segurança e permissões, o grupo de usuários que tem permissão para usar esta impressora, tipo de log, configurações do Ghostscript e outros. Se você alterar algum destes parâmetros, será necessário executar `sudo /etc/init.d/cupsys restart` para que as modificações tenham efeito.

Problemas
---------

Os [problemas mais comuns](https://bugs.launchpad.net/ubuntu/+source/cupsys/+bug/147551) com o cups-pdf são:

- se após enviar um trabalho para a impressora o arquivo correspondente não aparecer no diretório PDF dentro do seu home (ou o diretório que você tiver definido no arquivo de configuração), verifique o log (por padrão fica em _/var/log/cups/cups-pdf_log_). Ele pode ajudar a descobrir o que ocorreu (ex: problemas de permissão)
- verifique se o usuário está no grupo correspondente definido no arquivo de configuração (grupo lp por padrão)
- se você alterar o diretório de destino dos PDFs, altere também o arquivo _/etc/apparmor.d/usr.sbin.cupsd_, na seção _/usr/lib/cups/backend/cups-pdf_. Este arquivo contém as regras de segurança do AppArmor, e define os diretórios onde o cups-pdf tem permissão de escrita. Após alterá-lo, execute `sudo /etc/init.d/cupsys restart`
- se o log do cups-pdf apresentar a mensagem "[ERROR] failed to set file mode for PDF file (non fatal)", execute o comando `sudo aa-complain cupsd`
