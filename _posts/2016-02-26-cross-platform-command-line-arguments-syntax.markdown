---
author: kare.morstol@mac.com
comments: true
date: 2016-02-26 12:27:58+00:00
layout: post
old_link: http://blog.nottoobadsoftware.com/uncategorized/cross-platform-command-line-arguments-syntax/
slug: cross-platform-command-line-arguments-syntax
title: Cross-platform command line arguments syntax
wordpress_id: 1098
tags:
- shell
categories: 
- Uncategorized
---

I'm rewriting [Moderator](https://github.com/kareman/Moderator) (yet another command-line argument parser), and with Swift now being available for both OS X and Linux (Ubuntu) it should support a syntax which enables applications to fit in on both platforms.

[POSIX](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html#tag_12_02)* is I think the closest thing to a standard for this, so it will be the basis, with some modifications ([The Python documentation](https://docs.python.org/2/library/optparse.html#background) also has some good insights).

_* OS X is POSIX compliant and so is Linux [(mostly)](https://en.m.wikipedia.org/wiki/POSIX#Mostly_POSIX-compliant)._

<!-- more -->

### Long option names

POSIX states that all options must be of the form `-a` and contain only one character. But `--long-name` is also widely used and often preferable. After all,

    
```bash
transmogrify --input file1 --output file2
```

is easier to understand than


```bash
transmogrify -i file1 -o file2
```

Notably Apple does not follow this norm. Their command-line applications, like `swift`* and `xcodebuild`, use only one `-` in front of their long option names (as in `swift -help`). And, presumably to avoid ambiguity, they do not allow combining several single character options after a single `-`.

_* but not `swift build`._

### Option names should not begin with a number

<blockquote>
  Each option name should be a single alphanumeric character (the alnum character classification) from the portable character set.
</blockquote>

This means that `-4` is a valid option name. But what if the application also takes negative numbers as one of its arguments? This could get confusing, not necessarily for the argument parser, but for us humans. Also I don't think any programming language allows identifiers to begin with a number.

### Allow weird characters in option names

The [portable character set](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap06.html#tag_06_01) mentioned in the previous quote seems rather restrictive (for one it's missing 2 characters from my name). I don't think we should restrict command-line applications to only the English alphabet, there's no reason they can't be in other languages too.

### Allow joining option and argument together with =

It is also quite common to join options and option arguments together:


```bash
transmogrify --input=file1 --output=file2
```

I even prefer this to the standard syntax because it makes it clear what is an option argument and what is a stand-alone argument. Also it makes it possible to have option arguments that begin with a `-` without being mistaken for an option.

## Conclusion

I think good command line syntax should be designed first and foremost with the writers and _readers_ of commands and shell scripts in mind. It should be as clear as possible not only for computers, but also for people reading the commands, even if they are unfamiliar with the application. Hopefully these commonly used additions brings us closer to this goal.
