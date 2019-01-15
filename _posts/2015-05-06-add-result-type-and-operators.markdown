---
author: kare.morstol@mac.com
comments: true
date: 2015-05-06 23:18:06+00:00
layout: post
old_link: http://blog.nottoobadsoftware.com/footlessparser/add-result-type-and-operators/
slug: add-result-type-and-operators
title: Add Result type and operators
wordpress_id: 789
categories:
- FootlessParser
tags:
- Functional programming
---

_This is part of a [series on FootlessParser](/blog/footlessparser/), a [parser combinator](http://en.wikipedia.org/wiki/Parser_combinator) written in Swift._

* * *

### Add Runes and LlamaKit using Carthage

[https://github.com/kareman/FootlessParser/commit/6142452334dae45a5aae65e0f54264f1ea3f533d](https://github.com/kareman/FootlessParser/commit/6142452334dae45a5aae65e0f54264f1ea3f533d)

Footlessparser is using operators for map ( <^> ), flatmap/bind ( >>- ) and apply ( <*> ). Luckily the [Runes framework](https://github.com/thoughtbot/Runes) has already defined these, and implemented them for optionals and arrays.

Each parse returns a `Result`, which has either a tuple containing the output and the remaining unparsed part of the input, or an error description if parsing fails. The `Result` enum is in the [Llamakit framework](https://github.com/LlamaKit/LlamaKit), later replaced by [antitypical/Result](https://github.com/antitypical/Result).

<!-- more -->

### Add Runes+Result.swift

[https://github.com/kareman/FootlessParser/commit/c49709d9bb17291fac6b82a0fe136d6d10e1bd9f](https://github.com/kareman/FootlessParser/commit/c49709d9bb17291fac6b82a0fe136d6d10e1bd9f)

To implement the operators mentioned above for parsers it is very helpful to first implement them for what parsers return, i.e. `Result`. Gordon Fontenot did just that in this [pull request to Runes](https://github.com/thoughtbot/Runes/pull/8). It was never merged, so it's included here.

### Rename Runes+Result.swift to Result+Operators.swift

[https://github.com/kareman/FootlessParser/commit/74230bb5148e827debf610c8f3c8259b8b4a77b9](https://github.com/kareman/FootlessParser/commit/74230bb5148e827debf610c8f3c8259b8b4a77b9)

I renamed the file later to make the name more descriptive and not so foreign for those who have not heard about the Runes framework.

### Switch from LlamaKit/LlamaKit to antitypical/Result.

[https://github.com/kareman/FootlessParser/commit/f527d9e0e8999479c4627dd4ffdd5871174b7edf](https://github.com/kareman/FootlessParser/commit/f527d9e0e8999479c4627dd4ffdd5871174b7edf)

Later on the [Llamakit project](https://github.com/LlamaKit/LlamaKit) recommended switching to [antitypical/Result](https://github.com/antitypical/Result). This lead to several changes:

* the `success` and `failure` functions for making a `Result` moved to the `Result` type and became static instead of global. Which is good, functions only involved with one type should be defined in that type.
* `Result` became a struct, not an enum. Which seems strange as it is either a success or a failure, never both. It was [made back into an enum](https://github.com/antitypical/Result/issues/36) later.
* the `Result` framework brought with it the micro frameworks `robrix/Box`, `robrix/Prelude` and `robrix/Either`. Especially `Prelude` has some basic functional programming functionality that will come in handy.

