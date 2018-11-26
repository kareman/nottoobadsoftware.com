---
author: kare.morstol@mac.com
comments: true
date: 2016-05-15 15:46:53+00:00
layout: post
link: http://blog.nottoobadsoftware.com/swiftshell/combine-markdown-files-and-convert-to-html-in-a-swift-script/
slug: combine-markdown-files-and-convert-to-html-in-a-swift-script
title: Combine markdown files and convert to HTML in a Swift script.
wordpress_id: 1138
categories:
- SwiftShell
tags:
- shell
---

_Swift 3_

Sam Burnstone [recently wrote about](https://www.shinobicontrols.com/blog/scripting-in-swift) how to convert a simple shell script to Swift. Here's the same shell script rewritten using [SwiftShell](https://github.com/kareman/SwiftShell) and [FileSmith](https://github.com/kareman/FileSmith).

<!-- more -->

### The shell script
    
```bash
#!/bin/sh

# Extract and format chapter number and title
extract_chapter_title()
{
    chapter_filename=$(basename "$1")
    echo "# ${chapter_filename%.*}"
}

output_file=output/shellscript.html

# Iterate through all files to compile them into a single file
for file in chapters/*; do
    extract_chapter_title "$file"
    printf "\n\n"
    cat "$file"
    printf "\n\n"
done | python -m markdown > "$output_file"

echo "Markdown conversion complete. Output located in $output_file"
```

It reads all the markdown files in the “chapters” directory, joins them together using each filename as a heading and converts everything to HTML. This is actually a very nice and clear* shell script, I especially like how the "for" loop is piped directly into the shell command so I did the same in the SwiftShell version.

_* except for "%.*" in line 7, which leaves out the file extension_

### SwiftShell



```swift
#!/usr/bin/env swiftshell

import SwiftShell
import FileSmith

do {
    var output_file = try WritableFile(create: "swiftshellscript.html", ifExists: .replace)

    // Iterate through all files to compile them into a single file
    try Directory(open: "chapters").files()
        .map { filepath in
            try "# " + filepath.nameWithoutExtension + "\n\n" + filepath.open().read()
        }.joined(separator: "\n\n")
        .run("python", "-m", "markdown")
        .stdout.write(to: &output_file)

    print("Markdown conversion complete. Output located in", output_file.path)

} catch {
    exit(error)
}
```

I think this is more readable and more explicit about what is going on, though a lot wordier. I especially like how each "try" makes it clear where things can go wrong. Also this is mostly standard Swift and Foundation code, the only parts from SwiftShell are “open” and “run”.

Note that top-level Swift code which can throw does not need to be enclosed in a "do ... catch" clause, but the resulting error messages printed to standard error are quite ugly and hard to read. The exit method from SwiftShell makes them prettier.

* _2016-11-02: updated to Swift 3._
* _2017_04_28: updated to SwiftShell 3.0 and added [FileSmith](https://github.com/kareman/FileSmith)_.


