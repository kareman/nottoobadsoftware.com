---
date: 2015-08-06 23:52:13+00:00
old_link: http://blog.nottoobadsoftware.com/swift/mixing-default-values-and-variadic-parameters/
slug: mixing-default-values-and-variadic-parameters
title: 'Swift: mixing default values and variadic parameters.'
wordpress_id: 968
categories:
- Swift
tags:
- Swift
- tips &amp; tricks
---

## Update:

As of Xcode 7 beta 6, Swift no longer requires variadic parameters to be last in the function definition. Also argument labels are no longer required when combined with parameters with default values. So this all works fine now:

    
```swift
public func run (executable: String, _ args: String ..., stdinput: String = "default")  {}

run("cmd", stdinput: "not default", "arg1", "arg2")
run("cmd", "arg1", "arg2", stdinput: "not default")
run("cmd", "arg1", "arg2")
```

The rest of this post is deprecated.

<!-- more -->

In [SwiftShell](https://github.com/kareman/SwiftShell) I would like to run a shell command with varying numbers of arguments and have some parameters with default values, like this:

```swift
run("cmd", "arg1", "arg2", stdinput: "not default")
```

which would be defined like so:

```swift
public func run (executable: String, stdinput:String = "default", _ args: String ...) {}
```

[Variadic](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID171) parameters must be last in the definition, but labelled parameters can go after them when calling:


```swift
run("cmd", stdinput: "not default", "arg1", "arg2")
run("cmd", "arg1", "arg2", stdinput: "not default")
```

This however does not work:

```swift
run("cmd", "arg1", "arg2")
// error: missing argument label 'stdinput:' in call
// run("cmd", "arg1", "arg2")
//    ^
//            stdinput: 
```

It seems parameters with default values are no longer optional when used together with variadic parameters.

Well not quite:


```swift
public func run2 (executable: String, stdinput:String = "default", args: String ...) {}

run2("cmd", stdinput: "not default", args: "arg1", "arg2")
run2("cmd", args: "arg1", "arg2", stdinput: "not default")
run2("cmd", args: "arg1", "arg2") 
```

It works, but `run("cmd", "arg1", "arg2")` is inarguably much prettier than `run2("cmd", args: "arg1", "arg2")`.

So to sum up: if you're going to have both parameters with default values and variadic parameters the variadic parameters must have an argument label.
