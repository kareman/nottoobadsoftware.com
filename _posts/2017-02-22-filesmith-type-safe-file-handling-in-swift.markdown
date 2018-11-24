---
author: kare.morstol@mac.com
comments: true
date: 2017-02-22 17:31:31+00:00
layout: post
link: http://blog.nottoobadsoftware.com/swift/filesmith-type-safe-file-handling-in-swift/
slug: filesmith-type-safe-file-handling-in-swift
title: 'FileSmith: Type-safe file handling in Swift'
wordpress_id: 1239
categories:
- Swift
---

Dealing with file paths in Swift is cumbersome. Using only the standard library leaves us with Strings, which we can join together or split by `/`. It gets the job done but it's not pretty, and we need a separate type so our methods can accept file paths exclusively and not just any old String. Foundation gives us this in NSURL/URL, which are also used for internet URLs so their method names are very general and long. E.g. `url.deletingPathExtension().lastPathComponent` to return the file name without the extension.

The Swift Package Manager has [separate types for absolute paths and relative paths](https://github.com/apple/swift-package-manager/blob/e223d9f6dadc65e63d81c86c305295dc70c4b16c/Sources/Basic/Path.swift), because in their opinion these are fundamentally different. I can see their point, but I think it should be up to the callers of an API and not the creators whether to use absolute or relative paths.

The best alternative I've been able to find is [JohnSundell/Files](https://github.com/JohnSundell/Files), because it gets an important thing right: it differentiates between files and directories. These are fundamentally different things (even though the internal representation of their paths are identical) and should have different types with different functionalities. You can't read from or write to a directory itself, nor can you add a directory to a file.

What I am looking for however has separate types not only for files and folders, but also for paths (which may or may not exist) and filesystem items (which do), and for files you just want to read from and not change and files you want to write to, rename, move and/or delete. Because filesystem access, maybe more than any other task solved by programming, has the potential to irrevocably mess things up. And one way to prevent this is extra type safety, leading to fewer programmer errors.

So I made the [FileSmith](https://github.com/kareman/FileSmith) library with FilePath/DirectoryPath, ReadableFile/WritableFile and Directory.

<!-- more -->

## Paths

Paths are like _potential_ files and directories, addresses to things that already exist and things that soon will, if all goes well. They should be easy to create and combine:


    
    <code class="swift">let dirpath = DirectoryPath("dir/dir1")
    var filepath: FilePath = "file.txt"
    filepath = FilePath(base: "dir", relative: "file.txt")
    filepath = FilePath("dir/file.txt")
    
    dirpath.append(file: "file.txt")    // FilePath("dir/dir1/file.txt")
    dirpath.append(directory: "dir2")   // DirectoryPath("dir/dir1/dir2")
    let l: FilePath = dirpath + "file"
    </code>

_Note that if you use the + operator with a String you need to define the return type, otherwise Swift won't know if it is a file path or a directory path. And you can only append to directory paths._

There is also AnyPath for when you don't know or care what type a path is. All the Path types are lightweight immutable value types conforming to the `Path` protocol. They don't access the file system, with a few exceptions like `.exists`.

## Files

File and Directory objects on the other hand access the file system when they are created, to verify that the file or directory they represent actually exists (otherwise they throw an error). This doesn't necessarily mean there is still something there when you start reading and writing obviously, but it's at least good to know there very recently was.


    
    <code class="swift">// ReadableFile
    let file1 = try filepath.open()
    let file2 = try ReadableFile(open: "file2.txt")
    let file3 = try dir.open(file: "file3.txt")
    
    // WritableFile
    var file1_edit = try filepath.create(ifExists: .open)
    var file2_edit = try WritableFile(create: "file2.txt", ifExists: .throwError)
    file2_edit = try WritableFile(open: "file2.txt")
    let file3_edit = try dir.create(file: "file3.txt", ifExists: .replace)
    </code>

A `ReadableFile` can only be used for reading from a file, never to change, move or delete it. But you can do whatever you want with a `WritableFile`, including reading and overwriting it.

## Directories

For directories there is just the Directory class for both reading and writing, no WritableDirectory and ReadableDirectory like with files, because it's not really clear what that means. If you have a ReadableDirectory it should not be possible to make any changes with it, but you can still use it to get the paths of the files and directories it contains, turn them into writable files and writable directories and then make changes to them. The separation is much more clear-cut with files because they can't contain other files.


    
    <code class="swift">var dir1 = try dirpath.create(ifExists: .replace)
    var dir2 = try Directory(create: "dir/dir2", ifExists: .throwError)
    var dir3 = try dir2.create(directory: "dir3", ifExists: .open)
    dir1 = try dirpath.open()
    dir2 = try Directory(open: "dir/dir2")
    dir3 = try dir2.open(directory: "dir3")
    
    Directory.current.files(recursive: true)
    dir1.files("*3.*", recursive: true)
    Directory.current.directories(recursive: true)
    </code>

## Safety

By default `Directory.sandbox == true` and you can only change files or create new files and directories if they are under the current working directory. Trying to make changes elsewhere throws an error. I like to know there are at least some limits to how badly I can mess things up with a bug.
