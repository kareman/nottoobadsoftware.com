---
date: 2015-04-22 18:18:49+00:00
old_link: http://blog.nottoobadsoftware.com/footlessparser/introduction-to-footlessparser/
slug: introduction-to-footlessparser
title: Introduction to FootlessParser
wordpress_id: 754
categories:
- FootlessParser
tags:
- Functional programming
---

_This post is part of a [series on FootlessParser](/blog/footlessparser/), a [parser combinator](http://en.wikipedia.org/wiki/Parser_combinator) written in Swift._

* * *

The goal is to define parsers like this:

    
```swift
let parser = function1 <^> parser1 <*> parser2 <|> parser3
```

where `parser` will pass the input to `parser1` followed by `parser2`, pass their results to `function1` and return its result. If that fails it will pass the original input to `parser3` and return its result.

<!-- more -->

# Terms

Parser
: a function which takes some input (a sequence of tokens) and returns either the output and the remaining unparsed part of the input, or an error description if it fails.

Token
: a single item from the input. Like a character from a string, an element from an array or a string from a sequence of command line arguments.

Parser Input
: most often text, but can also be an array or really any collection of anything, provided it conforms to CollectionType.

# First version

Initially FootlessParser will be the simplest possible implementation of a parser combinator in Swift. It will:

* have at least rudimentary error reporting, because it makes writing parsers so much easier.
* not parse ambiguous grammars. Each parser will return at most one result, not a list of all possible results.
* not handle left recursion. Like most parser combinators.
* probably be slow. It's going to be very interesting to see how slow.

# Future improvements

* Memoization, should help with speed.
* Left recursion.
* Ambiguous grammars (maybe).
* SequenceType as input.

