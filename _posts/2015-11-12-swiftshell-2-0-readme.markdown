---
author: kare.morstol@mac.com
comments: true
date: 2015-11-12 01:37:45+00:00
layout: post
link: http://blog.nottoobadsoftware.com/swiftshell/swiftshell-2-0-readme/
slug: swiftshell-2-0-readme
title: SwiftShell 2.0 Readme
wordpress_id: 1046
categories:
- SwiftShell
tags:
- Swift
---

_I finally got around to updating the [SwiftShell 2.0 readme](https://github.com/kareman/SwiftShell/tree/SwiftShell2) with some actual usage instructions:_

SwiftShell: An OS X Framework for command line scripting in Swift.

<!-- more -->

## Usage

Put this at the beginning of each script file:


    
    <code class="swift">#!/usr/bin/env swiftshell
    
    import SwiftShell
    </code>

### Run commands

#### Print output


    
    <code class="swift">try runAndPrint(bash: "cmd1 arg | cmd2 arg") 
    </code>

Runs a shell command just like you would in the terminal. If the command returns with a non-zero exit code it will throw a ShellError.

_The name may seem a bit cumbersome, but it explains exactly what it does. SwiftShell never prints anything without explicitly being told to._

<!-- more -->

#### In-line


    
    <code class="swift">let date: String = run("date", "-u")
    print("Today's date in UTC is " + date)
    </code>

Similar to `$(cmd)` in bash, this just returns the output from the command as a string, ignoring any errors.

#### Asynchronous


    
    <code class="swift">let command = runAsync("cmd", "-n", 245)
    // do something with command.stderror or command.stdout
    do {
        try command.finish()
    } catch {
        // deal with errors. or not.
    }
    </code>

Launch a command and continue before it's finished. You can process standard output and standard error, and optionally wait until it's finished and handle any errors.

If you read all of command.stderror or command.stdout it will automatically wait for the command to finish running. You can still call `finish()` to check for errors.

#### Parameters

The 3 `run` functions above take 2 different types of parameters:

**(executable: String, _ args: Any ...)**

If the path to the executable is without any `/`, SwiftShell will try to find the full path using the `which` shell command.

The array of arguments can contain any type, since everything is convertible to strings in Swift. If it contains any arrays it will be flattened so only the elements will be used, not the arrays themselves.


    
    <code class="swift">run("echo", "We are", 4, "arguments")
    // echo "We are" 4 arguments
    
    let array = ["But", "we", "are"]
    run("echo", array, array.count + 2, "arguments")
    // echo But we are 5 arguments
    </code>

**(bash bashcommand: String)**

These are the commands you normally use in the Terminal. You can use pipes and redirection and all that good stuff. Support for other shell interpreters can easily be added.

### Output

`main.stdout` is for normal output and `main.stderror` for errors:


    
    <code class="swift">main.stdout.writeln("...")
    
    main.stderror.write("something went wrong ...")
    </code>

### Input

Use `main.stdin` to read from standard input:


    
    <code class="swift">let input: String = main.stdin.read()
    </code>

### Main

So what else can `main` do? It is the only global value in SwiftShell and contains all the contextual information about the outside world:


    
    <code class="swift">var encoding: UInt
    lazy var env: [String : String]
    
    lazy var stdin: ReadableStream
    lazy var stdout: WriteableStream
    lazy var stderror: WriteableStream
    
    var currentdirectory: String
    lazy var tempdirectory: String
    
    lazy var arguments: [String]
    lazy var name: String
    </code>

Everything is mutable, so you can set e.g. the text encoding or reroute standard error to a file.

## Examples

### Print line numbers


    
    <code class="swift">do {
        let input = try main.arguments.first.map {try open($0)} ?? main.stdin
    
        input.read().characters.split("\n")
            .enumerate().map { (linenr,line) in "\(linenr+1): " + String(line) }
            .joinWithSeparator("\n").writeTo(&main.stdout)
    
        // add a newline at the end
        print("")
    } catch {
        exit(error)
    }
    </code>

Launched with e.g. `cat long.txt | print_linenumbers.swift` or `print_linenumbers.swift long.txt` this will print the line number at the beginning of each line.

## Installation

* In the Terminal, go to where you want to download SwiftShell.
* Run
```bash    
git clone https://github.com/kareman/SwiftShell.git
cd SwiftShell
git checkout SwiftShell2
```
* Copy/link `Misc/swiftshell` to your bin folder or anywhere in your PATH.
* To install the framework itself, either:
  * run `xcodebuild install` from the project's root folder. This will install the SwiftShell framework in ~/Library/Frameworks.
  * _or_ run `xcodebuild` and copy the resulting framework from the build folder to your library folder of choice. If that is not "~/Library/Frameworks", "/Library/Frameworks" or a folder mentioned in the $SWIFTSHELL_FRAMEWORK_PATH environment variable then you need to add your folder to $SWIFTSHELL_FRAMEWORK_PATH.


