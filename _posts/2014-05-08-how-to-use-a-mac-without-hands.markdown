---
date: 2014-05-08 14:38:50+00:00
old_link: http://blog.nottoobadsoftware.com/accessibility/how-to-use-a-mac-without-hands/
slug: how-to-use-a-mac-without-hands
title: How to use a Mac without hands
wordpress_id: 638
categories:
- Accessibility
tags:
- head mouse
- head tracking
- iTracker
---

Many people are, like me, unable to use a keyboard and mouse/trackpad for longer periods of time. The solution, as always, is to use your head.


#### Moving the Mouse Pointer



Note


iTracker doesn't automatically start controlling the mouse pointer when launched, even if you tell it to in the preferences. Nor will it do anything when you click the icon in the menu bar and select "Track" from the menu. It will only start working when you press the global keyboard shortcut for pausing and resuming iTracker (Cmd-Shift-T by default).



[iTracker](http://www.eyetwig.com/itracker.html) is the only Mac head mouse software I know of that actually works. It uses the web camera on your Mac to locate your face, see which way it is moving, and move the mouse pointer accordingly. Sounds weird, but it quickly becomes second nature. After adjusting speed and sensitivity you should be able to reach all corners of the screen just by turning your head.

<!-- more -->

In the beginning I couldn't understand why it was working fine some days, and others only intermittently. It turns out some clothing confuses iTracker so it thinks my face is on my chest. It's simply not compatible with all clothes. Also proper lighting is important. If the room is too dark the speed of the mouse pointer will vary depending on how bright the screen image is. Or it won't move at all. I have a lamp pointed at the white wall behind the computer which reflects enough light back on me to keep me properly illuminated. But if large parts of the computer screen rapidly change from light to dark or visa versa the pointer might make a sudden jump, because the amount of light hitting my face changed.


If the pointer starts moving very slowly or not at all, try putting your arms across your chest. This will remind iTracker that your face is not down there. Try different clothes if this happens very often. All in all it's important to not take the things iTracker does personally. Occasionally it will mistake a chair for your face, but it doesn't mean anything by it.



iTracker has not been updated in a while, but the developer has informed me that a new version is under development with some exciting new features I am really looking forward to.


#### Clicking


Having successfully moved the mouse pointer, it would be nice to actually click too. There are several options:

  * A normal mouse/trackpad, preferably a trackpad with separate mouse buttons, that way you won't inadvertently move the pointer before clicking. But dragging only kind of works. You can move windows, but they don't follow along while dragging, they just instantly move to the right spot when you release the button. It's the same when selecting text, the selection only appears after you release the button. Moving files or selected text doesn't work at all, nor resizing windows or table columns etc. 


Note

It's impossible to switch dwell clicking off in iTracker, as the checkbox in the preferences doesn't have any effect. You can work around this by setting the time required to keep your head still to a very high number. You can't set it to more than 20 seconds in the preferences but running this from the terminal will set it to 300:

```bash
defaults write com.eyetwig.iTracker stareClickTimeInSec 300
```

* _Dwell clicking_ in iTracker, which automatically clicks once when you hold your head -- and therefore the pointer -- still for a certain amount of time. This way you can control the pointer using only your head. The downside is you have to keep moving your head if you don't want to click, which can get tiresome after a while. Instead of automatically left clicking you can get a _click menu_ with left clicking, right clicking, middle-clicking, double-clicking and dragg
* [DwellClick](https://pilotmoon.com/dwellclick/) is pretty much the complete solution when it comes to dwell clicking. It can be enabled/disabled just by moving the mouse (no keyboard shortcuts needed), it drags automatically when the cursor is over something exclusively draggable like the border of a window, a scrollbar, a window title bar etc) and it has an easily accessible panel with double-clicking, dragging, right clicking (ctrl-clicking), alt-clicking, cmd-clicking and shift-clicking. These can also be combined for say alt-_dragging_ (for rectangular selection in a text editor). It has excellent support for scripting via AppleScript and is highly configurable.

When using DwellClick together with iTracker and selecting right-clicking all subsequent clicks will be right-clicks. When I notified the developer of DwellClick about this he was extremely quick to come up with a workaround, even though the problem wasn't in his application. Just run this command from the terminal (requires version 2.2.1 or later):
    
```bash
defaults write com.pilotmoon.DwellClick SuppressExternalModifiers -bool YES
```

Note that this will make DwellClick ignore any modifier keys (alt, ctrl, cmd, shift) you press on the keyboard.
