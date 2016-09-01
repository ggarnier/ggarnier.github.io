---
layout: post
title: "Globosat Play architecture overview"
date: 2016-09-01
comments: true
tags: [architecture, Globo.com, videos, Rails, Ruby, talks, english]
eye_catch: http://blog.guilhermegarnier.com/images/globosatplay-architecture.png
---
This post is at least one year late. Since I gave a few [talks](http://blog.guilhermegarnier.com/talks/) about [Globosat Play](http://globosatplay.globo.com/) architecture ([slides in portuguese](http://blog.guilhermegarnier.com/evolucao-arquitetura/)), I intended to write a more detailed post, but always procrastinated about this.

[Globo.com](http://www.globo.com/) is the internet arm of the largest media conglomerate from Brazil, and one of the largest in the world. One of the areas of the company is responsible for our video platform, which includes encoding, distribution and streaming for any website of the group that needs videos.

About 5 years ago, one of our videos team developed a video product called [globo.tv](https://web.archive.org/web/20151103032004/http://globotv.globo.com/) (recently discontinued and replaced with a newer product, [Globo Play](https://globoplay.globo.com/)). Its content was focused on Rede Globo (our main broadcast TV network) shows, like news, sports and the famous brazilian telenovelas. Most of globo.tv content were small scenes from these TV shows, open for every user, but it also offered full episodes for paying subscribers.

<figure style="text-align: center">
  <img src="/images/globotv.png" alt="globo.tv" style="width: 800px" />
  <figcaption>globo.tv home page</figcaption>
</figure>

The original architecture was a single monolithic [Rails](http://rubyonrails.org/) app, with a [Unicorn](https://unicorn.bogomips.org/) application server, a [MongoDB](https://www.mongodb.com/) database and a [Redis](http://redis.io/) instance for cache, all behind an [nginx](https://nginx.org/) HTTP server. This architecture served very well for some time.

<figure style="text-align: center">
  <img src="/images/globotv-architecture.png" alt="globo.tv architecture" style="width: 600px">
  <figcaption>globo.tv architecture</figcaption>
</figure>

Then came 2012 with new demands for globo.tv. We needed to start offering live streaming of a couple of events, like [UFC](http://www.ufc.com.br/), [Big Brother Brasil](http://gshow.globo.com/realities/bbb/), soccer championships and the Winter Olympic Games. Also, we needed to start offering a collection of videos from [Combate](http://sportv.globo.com/site/combate/) channel, focused on MMA sports.

At this point, we realized the old monolithic architecture wouldn't serve anymore. So we needed to break it in smaller parts. The first step was identifying smaller subdomains inside videos. The first ones we identified and split were live streaming, for these new live events demand, and VoD (video on demand), for Combate channel videos.

Clearly these new subdomains deserved their own projects, but the problem is, they needed to share a few business rules and data from the original globo.tv project, and also between them. That meant we needed to extract a few services from globo.tv to its own project: *globotv-api* was born!

<figure style="text-align: center">
  <img src="/images/globotv-architecture2.png" alt="globo.tv architecture, 2.0" style="width: 800px">
  <figcaption>globo.tv architecture, 2.0</figcaption>
</figure>

At this point, we had:

- _**globotv-api**_, which offered a few basic video services, like the most recent videos from a specific program and the most watched programs
- _**globotv**_, the remain of the original project, which started to consume *globotv-api* services. It was responsible for serving the original pages, like home, program page, video page and search
- _**globotv-events**_, a new project responsible for live streaming of different kinds of events. It also consumed *globotv-api* and offered its own API with specific services, like a list of live events happening right now
- _**globotv-vod**_, another new project, which served the collection of videos for Combate channel. It also consumed *globotv-api* and offered its own API with specific services, like a list of competitions and videos from a specific fighter

The break-up of the monolith was a very important move. If we didn't split it at that time, we would end up with a larger and larger project, which would soon become a monster - harder to understand, harder to maintain, harder to evolve. It allowed us to share a small part of our domain, which was common among these new requirements and the original project.

To split the front-end among different projects, we used [nginx](https://nginx.org/) as a router. We already used it in front of our application server, but with multiple projects, we created an upstream for each one, and configured a location for each URL pattern, like this:

```
upstream globotv {
  server globotv.internal.globo.com;
}

upstream globotv-events {
  server globotv-events.internal.globo.com;
}

upstream globotv-vod {
  server globotv-vod.internal.globo.com;
}

server {
  listen 80;
  server_name globotv.globo.com;

  location ~ (.+)/ao-vivo/ {
    proxy_set_header Host $http_host;
    proxy_pass http://globotv-events;
    break;
  }

  location ~ ^/combate/ {
    proxy_set_header Host $http_host;
    proxy_pass http://globotv-vod;
    break;
  }

  location ~ /  {
    proxy_set_header Host $http_host;
    proxy_pass http://globotv;
    break;
  }
}
```

The internal domains aren't publicly exposed, the only way to access the projects is through nginx. With a configuration similar to this, nginx routes incoming requests for *globotv.globo.com* domain to different projects, according to the URL pattern: URLs that contain "/ao-vivo/" pattern ("live" in portuguese) are routed to *globotv-events* project; URLs starting with "/combate/" are forwarded to *globotv-vod* project. The last location matches every other URL to the original *globotv* project. *globotv-api* project doesn't appear in this configuration, as it isn't publicly accessible (it's only accessed from the other projects). This configuration allowed us to serve different pages from different projects transparently for the user.

Despite many benefits, this architectural change brought new challenges. The first one was keeping a consistent visual identity among pages served from different projects. For example, the video thumb component used in the home page should be just like the video thumb from the search page; the product header should be the same in every page. The split in multiple projects was an architectural decision; the user doesn't need to know this, because globo.tv was still a single product.

The solution for this problem was creating a components library, called *globotv-ui*. With this solution, we were able to share visual components, comprised of HTML, JS and CSS. They were standardized and documented, which made it very easy to create new components and share them among these projects - as all of them were Ruby on Rails projects, we delivered *globotv-ui* library as a Rubygem.

<figure style="text-align: center">
  <img src="/images/globotv-ui-components.png" alt="examples of components from globotv-ui library" style="width: 700px">
  <figcaption>examples of components from globotv-ui library</figcaption>
</figure>

Fast forward a few years, and a new video product emerged: [Globosat Play](http://globosatplay.globo.com/). It was very similiar to globo.tv on a few aspects - the idea was offering VoD and live streaming from [Globosat](http://canaisglobosat.globo.com/) channels (TV channels available only for paying subscribers), but with a few differences: we also needed to offer movies, and now the focus was on subscribers, and not on free users anymore.

<figure style="text-align: center">
  <img src="/images/globosatplay-homepage.png" alt="Globosat Play home page" style="width: 700px">
  <figcaption>Globosat Play home page</figcaption>
</figure>

The main challenge at that point was how to share components and services between these two products, but without one limiting the other's evolution and requirements. We needed to re-evaluate our architecture and business domain to solve this issue. We realized that, as both products had many similarities and some differences, we needed to create a common, shared layer of services, but also keep some services specific. The new architecture has become something like this:

<figure style="text-align: center">
  <img src="/images/globosatplay-architecture.png" alt="Globosat Play architecture" style="width: 800px">
  <figcaption>Globosat Play architecture</figcaption>
</figure>

This diagram is simplified from the previous ones - the new projects are also Rails apps with their own MongoDB and Redis instances. The green boxes are projects that serve web pages, and the blue ones are APIs. We split our projects in 3 parts: the top one in the image is specific to globo.tv product; the bottom one is specific to Globosat Play; and the middle one represent shared services. You can notice most of the projects created before (*globotv-api*, *globotv-events* and *globotv-vod*) started being shared, as Globosat Play also had those same requirements.

Besides that, we created a few other projects. Some of them, like *movies*, attended a specific subdomain that didn't exist before; others, like *globotv-search*, were extracted from the original *globotv* project - these features already existed, but now we needed to share them between globo.tv and Globosat Play. Also, *globotv-api* kept being our main source for basic video services.

This evolution also required a few new configurations on our nginx server:

```
upstream movies {
  server movies.internal.globo.com;
}

upstream globotv-search {
  server globotv-search.internal.globo.com;
}

upstream globosat-play {
  server globosatplay.internal.globo.com;
}

upstream globotv-events {
  server globotv-events.internal.globo.com;
}

upstream globotv-vod {
  server globotv-vod.internal.globo.com;
}

server {
  listen 80;
  server_name globosatplay.globo.com;

  location ~ (.+)/ao-vivo/ {
    proxy_set_header Host $http_host;
    proxy_pass http://globotv-events;
    break;
  }

  location ~ ^/telecine/ {
    proxy_set_header Host $http_host;
    proxy_pass http://movies;
    break;
  }

  location ~ ^/busca/ {
    proxy_set_header Host $http_host;
    proxy_pass http://globotv-search;
    break;
  }

  location ~ /  {
    proxy_set_header Host $http_host;
    proxy_pass http://globosat-play;
    break;
  }
}
```

In the end, we realized the microservices architecture brought a lot of advantages:

- **smaller, easier to manage projects**: each subdomain is separated in its own project, which helps keeping the code smaller and easier to understand. Also, this allows different teams to work in different projects
- **faster builds**: with many small projects, the time needed to build and run test suites for each one gets smaller, which gives faster feedback cycles. That stimulates developers to run the test suites more frequently
- **smaller and less risky deploys**: each project is responsible for a small part of the product; that means bugs only affect that small subdomain of it. Suppose you introduce a bug in the search project; that would affect only the search page. Your users would still be able to access the home page and watch videos. That gives confidence for the team to deploy to production more frequently, which reduces even more the risk of bugs
- **flexible infrastructure**: every service is a REST API over HTTP, using JSON format. That means you could write each one in a different language with a different database technology, if you wanted and needed. You could select the best tools for the job
- **easier incremental changes**: suppose you want to migrate your application server from [Unicorn](https://unicorn.bogomips.org/) to [Puma](http://puma.io/). With a monolithic application, you would need to flip the switch all at once. With many small services, you could choose one to try Puma - maybe the less critical one. If the migration is successful, you could continue with this process one project at a time

But we also had a few disadvantages:

- **more complex architecture**: when a new developer starts in your team, it's much harder to explain to him how the architecture works and what each project is responsible for
- **harder local environment setup**: another problem for new developers is setting up the local environment. With many projects, each one with its own requirements, that's much harder
- **harder to update dependencies, like newer gems**: when you need to update a dependency, like a gem that fixes a critical security flaw, you need to do that once for each project. With a monolith, you would just need to do that a single time
- **harder to test**: when each service depends on many others, the setup for the test environment is much harder. You would need to set a complex environment for integration tests, or create fake APIs to replace real ones, or maybe mock API responses, using something like [VCR](https://github.com/vcr/vcr)
- **heterogeneous environment**: the flexibility earned with microservices might result in projects in different languages, with different databases and other dependencies. That makes it harder to maintain, because not every developer may understand the whole set of technologies
- **more failure points, harder to debug**: when a service fails, the problem may be a bug or database failure, for example, but may also be the result of a failure in another service it depends on. The debugging process gets harder and slower

In the end, the migration from monolith to microservices was very successful to us. But the main point here is realizing that microservices aren't the magical solution to every problem - a messy monolith split would generate many messy microservices, as illustrated in the image below. You should analyze the characteristics of your project before deciding if microservices are the best option.

<div style="margin: 0 auto; display: table">
  <blockquote class="twitter-tweet">
    <p lang="en" dir="ltr">Monolithic vs Microservices
      <a href="https://t.co/EFUpsYkBNu">pic.twitter.com/EFUpsYkBNu</a>
    </p>
    &mdash; Fuckowski (@fuckowski)
    <a href="https://twitter.com/fuckowski/status/717643893655937024">April 6, 2016</a>
  </blockquote>
  <script async src="//platform.twitter.com/widgets.js"></script>
</div>
