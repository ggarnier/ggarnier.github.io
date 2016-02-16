---
layout: post
title: "Ferramentas para avaliação de qualidade de código Ruby"
date: 2014-11-06
comments: true
tags: [Ruby, Rails, Jenkins, portuguese]
---
Ferramentas para avaliar a qualidade do seu código existem aos montes, para qualquer linguagem de programação. Eu já utilizei algumas para Java, mas nunca tinha testado nenhuma para Ruby, apesar de ser a linguagem que mais uso há alguns anos. Por isso, resolvi testar todas as ferramentas que pude encontrar. Separei a avaliação entre serviços e ferramentas.

# Serviços

Classifiquei como serviços as ferramentas onde, em vez de instalar e executar localmente, você libera acesso ao seu repositório de código a elas, que coletam métricas a partir do código e geram algum relatório. Os dois serviços que avaliei são gratuitos para projetos open source e pagos para projetos com código fechado.


## [Code Climate](https://codeclimate.com/)

Este é certamente o serviço mais conhecido para avaliação de qualidade de código Ruby. Seu foco principal é gerar métricas baseadas em complexidade de código, mas ele também é capaz de identificar algumas falhas de segurança e cobertura de código dos testes.


## [Coveralls](https://coveralls.io/)

O Coveralls funciona de forma semelhante ao Code Climate, porém tem um foco maior em testes. Ele exibe o histórico de cobertura e a diferença para cada arquivo a cada commit.


# Ferramentas

As ferramentas abaixo são open source e distribuídas através de gems. Para utilizá-las, basta instalar a gem e executar um comando, que analisa o código e gera relatórios ou dados brutos para serem analisados.


## [Brakeman](http://brakemanscanner.org/)

O Brakeman é uma ferramenta focada em localizar potenciais falhas de segurança no seu código. Ele também exibe alertas especificamente relacionados ao Rails, como falhas de segurança que já foram corrigidas numa versão do Rails mais recente do que a que você usa.

Como ele tem foco em segurança, é muito importante manter esta gem sempre atualizada, para que ele possa detectar falhas descobertas mais recentemente.


## [RuboCop](https://github.com/bbatsov/rubocop)

O foco do RuboCop é localizar más práticas de programação no seu código, com base no [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide). Algumas das regras são: uso de aspas simples ou duplas para definir strings, tamanho máximo da linha, número de linhas em cada método e uso de espaços na definição de hashes.

Todas as regras do RuboCop podem ser configuradas ou desabilitadas. Basta criar um arquivo `.rubocop.yml` na raiz do projeto com as configurações desejadas. Ele também possui regras específicas para projetos usando Rails.

