---
author: kare.morstol@mac.com
comments: true
date: 2009-05-21 18:32:47+00:00
layout: post
old_link: http://blog.nottoobadsoftware.com/iphone-development/customising-a-table-view-with-mysettings/
slug: customising-a-table-view-with-mysettings
title: Customising a table view with mySettings
wordpress_id: 61
categories:
- iPhone development
tags:
- mySettings
---

I've been working on my iPhone app lately (for performing physical exercises like the ones you get from a physiotherapist, but more about that later) so I haven't written anything for a long time. I thought I'd rectify that by showing how to create highly customised UIs with fairly little coding. I recently added support for delegates to [mySettings](http://bitbucket.org/karemorstol/mysettings/wiki/Home) and that opened up a lot of possibilities, even with only one method in the delegate (for now).

As an example, here's the configuration screen for my app:

![Configuration screen](/media/old/untitled.jpg)

<!-- more -->To do this I had to, of course, [install mySettings](http://bitbucket.org/karemorstol/mysettings/wiki/Installation). Then create this plist:

![Plist configuration file](/media/old/untitled-2.jpg)

And configure the table view:


    
    
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"ExerciseSettingsView" ofType:@"plist"];
    tableviewdelegate = [[ExerciseSettingsTableViewDelegate alloc] initWithConfigFile:plist andSettings:exercise];
    tableviewdelegate.delegate = self;
    tableviewdelegate.viewcontroller = self;
    
    tableview.backgroundColor = [UIColor clearColor];
    tableview.rowHeight = 53;
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.separatorColor = [UIColor clearColor];
    
    tableview.delegate = tableviewdelegate;
    tableview.dataSource = tableviewdelegate;
    

"exercise" is the model object containing the values, including the array "repetitions" populating the bottom section of the table view. "ExerciseSettingsTableViewDelegate"  is a subclass of "SettingsMetadataSource" from mySettings. I use it to override


    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

so I can add on the alternating background images (since I need the row number for that). I also override


    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

to provide the different row heights for the two sections.

The bottom section has custom cells, but the top one uses the standard cells from mySettings. To customise the fonts,  colours, background view and accessory view I use the delegate function


    
    - (void) cellDidInit:(SettingsCell *)cell

which is called right after the cell has been initialised.

### The tricky bit

Sadly the difficult part is still left; the user needs to be able to add, remove and reorder the cells in the bottom section, and I have not been able to find a way to customise the reorder control. The built-in one looks completely out of place here. Not to mention the red minus sign for removing cells.
