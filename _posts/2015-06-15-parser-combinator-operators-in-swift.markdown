---
author: kare.morstol@mac.com
comments: true
date: 2015-06-15 00:33:49+00:00
layout: post
old_link: http://blog.nottoobadsoftware.com/footlessparser/parser-combinator-operators-in-swift/
slug: parser-combinator-operators-in-swift
title: Parser combinator operators in Swift
wordpress_id: 847
categories:
- FootlessParser
tags:
- Functional programming
---

_This is part of a [series on FootlessParser](/blog/footlessparser/), a [parser combinator](http://en.wikipedia.org/wiki/Parser_combinator) written in Swift._

* * *

Parser combinators must be one of the best things to come out of functional programming. They let you define intuitive parsers right in the code, without any need for pre-processors.

Like this:

    
```swift
let parser = function1 <^> parser1 <*> parser2 <|> parser3
```

where `function1` and `parser3` return the same type.

`parser` will pass the input to `parser1` followed by `parser2`, pass their results to `function1` and return its result. If that fails it will pass the original input to `parser3` and return its result.

<!-- more -->

### Definitions

Parser

    a function which takes some input (a sequence of tokens) and returns either the output and the remaining unparsed part of the input, or an error description if it fails.

Token

    a single item from the input. Like a character from a string, an element from an array or a string from a sequence of command line arguments.

Parser Input

    most often text, but can also be an array or really any collection of anything, provided it conforms to CollectionType.

### Parsers

The general idea is to combine very simple parsers into more complex ones. So `char("a")`  creates a parser which checks if the next token from the input is an “a”. If it is it returns that “a”, otherwise it returns an error. We can then use operators and functions like `zeroOrMore` and `optional` to create ever more complex parsers. For more check out [ FootlessParser's list of functions](http://kareman.github.io/FootlessParser/Functions.html).

### Operators

#### <^> (map)

```swift
function <^> parser1
```

creates a new parser which runs parser1. If it succeeds it passes the output to `function` and returns the result.

#### <*> (apply)

```swift
function <^> parser1 <*> parser2
```

creates a new parser which first runs parser1. If it succeeds it runs parser2. If that also succeeds it passes both outputs to `function` and returns the result.

The <*> operator requires its left parser to return a function and is normally used together with <^>. `function` must take 2 parameters of the correct types, and it must be [curried](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/doc/uid/TP40014097-CH34-ID363), like this:

```swift
func function (a:A)(b:B) -> C 
```

This is because <*> returns the output of 2 parsers and it doesn't know what to do with them. If you want them returned in a tuple, an array or e.g. added together you can do so in the function before <^> .

If there are 3 parsers and 2 <*> the function must take 3 parameters, and so on.

#### <*

The same as the <*> above, except it discards the result of the parser to its right. Since it only returns one output it doesn't need to be used together with <^> . But you can of course if you want the output converted to something else.

#### *>

The same as <* , but discards the result of the parser to its left.

#### <|>  (choice)

```swift
parser1 <|> parser2 <|> parser3
```

This operator tries all the parsers in order and returns the result of the first one that succeeds.

### Example

* [parse a CSV file](https://github.com/kareman/FootlessParser#csv-parser)

