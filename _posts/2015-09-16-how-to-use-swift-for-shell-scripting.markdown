---
comments: true
date: 2015-09-16 23:48:05+00:00
old_link: http://blog.nottoobadsoftware.com/swiftshell/how-to-use-swift-for-shell-scripting/
slug: how-to-use-swift-for-shell-scripting
title: How to use Swift for shell scripting
wordpress_id: 999
categories:
- SwiftShell
tags:
- shell
- Swift
---

To be honest I'm not very good at shell scripting. It's very useful for automation so I would like to be, but I just don't like the syntax. For instance, this is how you check if a variable is greater than 100:

```bash
#!/bin/bash

if [ $var -gt 100 ]
then
    <do some stuff>
fi
```

<!-- more -->

And here's how to check if the file referred to in the first argument is readable and not empty:

```bash
if [ -r $1 ] && [ -s $1 ]
```

Enough said.

So I would much rather use Swift, as the syntax is nice, very nice indeed. But the things that bash shell scripts actually _are_ good at, like running shell commands and accessing the shell environment, are not that straightforward in Swift. Here's how you can perform the various tasks using only the Swift Standard Library and Foundation:

#### Run shell commands



```swift
let cmd = "some shell command"
NSTask.launchedTaskWithLaunchPath("/bin/bash", arguments:["-c", cmd]).waitUntilExit()
```

NSTask ([Apple](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSTask_Class), [raywenderlich.com](http://www.raywenderlich.com/36537/nstask-tutorial)) is actually an excellent API which launches asynchronous external processes and has customisable environment, input and outputs. But it definitely needs some helper functions to make it easier to use.

There is also the `system` function (which has been deprecated) and [`posix_spawn`](https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man2/posix_spawn.2.html) which is a C API with lots of inout parameters. Again; enough said.

#### Read input and provide output

Swift's [`readLine`](http://swiftdoc.org/swift-2/func/readLine/) function reads standard input line by line. And [`print`](http://swiftdoc.org/swift-2/func/print/) (previously known as `println`) prints to standard output.

For more direct control, like seeking and reading and writing binary data, you can use [file handles](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSFileHandle_Class/):



```swift
let stdin    = NSFileHandle.fileHandleWithStandardInput()
let stdout   = NSFileHandle.fileHandleWithStandardOutput()
let stderror = NSFileHandle.fileHandleWithStandardError()

let input: NSData = stdin.readDataToEndOfFile()

let output: NSData = ...
stdout.writeData(output)
```

#### Use environment variables



```swift
let env = NSProcessInfo.processInfo().environment as [String: String]
let path = env["PATH"]!
```

#### Access arguments



```swift
let arguments: [String] = Process.arguments.count <= 1 ? [] : Array(Process.arguments.dropFirst())
```

The first element is discarded because it, as is the custom in shell scripting, contains the path to the script file itself.

#### Read and write files



```swift
let filepath = "file.txt"

if let file = NSFileHandle(forUpdatingAtPath: filepath) {

    // read text
    let data: NSData = file.readDataToEndOfFile()
    let contents = NSString(data: data, encoding: NSUTF8StringEncoding)! as String

    // write text
    let text = "some text"
    file.writeData(text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:false)!)
}
```

Or preferably:



```swift
import Foundation

extension NSFileHandle {

    public func readSome (encoding encoding: NSStringEncoding = NSUTF8StringEncoding) -> String? {
        let data: NSData = self.availableData

        guard data.length > 0 else { return nil }
        guard let result = NSString(data: data, encoding: encoding) else {
            fatalError("Could not convert binary data to text.")
        }

        return result as String
    }

    public func read (encoding encoding: NSStringEncoding = NSUTF8StringEncoding) -> String {
        let data: NSData = self.readDataToEndOfFile()

        guard let result = NSString(data: data, encoding: encoding) else {
            fatalError("Could not convert binary data to text.")
        }

        return result as String
    }
}

extension NSFileHandle {

    public func write <T> (x: T, encoding: NSStringEncoding = NSUTF8StringEncoding) {
        guard let data = String(x).dataUsingEncoding(encoding, allowLossyConversion:false) else {
            fatalError("Could not convert text to binary data.")
        }
        self.writeData(data)
    }

    public func writeln <T> (x: T, encoding: UInt = NSUTF8StringEncoding) {
        self.write(x, encoding: encoding)
        self.write("\n", encoding: encoding)
    }
}
```

`readSome` takes whatever text is available in the file handle and returns it, whereas `read` waits for the file handle to be closed and then returns all its contents. If the file handle is never closed it never returns.

* * *

Most of the code here is from [SwiftShell](https://github.com/kareman/SwiftShell), a library which makes shell scripting in Swift much simpler.
