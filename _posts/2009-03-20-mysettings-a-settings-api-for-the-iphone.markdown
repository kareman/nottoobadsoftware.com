---
author: kare.morstol@mac.com
comments: true
date: 2009-03-20 19:56:35+00:00
layout: post
old_link: http://blog.nottoobadsoftware.com/iphone-development/mysettings-a-settings-api-for-the-iphone/
slug: mysettings-a-settings-api-for-the-iphone
title: 'mySettings: A Settings API for the iPhone'
wordpress_id: 7
categories:
- iPhone development
tags:
- iPhone
- mySettings
---

NB: Unfortunately I am not able to do any more development on this or any other projects. I am hoping that someone else will take over the project and update it. There is also [this similar project](http://bitbucket.org/keegan3d/inappsettings/wiki/Home).A lot of iPhone apps have their own settings views similar to the ones in the Settings App on the iPhone home screen. But to my surprise I couldn't find any general API for it. So I made my own and published it [here](http://bitbucket.org/karemorstol/mysettings). It uses a plist configuration file like the one used by the Settings App, with some added options (and some removed ones, but they will hopefully be implemented in the near future).

In a nutshell it takes a plist like this:

[![plist](http://bitbucket.org/karemorstol/mysettings/wiki/plist.jpg)](http://bitbucket.org/karemorstol/mysettings/wiki/plist_full.jpg)

and turns it into this:

![iPhone](http://bitbucket.org/karemorstol/mysettings/wiki/iPhone.jpg)

### Features

	
  * Text fields, on/off switch button, integers and time intervals (with maximum/minimum values and custom format string for the integers).
_ More options are needed, obviously, like dates and select lists. Feel free to help out if there are other options you would like to see implemented._

	
  * Titles can be indented.

	
  * By default the settings themselves are stored in the standard user defaults object ([NSUserDefaults standardUserDefaults]), but you can use any object that supports key-value coding. This enables you to use your model classes directly in the settings view.

	
  * And if you don't find blue pyjama stripes exciting, you can of course change the table view background.

And that's it for the time being. A work in progress, obviously. I would also like to see support for custom table cells and dynamically filling a section with the contents of an array or a dictionary. And localisation. And sliders. And customising fonts and colours. And lots more cool stuff. So if you want to check it out, follow [these instructions](http://bitbucket.org/karemorstol/mysettings/wiki/Installation). And if you make any changes please let me know so I can merge them back into the repository.
