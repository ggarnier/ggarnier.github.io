---
layout: post
comments: true
title: "Ferramenta em Rails para criação de blogs"
date: 2008-10-31
categories: [Rails, Ruby, blog]
---
Muitos tutoriais de Rails para iniciantes, para demonstrarem na prática como é rápido e simples criar aplicações web com ele, explicam como criar um blog em 15 minutos, baseados no [screencast do David Heinemeier Hansson](http://media.rubyonrails.org/video/rails_take2_with_sound.mov), criador do Rails, para o FISL 6.0. Apesar de ser uma aplicação funcional de blog, com opção para criar posts e adicionar comentários, é bastante limitado.

O [Typo](http://typosphere.org/) é uma aplicação desenvolvida em Rails para criação de blogs bastante completa (inclusive encontrei [este blog](http://www.robbyonrails.com/) criado com ele). Ele lembra muito o [Wordpress](http://wordpress.org/), acredito que tenha sido inspirado nele. A interface de administração é muito semelhante à do Wordpress, apresentando basicamente as mesmas opções: criar posts e páginas, ver/aprovar/rejeitar comentários, criar usuários, customizar a barra lateral, etc. Há também uma opção para seleção de temas (outros temas podem ser encontrados [aqui](http://typogarden.org/)) e [plugins](http://typosphere.org/wiki/typo/Finding_Typo_Plugins) com diversas funcionalidades, como APIs para [Delicious](http://delicious.com/), [Flickr](http://www.flickr.com/), [Twitter](http://twitter.com/) e outros. Só senti falta das opções de estatísticas de acesso que o WordPress oferece.

A instalação pode ser feita através do comando gem (`gem install typo`), porém, tentei e não consegui instalar desta forma. Instalei a ferramenta pela versão tgz. Neste caso, basta descompactar a aplicação, copiar o arquivo _database.yml.example_, no diretório _config_, para _database.yml_, editá-lo conforme a configuração do banco de dados, e em seguida executar `rake db:create` para criar a estrutura do banco de dados. Caso você queira ser avisado por email quando receber comentários nos posts, copie também o arquivo _config/mail.yml.example_ para _mail.yml_ no mesmo diretório, e edite as configurações de SMTP.

O Typo também possui um servidor de feeds RSS/Atom. Porém, na versão atual (5.1.3), recebi uma mensagem de erro ao tentar acessar os feeds. Encontrei o erro no arquivo _app/models/article.rb_ e corrigi substituindo o método _link_to_author?_ (linhas 384 a 386) pelo seguinte:

{% highlight ruby %}
def link_to_author?
  begin
    !user.email.blank? && blog.link_to_author
  rescue NoMethodError
    return false
  end
end
{% endhighlight  %}
