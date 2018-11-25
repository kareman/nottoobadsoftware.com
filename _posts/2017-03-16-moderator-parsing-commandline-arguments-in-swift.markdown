---
author: kare.morstol@mac.com
comments: true
date: 2017-03-16 23:52:40+00:00
layout: post
link: http://blog.nottoobadsoftware.com/swift/moderator-parsing-commandline-arguments-in-swift/
slug: moderator-parsing-commandline-arguments-in-swift
title: 'Moderator: parsing commandline arguments in Swift'
wordpress_id: 1248
categories:
- Swift
tags:
- shell
---

There are a lot of command line argument parsers written in Swift available on Github, so when I needed one for a client project I was surprised I could not find any which fulfilled these requirements: 

* handle `--tag=value`.
* treat unrecognised arguments as an error and list them.

Nor could I find any where it would be relatively easy to add these features, since most just loop through the arguments from first to last and have one big function trying to find out what to do with each of them. That becomes messy quickly.

 I think it's much simpler to create multiple small argument parsers, where each one in turn takes in the list of arguments, removes the ones it wants to handle and passes the rest on to the next one. Any arguments left over are then unrecognised and can be handled accordingly. This way the end user does not need to worry about the order of the arguments. The developer however needs to be careful about the order of the parsers.

<!-- more -->

So I created [Moderator](https://github.com/kareman/Moderator) with these goals:

* required arguments and those with default values should not produce optionals.
* easily combine parsers.
* type-safe.
* make it easy to ensure all provided arguments are valid before acting upon any of them.

And as always:

* as simple as possible, but no simpler.

And this is what it looks like (from [linuxmain-generator](https://github.com/kareman/linuxmain-generator)):
    
    ```swift
    import Moderator
    import FileSmith
    
    let arguments = Moderator(description: "Automatically add code to Swift Package Manager projects to run unit tests on Linux.")
    let overwrite = arguments.add(.option("o","overwrite", description: "Replace <test directory>/LinuxMain.swift if it already exists."))
    let testdirarg = arguments.add(Argument<String?>
        .optionWithValue("testdir", name: "test directory", description: "The path to the directory with the unit tests.")
        .default("Tests"))
    _ = arguments.add(Argument<String?>
        .singleArgument(name: "directory", description: "The project root directory.")
        .default("./")
        .map { (projectpath: String) in
            let projectdir = try Directory(open: projectpath)
            try projectdir.verifyContains("Package.swift")
            Directory.current = projectdir
        })
    
    do {
        try arguments.parse()
    
        let testdir = try Directory(open: testdirarg.value)
        if !overwrite.value && testdir.contains("LinuxMain.swift") {
            throw ArgumentError(errormessage: "\(testdir.path)/LinuxMain.swift already exists. Use -o/--overwrite to replace it.")
        }
        ...
    } catch {
        WritableFile.stderror.print(error)
        exit(Int32(error._code))
    }
    ```

For more, see [the project homepage](https://github.com/kareman/Moderator/#built-in-parsers).
