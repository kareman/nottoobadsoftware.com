---
date: 2015-04-13 15:24:20+00:00
old_link: http://blog.nottoobadsoftware.com/footlessparser/writing-a-parser-combinator-in-swift/
slug: writing-a-parser-combinator-in-swift
title: Writing a parser combinator in Swift
wordpress_id: 676
categories:
- FootlessParser
tags:
- Functional programming
- Swift
---

_This post is part of a [series on FootlessParser](/blog/footlessparser/), a [parser combinator](http://en.wikipedia.org/wiki/Parser_combinator) written in Swift._

* * *

Before Swift my only contact with functional programming was a couple of half-hearted attempts at reading Erlang, all of them resulting in me running away screaming, clutching my aching head. But learning functional concepts in Swift proved far easier, probably because the syntax is closer to what I was used to. So I read [Functional Programming in Swift](http://www.objc.io/books/) and everything was well and good until one of the last chapters, "Parser Combinators", and the headache was back. Luckily I managed to stay quiet and in place this time. I downloaded the code for the chapter, turned it into a framework and hacked away until I had implemented a CSV parser, but I still didn't really understand it.

<!-- more -->

The parser library from the book has 6 swift files and more than 50 functions (including operators), all but 10 consisting of only one line. Stepping through the code in the debugger lead to a call stack a mile long which never seemed to reach a function that did some actual work and then returned, instead it appeared to be just functions all the way down. I don't mean this as criticism of the chapter in particular or functional programming in general, it is more a description of my lack of understanding at that point. So to improve on that and understand functional programming and parser combinators better I am implementing one myself; **[FootlessParser](https://github.com/kareman/FootlessParser)**.

The name comes from the scientific name for Swifts, ["Apodidae"](http://en.wikipedia.org/wiki/Swift), from Greek "apous" meaning "without feet". The word also has [alternate meanings](http://dictionary.reference.com/browse/footless), depending on how the parser turns out it will either be apt or self-deprecating, in any case two of my favourite things.

I will write [about the development here](/blog/footlessparser/). There doesn't seem to be any complete parser combinator frameworks in Swift out there, hopefully this will be useful to others as well.

BTW I really do recommend [the book](http://www.objc.io/books/) for anyone interested in functional programming and Swift, it is well written (and offers a real challenge in the last chapters).
