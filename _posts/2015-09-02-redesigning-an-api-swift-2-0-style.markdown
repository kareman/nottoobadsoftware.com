---
date: 2015-09-02 17:35:30+00:00
old_link: http://blog.nottoobadsoftware.com/swiftshell/redesigning-an-api-swift-2-0-style/
slug: redesigning-an-api-swift-2-0-style
title: Redesigning an API - Swift 2.0 style
wordpress_id: 980
categories:
- SwiftShell
tags:
- Swift
---

[SwiftShell](https://github.com/kareman/SwiftShell/tree/master) (an OS X framework for shell scripting in Swift) is currently using the `|>` operator to combine shell commands, streams and functions, and `|>>` to print the results:
    
```swift
// SwiftShell 1

run("echo piped to the next command") |> run("wc -w") |>> standardoutput

// print out line number and content of each line in standard input
var i = 1
standardinput.lines() |> map {line in "line \(i++): \(line)\n"} |>> standardoutput
```

But Swift 2.0 is here, and it's clear the way forward is protocols, method chaining and error handling. And being more explicit about what is going on. So for SwiftShell 2 I'm planning something like this:

<!-- more -->

    
```swift
// SwiftShell 2

run(bash:"echo piped to the next command").run("wc","-w").writeTo(standardoutput)

main.stdin.lines()
    .enumerate { linenr,line in "line \(linenr+1): \(line)\n" }
    .join().writeTo(main.stdout)
```

And this (listing all executables available in PATH):


```swift
// SwiftShell 1
environment["PATH"]! |> split(":")
    |> map { directory in run("find \"\(directory)\" -type f -perm +ugo+x -print") }
    |>> standardoutput

// SwiftShell 2
main.env["PATH"]!.characters.split(":")
    .forEach { directory in try! runAndPrint(bash:"find \"\(String(directory))\" -type f -perm +ugo+x -print") }
```

Maybe SwiftShell 1 looks cooler ( `|>` is after all very cool), but I think [SwiftShell 2](https://github.com/kareman/SwiftShell/tree/2.1) is cleaner and shows more clearly what's going to happen. It also makes it easier to take advantage of the Swift standard library, and most importantly is more [in keeping with the spirit of Swift 2.0](http://airspeedvelocity.net/2015/06/23/protocol-extensions-and-the-death-of-the-pipe-forward-operator/).
