---
date: 2010-12-02 19:15:05+00:00
old_link: http://blog.nottoobadsoftware.com/uncategorized/how-to-import-voice-memos-into-things/
slug: how-to-import-voice-memos-into-things
title: How to import voice memos into Things
wordpress_id: 264
categories: 
- Uncategorized
tags:
- tips &amp; tricks
---

I usually write new ideas into the [Things](http://culturedcode.com/things/) app on my iPhone straight away, but sometimes it’s better to just dictate into the Voice Memo app instead of typing. Here’s how you automatically add those voice memos to the Things inbox:

<!-- more -->
    
  1. Add the folder /Users/<your username>/Music/iTunes/iTunes Music/Voice Memos to [Hazel](http://www.noodlesoft.com/hazel.php).

    
  2. Enter these settings:
[![Screenshot of settings in Hazel](/media/old/system-preferences.png)](/media/old/system-preferences.png)

Here is the script:

    
    
    tell application "Things"
       set props to {name:"Voice memo"}
       set newToDo to make new to do with properties props
       set notes of newToDo to "[filepath=" & POSIX path of theFile & "]TITLE[/filepath]"
    
    end tell
    

Now, every time you make a voice memo on the iPhone and connect it to your computer a note titled “voice memo” with a link to the sound file will be added to the inbox in Things.

If you don’t have Hazel you can achieve the same thing by setting up a folder action on the voice memos folder. But you will have to modify the script.
