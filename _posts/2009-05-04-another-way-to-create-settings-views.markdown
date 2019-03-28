---
comments: true
date: 2009-05-04 19:26:56+00:00
old_link: http://blog.nottoobadsoftware.com/iphone-development/another-way-to-create-settings-views/
slug: another-way-to-create-settings-views
title: Another way to create Settings views
wordpress_id: 58
categories:
- iPhone-Development
tags:
- mySettings
---

Craig Hockenberry has also created an API for Settings views. But unlike [mySettings](http://bitbucket.org/karemorstol/mysettings/wiki/Home) his API creates the views from code instead of plists. Like this:

    
    
    - (void)constructTableGroups
    {
    NSMutableArray *cells = [NSMutableArray array];
    IFTextCellController *textCell = [[[IFTextCellController alloc] initWithLabel:@"Text" andPlaceholder:@"Placeholder" atKey:@"sampleText" inModel:model] autorelease];
    [cells addObject:textCell];
    IFSwitchCellController *switchCell = [[[IFSwitchCellController alloc] initWithLabel:@"Switch" atKey:@”sampleSwitch” inModel:model] autorelease];
    [cells addObject:switchCell];
    tableGroups = [[NSArray arrayWithObject:cells] retain];
    }
    

Check it out at [http://furbo.org/2009/04/30/matt-gallagher-deserves-a-medal/](http://furbo.org/2009/04/30/matt-gallagher-deserves-a-medal/) .
