---
layout: post
comments: true
title: "Compartilhando perfis do Firefox com dual boot"
date: 2010-04-13
tags: [Firefox, Linux, Windows]
---
Muitos usuários de Linux têm dual boot com uma instalação de Windows, geralmente para executar alguma aplicação específica, como jogos mais recentes ou o iTunes (apesar de que o [Ubuntu 10.04 deve suportar iPod e iPhone](http://www.webupd8.org/2010/02/confirmed-ubuntu-1004-supports-iphone.html)).

Quem utiliza esta configuração e usa Firefox em ambos os sistemas operacionais acaba tendo dois perfis independentes no browser, e não consegue acessar bookmarks, histórico e extensões instaladas no outro sistema. Uma solução para este problema é compartilhar os perfis do Firefox entre os sistemas operacionais.

O Firefox armazena um diretório com configurações pessoais do usuário. No Linux, esse diretório fica tipicamente em `/home/usuario/.mozilla/Firefox/`, e no Windows, em `C:\Documents and Settings\usuario\Dados de aplicativos\Mozilla\Firefox\`. Este diretório contém, entre outras coisas, um subdiretório `Profiles` com todos os perfis criados (mais detalhes sobre isso no post sobre [gerenciamento de perfis no Firefox]({% post_url 2009-02-05-gerenciamento-de-perfis-no-firefox %})) e um arquivo `profiles.ini`. Este arquivo é carregado na inicialização do browser, e faz referência aos perfis utilizados. O formato do arquivo é como mostra o exemplo abaixo:

```ini
[General]
StartWithLastProfile=1

[Profile0]
Name=default
IsRelative=1
Path=Profiles/dwi06ij0.default

[Profile1]
Name=teste
IsRelative=1
Path=Profiles/nkc5ofgt.default
Default=1
```

O arquivo é dividido em seções. A primeira, `General`, tem somente o parâmetro `StartWithLastProfile`: se for 0, será exibida a [tela de seleção de perfis]({% post_url 2009-02-05-gerenciamento-de-perfis-no-firefox %}); se for 1, o último perfil que foi usado será escolhido automaticamente.

As seções seguintes definem todos os perfis criados. Cada perfil tem um nome e um path - que será relativo ao diretório de configurações do Firefox se `IsRelative` for 1, e absoluto em caso contrário. O parâmetro `Default` indica se este é o perfil padrão.

Para que os dois sistemas operacionais compartilhem um perfil, primeiramente é necessário montar a partição do usuário utilizada pelo outro sistema operacional. Isso pode ser feito de duas maneiras:

Mapeando uma partição do Windows no Linux
-----------------------------------------

Para montar uma partição do Windows, basta utilizar o comando `mount`, como no exemplo abaixo:

```sh
sudo mount /dev/sda1 /media/windows
```

Neste exemplo, a partição do Windows é `/dev/sda1`, e o diretório destino (que deve ser criado antes) é `/media/windows`. A partição pode ser FAT32 ou NTFS - neste caso, é necessário instalar o [ntfs-3g](http://www.tuxera.com/community/ntfs-3g-download/), que já vem por padrão na maioria das distribuições atuais. Para que a partição seja montada automaticamente na inicialização do sistema, inclua a linha abaixo no arquivo `/etc/fstab`:

```sh
/dev/sda1 /media/windows ntfs defaults 0 0
```

Caso a partição seja FAT32, substitua `ntfs` por `vfat` na linha acima.

A configuração acima também pode ser feita utilizando uma ferramenta gráfica como o [ntfs-config](http://www.psychocats.net/ubuntu/mountwindows).

Mapeando uma partição do Linux no Windows
-----------------------------------------

Para isso, é necessário instalar uma ferramenta como o [Ext2 IFS](http://www.fs-driver.org/) - que, apesar do nome, também suporta ext3. Ao instalar esta ferramenta, será possível mapear qualquer partição ext2 ou ext3 como um drive comum. A figura abaixo mostra uma tela da ferramenta, onde aparecem todas as partições dos discos locais. Em cada partição do Linux, há uma combo box que permite selecionar a letra em que a partição será mapeada - selecionando `none` o mapeamento será desfeito.

<a href="/images/ext2_ifs.jpg" class="post-image-link">![Ext2 IFS](/images/ext2_ifs.jpg)</a>

Entre as duas opções, pessoalmente, prefiro a segunda, pois não gosto da ideia do Windows acessando minhas partições do Linux - só mapeio uma partição com o Ext2 IFS quando preciso copiar algum arquivo, depois desfaço o mapeamento.

Após realizar o mapeamento da partição, de uma das duas formas acima, basta configurar o arquivo `profiles.ini` do Firefox. Para isso, é possível configurar o path completo para o perfil desejado e definir o parâmetro `IsRelative=0`, ou fazer um link no diretório onde o Firefox armazena os perfis e configurar o path relativo, com o parâmetro `IsRelative=1`. A primeira configuração ficaria como no exemplo abaixo:

```ini
[Profile0]
Name=default
IsRelative=0
Path=/media/windows/Documents and Settings/guilherme/Dados de aplicativos/Mozilla/Firefox/Profiles/sa8ww6mz.default
```

Para a segunda configuração, é necessário criar um link com o comando `ln`:

```sh
ln -s /media/windows/Documents\ and\ Settings/guilherme/Dados\ de\ aplicativos/Mozilla/Firefox/Profiles/sa8ww6mz.default /home/guilherme/.mozilla/Firefox/Profiles/
```

Neste caso, a configuração do arquivo ficaria assim:

```ini
[Profile0]
Name=default
IsRelative=1
Path=Profiles/sa8ww6mz.default
```

Possíveis problemas
-------------------

Apesar de funcionar muito bem, o compartilhamento de perfis pode trazer alguns problemas:

- Se as versões do Firefox nos dois sistemas forem diferentes (o que é muito comum, pois o repositório do Ubuntu costuma demorar para atualizar as versões), cada vez que você abrir o browser num sistema após tê-lo acessado no outro será como se você tivesse atualizado a versão do Firefox, ou seja, a inicialização será mais lenta, pois ele verificará a compatibilidade de cada extensão instalada com a versão atual;
- Se você tentar abrir o Firefox num sistema operacional após ele ter travado no outro sistema, ele exibirá uma mensagem informando que já existe uma sessão aberta. Isso acontece por que, quando o Firefox é iniciado, ele cria um arquivo vazio chamado `parent.lock` no diretório do perfil que você estiver usando. Este arquivo é excluído quando o browser é fechado. Se isso ocorrer de maneira incomum (ex: travamento do browser ou do sistema operacional), este arquivo impedirá a abertura de outra sessão. Para resolver o problema, exclua esse arquivo;
- Algumas extensões são incompativeis com determinados sistemas operacionais e versões de browser. Se for o caso, estas extensões serão desativadas pelo browser.
