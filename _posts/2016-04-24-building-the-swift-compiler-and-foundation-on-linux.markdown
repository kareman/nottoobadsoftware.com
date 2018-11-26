---
author: kare.morstol@mac.com
comments: true
date: 2016-04-24 22:12:12+00:00
layout: post
old_link: http://blog.nottoobadsoftware.com/swift/building-the-swift-compiler-and-foundation-on-linux/
slug: building-the-swift-compiler-and-foundation-on-linux
title: Building the Swift compiler and Foundation on Linux
wordpress_id: 1123
categories:
- Swift
tags:
- Linux
---

Before building the Swift compiler it might be a good idea to check [https://github.com/apple/swift](https://github.com/apple/swift) to verify the build is currently passing. And to free up as much memory as possible first you can shut down the graphical interface with `sudo service lightdm stop`.

(has been tested on Ubuntu 15.10):

<!-- more -->

```bash
#!/usr/bin/env bash

# exit at the first sign of trouble
set -e

sudo apt-get update
sudo apt-get install -y build-essential wget clang libedit-dev python2.7 python2.7-dev rsync libxml2 git
sudo apt-get install -y cmake ninja-build python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config

#If on Ubuntu 14.04 LTS, upgrade the clang compiler for C++14 support and create a symlink:
#sudo apt-get install clang-3.6
#sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100
#sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100

mkdir swift
cd swift
git clone https://github.com/apple/swift.git
swift/utils/update-checkout --clone

swift/utils/build-script
```

... and then do something else for a while. On an iMac 2011 quad core with 16 GB of memory running a fresh install of Ubuntu 15.10 with no GUI it took 3 hours.

If you're going to work on Foundation you will want to replace the last line with this:


    
```bash
swift/utils/build-script --xctest --foundation -t
cd swift-corelibs-foundation
```

Then just run `ninja` to build your changes and `ninja test` to test. Thankfully this is a lot faster than building swift.
