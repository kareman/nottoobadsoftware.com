---
author: kare.morstol@mac.com
comments: true
date: 2010-03-04 00:07:36+00:00
layout: post
link: http://blog.nottoobadsoftware.com/dictation/dictating-on-a-mac-with-dragon-naturallyspeaking/
slug: dictating-on-a-mac-with-dragon-naturallyspeaking
title: Dictating on a Mac with Dragon NaturallySpeaking
wordpress_id: 143
categories:
- Dictation
tags:
- Dragon NaturallySpeaking
- tips &amp; tricks
---

As I have mentioned before I'm not a big fan of MacSpeech Dictate. So I use Dragon NaturallySpeaking in Windows XP running under Parallels Desktop 4 when I need to dictate something. It's working very well, but it is of course very tedious to have to copy and paste everything I dictate from Windows back into my Mac applications. Luckily Tim Harper has made [tightvnc-dns](http://github.com/timcharper/tightvnc-dns), a Windows application that reroutes the generated keystrokes from Dragon NaturallySpeaking back to the Mac side. You can't use Dragon to edit the text you dictate this way, but for shorter pieces of text it is very practical.<!-- more -->

It is very easy to setup, just follow these simple steps:



	
  1. In the configuration for your Windows virtual machine in Parallels Desktop, under Network Adapter 1, select "Shared Networking" (or the equivalent for VMware Fusion).

	
  2. In System Preferences, under Sharing, enable screen sharing:
![](http://50.87.248.205/~nottooba/blog/wp-content/uploads/2010/03/sharing.png)
Note your IP address (circled in red).

	
  3. Click "Computer Settings":
![](http://blog.nottoobadsoftware.com/wp-content/uploads/2010/03/Snap.png)
Enter a password, otherwise tightvnc-dns may not be able to connect.

	
  4. In your Windows virtual machine, download and unzip tightvnc-dns from [here](http://github.com/downloads/timcharper/tightvnc-dns/vncviewer.zip).

	
  5. Double-click vncviewer.exe :
![](http://50.87.248.205/~nottooba/blog/wp-content/uploads/2010/03/parallels-desktop.jpg)
Enter the IP address from step 2 (not necessarily 192.168.4.4 :)).

	
  6. Click "Options":
![](http://50.87.248.205/~nottooba/blog/wp-content/uploads/2010/03/parallels-desktop-21.jpg)
Click "Disable clipboard transfer".  And reduce the scale if you want a smaller window.

	
  7. Click "OK" and then "Connect". Enter the password from step 3 and click "OK".

	
  8. Switch to a Mac application, making sure that vncviewer is still selected in the Windows virtual machine and Dragon NaturallySpeaking is running and active.

	
  9. Start dictating and the text should appear in the active Mac application!


