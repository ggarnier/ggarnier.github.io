---
layout: post
title: "Increasing productivity in tmux with a single prefix key"
date: 2017-12-05
excerpt: How to customize tmux prefix to a single key, and make it even more productive
comments: true
tags: [terminal, tmux, english]
eye_catch: https://blog.guilhermegarnier.com/images/keyboard.jpg
---
[Tmux](https://github.com/tmux/tmux) is a fantastic tool for improving productivity when working with a terminal. One of the first things people configure when start using tmux is changing the prefix key. The default value is `control+b`, which is not very confortable to press with a single hand. And as you'll end up pressing it a lot, for every tmux command, the most common used configuration is changing it to `control+a`.

This is much better, but you still need to press two keys simultaneously before typing any tmux command. After using this configuration for some time, I decided to change it to a single key, to make it even easier.

I though about changing the prefix to `caps lock`. Besides being rarely used, it's very well positioned. However, you can't set `caps lock` as prefix in tmux. An alternative solution is mapping the `caps lock` key to something else. In OSX, you can set it to another modifier key, like `control`, `shift` or `esc`: go to `System Preferences` => `Keyboard` => `Modifier keys`. First I tried mapping it to `esc`, and setting `esc` as tmux prefix. It works, but this setup brought another problem: as a vim user, I use the `esc` key a lot (to alternate between vim modes), so now I had to type `esc`/`caps lock` twice to send the `esc` key to vim. It was ok, but not ideal.

Then I tried another solution: I installed [Karabiner-Elements](https://github.com/tekezo/Karabiner-Elements), a Mac app which allows you to completely customize your keyboard. So I mapped the `caps lock` key to `Home` (which doesn't exist in Mac keyboard), and changed tmux prefix key to `Home`:

```sh
set -g prefix Home
unbind C-b
bind-key Home send-prefix
```

Now I have a great configuration: I use a single key (`caps lock`) as prefix, and without losing any key functionality.
