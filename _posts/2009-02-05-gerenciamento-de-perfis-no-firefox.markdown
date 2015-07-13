---
layout: post
comments: true
title: "Gerenciamento de perfis no Firefox"
date: 2009-02-05
categories: [Firefox, Internet, backup]
---
Recentemente escrevi um post listando as [extensões do Firefox para desenvolvedores web que eu recomendo]({% post_url 2009-01-06-extensoes-do-firefox-recomendadas-para-desenvolvedores-web %}). Outro dia, achei que o meu Firefox estava ficando muito lento. Quando fui verificar, percebi que eu tinha cerca de 30 extensões instaladas! Obviamente, quanto mais extensões instaladas, mais memória o browser utilizará.

Uma dica útil para quem deseja utilizar muitas extensões, mas não tem necessidade de utilizar todas no mesmo momento, é utilizar diferentes perfis. Em cada perfil, você pode instalar extensões diferentes, ou alterar as configurações do browser e instalar temas. Ao executar o Firefox, você pode selecionar o perfil desejado. Para isso, utilize o [Profile Manager](http://kb.mozillazine.org/Profile_Manager). Basta executar o Firefox com a seguinte linha de comando:

`firefox -profilemanager`

Fazendo isto, aparecerá uma janela como a seguinte:

<a href="/images/firefox-profile_manager.png" class="post-image-link">![Profile Manager](/images/firefox-profile_manager.png)</a>

Nesta janela, aparecerão todos os perfis existentes, e você pode selecionar o que deseja utilizar. Também é possível criar, renomear e excluir perfis. Desmarcando a opção "Don't ask at startup", esta tela do Profile Manager será exibida sempre que o Firefox for executado.

Caso você queira carregar um perfil que já existe em outro diretório, basta criar um novo perfil e selecionar o diretório correspondente. Se o perfil já existir, ele será somente adicionado à lista. Na opção excluir perfil, você pode escolher se deseja realmente excluir os arquivos e diretórios ou somente remover o perfil da lista.

Outra opção de linha de comando bastante útil é o [Safe Mode](http://kb.mozillazine.org/Safe_mode). Caso o Firefox comece a ficar instável após a instalação de alguma extensão, basta executar:

`firefox -safe-mode`

No Safe Mode, todas as extensões, temas e demais customizações são desabilitadas, permitindo a desinstalação da extensão problemática, se for o caso. Além disso, é possível fazer algumas alterações permanentes, como resetar as preferências e bookmarks de usuários e desabilitar as extensões.

<a href="/images/firefox-safe_mode.png" class="post-image-link">![Firefox Safe Mode](/images/firefox-safe_mode.png)</a>

Para fazer backup de um perfil, existem várias extensões disponíveis. A que achei mais interessante é o [FEBE](https://addons.mozilla.org/en-US/firefox/addon/2109). Esta extensão permite selecionar especificamente quais itens do perfil você deseja incluir no backup (extensões, temas, bookmarks, configurações, cookies, histórico e outras opções), executar o backup manualmente ou agendar para execução diária, semanal ou mensal, verificar os backups anteriores e outras opções. A opção de restauração de um backup também é seletiva: você pode restaurar somente os itens que desejar ou o perfil completo.

Mais informações sobre o backup de perfis usando o FEBE: [Export your Firefox 3.0 full profile to Firefox 3.1 (including all addons, themes, cookies, passwords, etc)](http://icehot.wordpress.com/2008/12/23/export-your-firefox-30-full-profile-to-firefox-31-including-all-addons-themes-cookies-passwords-etc/).

Outra opção para backup de perfis é o [Profile Manager and Synchronizer](https://addons.mozilla.org/pt-BR/firefox/addon/9452), que ainda é experimental. Não testei esta extensão, mas pela descrição ela não parece ter tantas opções quanto o FEBE, apesar de ter recursos interessantes para sincronizar perfis em diferentes máquinas.

**UPDATE:** Outro recurso interessante é o parâmetro _-no-remote_, que permite a execução de duas instâncias do Firefox com perfis diferentes. Basta executar o Firefox com a seguinte linha de comando:

`firefox -P profile -no-remote`

Onde -P é a forma reduzida do parâmetro _-profilemanager_ e _profile_ é o nome do perfil desejado, conforme aparece no Profile Manager. Este perfil não pode ser o padrão. Para abrir a tela do Profile Manager, basta deixar o nome do perfil em branco:

`firefox -P -no-remote`

Mais informações:

- [Opening a new instance of Firefox with another profile](http://kb.mozillazine.org/Opening_a_new_instance_of_Firefox_with_another_profile)
- [Outros parâmetros de linha de comando](http://kb.mozillazine.org/Command_line_arguments)

Obrigado ao Tóin pelas [dicas](#comment-119).
