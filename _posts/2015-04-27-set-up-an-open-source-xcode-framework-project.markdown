---
author: kare.morstol@mac.com
comments: true
date: 2015-04-27 17:14:11+00:00
layout: post
link: http://blog.nottoobadsoftware.com/footlessparser/set-up-an-open-source-xcode-framework-project/
slug: set-up-an-open-source-xcode-framework-project
title: Set up an open source Xcode framework project
wordpress_id: 697
categories:
- FootlessParser
tags:
- tips &amp; tricks
- Xcode
---

_This is part of a [series on FootlessParser](footlessparser/), a [parser combinator](http://en.wikipedia.org/wiki/Parser_combinator) written in Swift._

* * *

I find these steps helpful when setting up any new open source framework project in Xcode.

### Create project

[https://github.com/kareman/FootlessParser/commit/414e3961d3bb2a2df8a257804534578bc7a06461](https://github.com/kareman/FootlessParser/commit/414e3961d3bb2a2df8a257804534578bc7a06461)

Create a new project in Xcode, and select OS X framework if it is for both iOS and OS X. The iOS framework target can be added later, besides OS X frameworks are more practical for unit testing. No simulators needed.

Do _not_ select to add it to Git right away. [Because of this](/2015/01/18/adding-an-xcode-project-to-git/).

And that's it. I so do love a fresh project.

### Create root folders “tests” and “source” and move stuff in place in Xcode

[https://github.com/kareman/FootlessParser/commit/9e43f2f3d284c960c011aa2eecb646df4eb75d15](https://github.com/kareman/FootlessParser/commit/9e43f2f3d284c960c011aa2eecb646df4eb75d15)

The file structure of Xcode projects looks better, especially on GitHub, if the code for the product itself is in “source” and the test code in “tests”. It's better than just dumping all Xcode targets in the root folder. Especially for this project, as it will have test targets for both unit tests, speed tests and integration tests.

### Share the only scheme.

[https://github.com/kareman/FootlessParser/commit/4eac262ad46fdb846b968d2bb8d5936a3c26d941](https://github.com/kareman/FootlessParser/commit/4eac262ad46fdb846b968d2bb8d5936a3c26d941)

Schemes are not shared by default in Xcode. It's best to share this now since you're bound to be making changes to it in the future, and if it's not shared no one else will receive those changes. While you will be merrily coding along, assuming what you see everyone else sees too.

### Add license.

[https://github.com/kareman/FootlessParser/commit/4ee0dda754593e4355e348d43c7dce4869d00ac6](https://github.com/kareman/FootlessParser/commit/4ee0dda754593e4355e348d43c7dce4869d00ac6)

Which licence to release open source code under is of course entirely a matter of preference. Personally I agree most with the [Eclipse licence](https://www.eclipse.org/legal/epl-v10.html) because I would prefer anyone who make any changes to make them public and open source as well. But I also want my open source projects to be available to as many people as possible, and the MIT license is very popular and compatible with most other licences, including GPL. And it is used by all the open source frameworks this project uses. It is also very short, which is always a good thing for legalese text.

### Upload to GitHub

After adding some actual code it's time to share the work with the world. It is easiest to use [GitHub for Mac](https://mac.github.com/index.html) as it both creates the project on GitHub and uploads the code.
