---
author: kare.morstol@mac.com
comments: true
date: 2016-04-12 13:03:26+00:00
layout: post
link: http://blog.nottoobadsoftware.com/swiftshell/move-files-to-the-trash/
slug: move-files-to-the-trash
title: Move files to the trash with a Swift script
wordpress_id: 1108
categories:
- SwiftShell
tags:
- shell
- Swift
---

_Swift 3_

I really don't like using the ‘rm’ shell command – one misplaced character and you can do some serious damage. But when working in the Finder I don't think twice about deleting files, because I know I can always get them back from the trash. So here is a Swift shell script which does exactly that – it moves files to the trash instead of deleting them permanently.

The syntax is very simple – all parameters refer to file system items which should be moved to the trash:

    
    <code class="bash">trash file.txt a_folder
    trash *.m *.h
    </code>

<!-- more -->

The code ([gist](https://gist.github.com/kareman/322c1091f3cc7e1078af))

    
    <code class="swift">import SwiftShell
    
    import Dispatch
    import Cocoa
    
    extension Sequence where Iterator.Element: Hashable {
        /// Returns an array containing each element in `self` only once, in the same order. Complexity: O(n)
        func removeDuplicates () -> [Iterator.Element] {
            var alreadyhere = Set<Iterator.Element>(minimumCapacity: underestimatedCount)
            return filter { x in alreadyhere.contains(x) ? false : { alreadyhere.insert(x); return true }() }
        }
    }
    
    DispatchQueue.main.async {
        let filesToTrash = main.arguments.removeDuplicates().map(URL.init(fileURLWithPath:))
    
        NSWorkspace.shared().recycle(filesToTrash) { trashedFiles, error in
            guard let error = error else { exit(0) }
    
            main.stderror.print("Files that could not be trashed:")
            for file in filesToTrash where trashedFiles[file] == nil {
                main.stderror.print(file.relativePath)
            }
            main.stderror.print()
            exit(error)
        }
    }
    
    RunLoop.current.run()
    </code>

The script is based on [this gist](https://gist.github.com/brentdax/4a48a5024dd01c1821b8) but updated for Swift 3 and uses SwiftShell for output to standard error. The actual work of moving the files to the trash is performed by [NSWorkspace.sharedWorkspace().recycleURLs](https://developer.apple.com/library/etc/redirect/xcode/mac/1153/documentation/Cocoa/Reference/ApplicationKit/Classes/NSWorkspace_Class/index.html#//apple_ref/swift/instm/NSWorkspace/c:objc(cs)NSWorkspace(im)recycleURLs:completionHandler:). Since this is an asynchronous method we need to launch it in a Grand Central Dispatch block and then have the [run loop wait](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSRunLoop_Class/index.html#//apple_ref/occ/instm/NSRunLoop/run) until the method is finished so we get a chance to print any errors before the script exits.

We call `removeDuplicates` on the arguments list to avoid an error message if we try to trash the same file item twice. Then in the callback from `recycleURLs` we check for errors – if there are any we print the names of the file items that could not be trashed, and then the error.

* _Update 2016–10–09: converted to Swift 3._
* _Update 2017-04-28: updated to SwiftShell 3.0_.

