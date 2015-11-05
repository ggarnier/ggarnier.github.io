---
layout: post
title: "Simulando passagem de tempo em testes de Javascript"
date: 2015-09-10
comments: true
tags: [Javascript, testes, Jasmine, portuguese]
---
O [Jasmine](http://jasmine.github.io/) é uma das ferramentas de teste para Javascript mais usadas atualmente. A sintaxe estilo BDD lembra bastante o [RSpec](http://rspec.info/), o que facilita a vida de quem já tem experiência com este.

Uma das dificuldades ao realizar testes de Javascript é como simular a passagem do tempo. Existem duas situações básicas onde isso acontece:

1. Quando o código executa alguma animação, como fade in e slide down, por exemplo
2. Quando definimos uma função que só será executada após um período de tempo determinado

O primeiro caso pode ser ilustrado com este exemplo básico:

```html
  <button id="button">Show Menu</button>
  <div id="menu" style="display: none">Menu</div>

  <script>
    function example() {
      $("#button").click(function() {
        $("#menu").fadeIn();
      });
    }

    example();
  </script>
```

Um clique no botão faz com que o menu apareça usando a função [jQuery.fadeIn](http://api.jquery.com/fadein/). O teste para este código, a princípio, poderia ser algo assim:

```javascript
describe("example test", function() {
  beforeEach(function() {
    example();
  });

  it("shows the menu after clicking the button", function() {
    $("#button").click();

    expect($("#menu")).toBeVisible();
  });
});
```

O problema é que, como a animação do fade in leva um pequeno período de tempo para executar (400 ms por padrão), o menu ainda não está visível no momento em que a expectativa é executada. Uma solução inocente, mas pouco eficiente, para este problema seria executar a expectativa num [setTimeout](https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/setTimeout).

Neste caso específico, como a animação é feita usando jQuery, há uma propriedade [jQuery.fx.off](https://api.jquery.com/jquery.fx.off/) que permite desabilitar todas as animações. Desta forma, todas as transições são feitas instantaneamente, fazendo com que o teste original funcione:

```javascript
describe("example test", function() {
  var jQueryFxOff;

  beforeEach(function() {
    jQueryFxOff = $.fx.off;
    $.fx.off = true;
    example();
  });

  afterEach(function() {
    $.fx.off = jQueryFxOff;
  });

  it("shows the menu after clicking the button", function() {
    $("#button").click();

    expect($("#menu")).toBeVisible();
  });
});
```

Note que o valor original da propriedade é armazenado numa variável e restaurado após o teste, para evitarmos que esta configuração afete outros testes que serão executados em sequencia.

O segundo caso é quando temos algum código que só é executado após um período de tempo - usando [setTimeout](https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/setTimeout), por exemplo:

```javascript
module = {
  someRandomCode: function() {
  },

  waitForIt: function() {
    setTimeout(this.someRandomCode, 5000);
  }
}

module.waitForIt();
```

A melhor forma de testar este código é "fakeando" a passagem do tempo, para que o teste não precise aguardar. Uma boa ferramenta para isto são os os [fake timers](http://sinonjs.org/docs/#clock) do [Sinon.JS](http://sinonjs.org/):

```javascript
describe("my random test", function() {
  var clock;

  beforeEach(function() {
    clock = sinon.useFakeTimers();
    spyOn(module, "someRandomCode");

    module.waitForIt();
  });

  afterEach(function() {
    clock.restore();
  });

  it("tests my random code", function() {
    clock.tick(5000);
    expect(module.someRandomCode).toHaveBeenCalled();
  });
});
```

Outra boa opção é usar o [Jasmine Clock](http://jasmine.github.io/2.3/introduction.html#section-Jasmine_Clock):

```javascript
describe("my random test", function() {
  beforeEach(function() {
    jasmine.clock().install();
    spyOn(module, "someRandomCode");

    module.waitForIt();
  });

  afterEach(function() {
    jasmine.clock().uninstall();
  });

  it("tests my random code", function() {
    jasmine.clock().tick(5000);
    expect(module.someRandomCode).toHaveBeenCalled();
  });
});
```