Se você usa o editor [Atom](https://atom.io/), também é possível executar o RuboCop automaticamente com o plugin [atom-lint](https://atom.io/packages/atom-lint). Assim, ao salvar um arquivo, o RuboCop é automaticamente executado, e os alertas são exibidos no próprio editor, ao lado de cada linha.


## [RubyCritic](https://github.com/whitesmith/rubycritic)

O RubyCritic foi criado com o objetivo de se tornar uma alternativa gratuita ao Code Climate. Ele gera um relatório bem semelhante ao deste serviço, reportando os trechos mais complexos do seu código.


## [Metric Fu](https://github.com/metricfu/metric_fu/)

O Metric Fu é um agregador de ferramentas de análise de código. Ele executa diversas ferramentas e gera uma página com links para os resultados de cada uma. É uma das ferramentas mais completas para análise de código Ruby, e uma das mais antigas.


## [Ruby-lint](https://github.com/YorickPeterse/ruby-lint)

O foco do Ruby-lint é localizar erros como variáveis não utilizadas ou não inicializadas, ou número errado de argumentos ao executar um método. O problema é que quando extendemos ou incluimos classes ou módulos definidos fora do projeto (em gems), ele não encontra as dependências e dá erro de constante indefinida. Apesar disso, parece que vem sendo bastante atualizado.


## [Reek](https://github.com/troessner/reek)

Esta ferramenta é um detector de bad smells no código, como Long Parameter List e Feature Envy. Possui plugins para rodar alguns editores, como [Vim](http://www.vim.org/) e [TextMate](http://macromates.com/).


## [Roodi](https://github.com/roodi/roodi)

Roodi significa "Ruby Object Oriented Design Inferometer". Ele executa algumas métricas de complexidade de código, mas é bem básico. A maioria das métricas já são calculadas por outras ferramentas apresentadas aqui.


## [Flog](http://ruby.sadi.st/Flog.html)

Gera um score baseado na complexidade de código. Bem básico.


## [Rails Best Practices](https://github.com/railsbp/rails_best_practices)

Ferramenta bem útil, gera métricas de qualidade baseadas no [Rails Best Practices](http://rails-bestpractices.com/). Como diz o nome, é específico para projetos Rails. Também é disponibilizado como um [serviço online](http://railsbp.com/) gratuito, mas somente para projetos públicos no Github. Para projetos privados, é possível instalar uma instância própria, pois [o servidor é open source](https://github.com/railsbp/railsbp.com).


## [Cane](https://github.com/square/cane)

Mais um gerador de métricas de qualidade. As métricas são parecidas com as do RuboCop.


## [Pelusa](https://github.com/codegram/pelusa)

Este projeto é semelhante ao Ruby-lint, mas não consegui executar. Ele só funciona com [Rubinius](http://rubini.us/), mas é incompatível com a versão mais recente (apesar de o projeto não informar quais são as versões compatíveis).


## [Flay](https://github.com/seattlerb/flay)

Esta ferramenta procura similaridades na estrutura do seu código (ex: dois métodos que possuem o código muito semelhante).


## [Saikuro](https://github.com/metricfu/Saikuro)

Gera métricas de complexidade ciclomática.


## [Laser](https://github.com/michaeledgar/laser) e [Nitpick](https://github.com/kevinclark/nitpick)

Mais duas ferramentas semelhantes ao Ruby-lint. Como estão há anos sem atualizações, nem testei.


# Resumindo…

Entre as ferramentas que testei, gostei mais do Brakeman, do RuboCop e do RubyCritic. Acredito que são complementares, e, se usadas em conjunto, ajudam bastante a encontrar falhas de segurança, os pontos mais complexos do seu código e a seguir boas práticas de programação Ruby.

Além destas 3, também gosto do Metric Fu, mas por executar muitas ferramentas, acho que ele gera informação demais. Usando ferramentas e métricas em excesso, geramos tanta informação que acabamos ignorando-as. Por isso, preferi focar nas 3 ferramentas que citei, pois já consigo ter um panorama bem completo do status do meu código com elas.


# Usando na prática

Todas as ferramentas que testei são executadas via linha de comando e geram como saída algum tipo de relatório. Apesar de poder executá-las manualmente, na minha opinião, é mais interessante executá-las no servidor de integração contínua (CI). Desta forma, garantimos que essas ferramentas serão executadas com frequencia, e todo o time tem acesso aos relatórios gerados, assim como gráficos de evolução a cada execução. Com isso, podemos analisar se a "saúde" do projeto está melhorando ou piorando, basta acompanhar se o número de warnings de uma determinada ferramenta estão aumentando ou diminuindo.

No caso específico do RuboCop, como ele analisa o uso de boas práticas de programação, acho mais útil executar no editor, pois, ao salvar um arquivo, tenho a resposta imediata, e posso fazer os ajustes no mesmo momento. Mas isso é uma questão de preferência.


## Executando no Jenkins

Como uso o [Jenkins](http://jenkins-ci.org/), descrevi como configurar as ferramentas acima neste servidor. O processo é bem simples, acredito que não seja difícil reproduzí-lo em outros servidores de integração contínua.

Cada ferramenta pode ser executada por um job à parte ou no mesmo job que roda o build e os testes do projeto. Optei pela 1a opção, por 2 motivos:

1. O tempo de execução de cada ferramenta de análise de código pode ser razoavelmente longo, o que deixaria o job de build muito lento
2. Caso ocorra algum problema na execução de alguma destas ferramentas, não quero que o job de build do meu projeto apareça quebrado no CI. Se o build e todos os testes foram executados com sucesso, o job que executa o build deve ter sucesso

Além disso, optei por instalar as gems diretamente no CI. Desta forma, além de não precisar configurá-las no Gemfile do projeto, garanto que as gems estarão sempre atualizadas, o que é muito importante, principalmente no caso do Brakeman, pois novas falhas de segurança são encontradas diariamente.


### Criando um novo job

Ao criar um novo job no Jenkins, você pode configurá-lo para executar automaticamente após cada build do projeto ou para executar periodicamente. Apesar de a primeira opção garantir que os relatórios de análise de código estarão atualizados a cada build, a execução é um pouco demorada. Além disso, achei que um relatório por dia seria suficiente para acompanhar o status do projeto. Sendo assim, configurei o job de relatórios para executar diariamente, de segunda a sexta-feira. Para isso, na configuração do job, basta selecionar a opção `Build periodically`, e no campo `Schedule`, digitar `H 0 * * 1-5`, por exemplo (o formato é o mesmo usado no [crontab](http://pt.wikipedia.org/wiki/Crontab)). Este valor configura o job para ser executado em qualquer minuto da hora zero, em qualquer dia do mês, todos os meses, de segunda a sexta-feira (dias 1 a 5).

Eu optei por criar um único job para executar todas as ferramentas, pois desta forma, tenho todos os relatórios centralizados num único local. A principal desvantagem é que, desta forma, um erro na execução de uma ferramenta fará o job encerrar com status de erro, e as ferramentas seguintes não serão executadas.

Para configurar cada ferramenta dentro do job, o processo é o mesmo:

1. Selecionar em `Build` a opção `Execute shell`, com os comandos para instalar e executar a gem
2. Adicionar uma `Post-build Action` para exibir os resultados

A configuração de cada ferramenta é a seguinte:

### Brakeman

Configure a execução da ferramenta digitando os seguintes comandos no campo `Execute shell` da configuração do job:

{% highlight sh %}
mkdir -p tmp
gem install brakeman --no-ri --no-rdoc && brakeman -o tmp/brakeman-output.tabs --no-progress --separate-models --quiet
{% endhighlight %}

Para visualizar os resultados, instale o [Brakeman Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Brakeman+Plugin) no Jenkins e selecione em `Post-build Actions` a opção `Publish Brakeman warnings`. Em `Brakeman Output File`, digite `tmp/brakeman-output.tabs`.

### RubyCritic

Adicione o seguinte comando no campo `Execute shell`:

{% highlight sh %}
gem install rubycritic --no-ri --no-rdoc && rubycritic app lib
{% endhighlight %}

Para visualizar os resultados, é necessário o plugin [HTML Publisher](https://wiki.jenkins-ci.org/display/JENKINS/HTML+Publisher+Plugin). Após instalá-lo, selecione em `Post-build Actions` a opção `Publish HTML reports` e digite os seguintes valores:

- **HTML directory to archive:** `tmp/rubycritic`
- **Index page[s]:** `overview.html`
- **Report title:** `RubyCritic Reports`

### RuboCop

Digite os comandos abaixo no campo `Execute shell`:

{% highlight sh %}
mkdir -p tmp
gem install rubocop --no-ri --no-rdoc && rubocop --fail-level E --rails --out tmp/rubocop.out app lib spec
{% endhighlight %}

O plugin para exibir o resultado desta ferramenta é o [Warnings](https://wiki.jenkins-ci.org/display/JENKINS/Warnings+Plugin). Após instalá-lo, é necessário configurar um parser para os warnings do RuboCop. Vá até a configuração do Jenkins (`Manage Jenkins` -> `Configure System`). Em `Compiler Warnings`, adicione um novo parser com os seguintes valores:

- **Name:** `RuboCop`
- **Link name:** `RuboCop`
- **Trend report name:** `RuboCop Warnings`
- **Regular Expression:**

{% highlight sh %}
^([^:]+):(\d+):\d+: ([^:]): ([^:]+)$
{% endhighlight %}

- **Mapping Script:**

{% highlight sh %}
import hudson.plugins.warnings.parser.Warning

String fileName = matcher.group(1)
String lineNumber = matcher.group(2)
String category = matcher.group(3)
String message = matcher.group(4)

return new Warning(fileName, Integer.parseInt(lineNumber), "RuboCop Warnings", category, message);
{% endhighlight %}

- **Example Log Message:**

{% highlight sh %}
attributes/default.rb:21:78: C: Use %r only for regular expressions matching more than 1 '/' character.
{% endhighlight %}

Após salvar esta configuração, volte até a configuração do job e selecione em `Post-build Actions` a opção `Scan for compiler warnings`. Em `File pattern` digite `tmp/rubocop.out`, e no campo `Parser`, selecione o parser recém-criado, `RuboCop`.
