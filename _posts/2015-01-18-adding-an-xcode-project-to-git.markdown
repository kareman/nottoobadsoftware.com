---
author: kare.morstol@mac.com
comments: true
date: 2015-01-18 22:37:27+00:00
layout: post
old_link: http://blog.nottoobadsoftware.com/uncategorized/adding-an-xcode-project-to-git/
slug: adding-an-xcode-project-to-git
title: Adding an XCode project to Git
wordpress_id: 691
categories: 
- uncategorized
tags:
- Git
- tips &amp; tricks
- Xcode
---

When creating a new project in Xcode it is best to leave the "Create Git repository" box unchecked because it will immediately add _all_ files to Git, including those that are specific to you and are of no interest to anyone else. Instead you can run [this script](https://gist.github.com/kareman/4f97459439804443cb87) from the project folder, which will add only the files that should be under version control:

<!-- more -->

```bash
#!/bin/bash -x

# create the ignore file
cat > .gitignore <<_EOF_
# Xcode
#
.DS_Store
build/
*.pbxuser
!default.pbxuser
*.mode1v3
!default.mode1v3
*.mode2v3
!default.mode2v3
*.perspectivev3
!default.perspectivev3
xcuserdata
*.xccheckout
*.moved-aside
DerivedData
*.hmap
*.ipa

# CocoaPods
#
# We recommend against adding the Pods directory to your .gitignore. However
# you should judge for yourself, the pros and cons are mentioned at:
# http://guides.cocoapods.org/using/using-cocoapods.html#should-i-ignore-the-pods-directory-in-source-control?
#
# Pods/
_EOF_

git init
git add .
git commit -m 'Initial commit'
```
