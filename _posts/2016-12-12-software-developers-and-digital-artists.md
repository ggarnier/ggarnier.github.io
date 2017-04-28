---
layout: post
title: "Software Developers and Digital Artists"
date: 2016-12-12
comments: true
tags: [software engineering, refactoring, english]
---
[Nerdcast](https://jovemnerd.com.br/nerdcast/) is an amazing podcast (in portuguese) about nerdie stuff in general. One of its latest episodes talked about the [digital artist profession](https://jovemnerd.com.br/nerdcast/profissao-artista-digital/). The guests were animators that worked on feature films like [Moana](http://www.imdb.com/title/tt3521164/) and [Doctor Strange](http://www.imdb.com/title/tt1211837/). They talked a lot about what they do, and I saw a lot of analogies between their work and software development.

One of the podcast guests said that we was working on a specific scene for Doctor Strange for about 2 months, and suddenly his boss called him and told the director decided to cut that scene off from the film. Those 2 months of work turned into garbage. The lesson he learned from that is, you shouldn't get attached to the project you're working on. It's not **your project**, it's **your company's project** and you happen to be working on it, which is very different. The analogy here is very clear, because that happens a lot in software projects: sometimes your client decides the feature you've been working on for a few weeks or months is not that important, or even worse, that the whole project shouldn't be maintained anymore. It's very hard not to be impacted by these news, but if you don't work on that, you will frequently get frustrated. The project is meant to deliver value to your client, not you. Always remember that [you are not paid to write code](http://bravenewgeek.com/you-are-not-paid-to-write-code/).

If you want a project to be really yours, and have total freedom to decide what to do and how to do it, you need a personal project. But it's important to notice that, if someday you decide to make that a business, turning that into a startup or selling some kind of product or service, you will start to have clients. When that happens, you need to be ready to let go of your ideas; if nobody wants your product, be ready to [pivot](https://en.wikipedia.org/wiki/Lean_startup#Pivot) (or even discontinue the whole product). [A/B tests](https://en.wikipedia.org/wiki/A/B_testing) are also a great way to learn how to let go of your ideas and beliefs: if a hypothesis is proven worse than the default behavior, just delete it.

Another important topic that was mentioned in the podcast was: the guests, as artists, have a hard time deciding when to stop improving their work. They start working on a scene and iterate a couple of times to make it better. As perfectionists, they want to keep polishing their work. But sometimes the scene is already looking so good that any improvement won't be noticed by the audience, so it just **won't deliver value to the client anymore**. The problem is not knowing when to stop. We can make an analogy here with refactoring: sometimes we develop a new feature, and even after it's implemented and well tested, we decide to refactor. The objective could be making the code clearer for anyone that may touch it later - to implement a new feature of fix a bug - or maybe extracting a part of it to remove duplication from a similar feature you already had. In both cases, the refactoring won't deliver value in the short term, but will on the mid-term or long term: you will have lower maintenance costs. But we may have the same problem as the animators: it's very hard to know when to stop polishing the code. At some point, the refactoring won't deliver value anymore, and we just refactor to please ourselves. As said before, you need to remember the project is not yours, and [you are not paid to write code](http://bravenewgeek.com/you-are-not-paid-to-write-code/)!