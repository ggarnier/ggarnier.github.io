---
layout: post
title: "Software quality isn't optional"
date: 2015-11-05
comments: true
tags: [software engineering, events, DevDay, talks, english]
---
In the last weekend, I attended to [DevDay 2015](http://devday.devisland.com/), in Belo Horizonte, where I presented a talk about ["evolution of a distributed architecture"](http://blog.guilhermegarnier.com/evolucao-arquitetura/) (in portuguese).

The last talk of the event presented [Stack Overflow](http://stackoverflow.com/) architecture. This talk was very controversial, and I felt I needed to write something to show my point of view on this subject.

A lot is being said in the community about the value of software engineering best practices. For the last decades, people like Uncle Bob, Kent Beck, Martin Fowler and many others have been doing a great effort promoting these practices, through books, posts and talks. These professionals made and still make a great job orienting new developers, so we can have well tested software projects and well designed architectures, focusing on aspects like maintainability, scalability, security and quality.

Despite this, we know that, in many companies, management makes pressure on developers to deliver as fast as possible, forgetting about software quality and maintainability - even knowing they will be responsible for the project maintenance, at least in short term. This habit goes against every best practice described above, and is very harmful to new developers. These ones that start their career in companies with this idea in mind, even if they've read about best practices, end up believing that this is utopian, and that in practice it's impossible to design a sustainable architecture, refactor legacy code or automate tests, because of pressures for fast delivery of new features. That's why it's essential to spread the word about best practices, to show these new developers that it's not only possible to focus on quality, but also essential for the project evolution and maintenance.

In the talk that closed [DevDay 2015](http://devday.devisland.com/), [Stack Overflow](http://stackoverflow.com/) architecture was presented. The displayed numbers are impressive: it's one of the 50 top sites in the world, with millions of page views per day, and all that supported by only 9 physical servers, each one working at around 5% load, plus 2 database servers. With this structure, the average load time is only 18 ms. How is this possible?

The secret, according to this talk, is their obsession with performance. Every new feature must have the best possible performance. When a library or tool they use isn't considered fast enough, they rewrite it from scratch. As layered architectures are slow, every database query is manually written, and directly in the controller.

Stack Overflow code has low testability, because you can't create mocks to replace the database connection, for instance. That's why the project has very few automated tests (and it was mentioned that some developers don't even run the tests). As they have a massive number of active and engaged users, any bug that's introduced after a deploy is quickly found and reported at [Meta Stack Overflow](http://meta.stackoverflow.com/). To update the operating system version, they just remove a server from the pool, apply the update and put the server back live. They assume that, if a new bug arises, users will soon find and report it.

The speaker let it very clear that modeling, architecture and tests are good stuff, but they're not for everyone. I personally disagree.

Stack Overflow is a very particular case. As their audience is made of developers, and they're very engaged and passionate about the product, bugs in production are considered acceptable, because the main focus is performance. But what's the point of performance without quality? Would you buy the fastest car in the world even knowing it doesn't have seat belts and air bags, and that it doesn't support replacing a flat tire or a defective part? The analogy is very exaggerated - a bug in the site doesn't involve life risk, but what I mean is, if you focus only and exclusively on performance, you give up other aspects like quality and security. It's the same line of thought from those managers I mentioned before, who make a lot of pressure for fast delivery, regardless of quality.

<figure style="text-align: center">
  <img src="/images/fast-food.jpg" alt="Fast food" style="width: 400px">
  <figcaption>Does every fast food need to be like this?</figcaption>
</figure>

In my opinion, even if your project focuses on performance, quality can't be abandoned. The other extreme - over-engineering - is also bad; if you have a small application, with only a couple of users, it doesn't make sense to create a complex architecture, thinking about the possibility of maybe one day it may expand. This would be creating a solution for a problem that doesn't exist.

I have a real example for this: I register all my expenses in Google Spreadsheet. I wanted to share these data with my wife, but as the spreadsheet is very large, I created a small app that extracts these data and displays a very simple dashboard, only with information that she is interested in. This app has only two users - me and her -, and there isn't a chance that this grows up. In this case, it doesn't make sense for me to think about a scalable architecture. But when we talk about a product with tens of millions of users, the situation is very different. Currently, Stack Overflow doesn't have a competitor to match, but if one rises with a better user experience or new features, they will have a hard time to follow.

My main concern while watching this talk was the impact that these ideas can have on the audience. The majority of them were very young, probably students or professionals starting their career. A talk like this, spreading the word about optional software quality, can be very harmful to them. And it seems like [Facebook has a similar issue with code quality](http://www.darkcoding.net/software/facebooks-code-quality-problem/).

To wrap up, I want to make it clear that I'm not doing a personal attack against Stack Overflow or the speaker. I admire her courage to take the stage and present such controversial ideas, even though I disagree on them. I'm a Stack Overflow user and will continue being after all.
