---
date: 2019-05-09
title: How to copy a Time Machine backup
post_format: short
categories:
- macOS
tags:
- macOS
- Time Machine
- how to
- tips and tricks
---

Cloning a Time Machine backup from one external hard drive to another is surprisingly difficult.

First – what didn't work:

- Using drag-and-drop in Finder

  This is what Apple recommends in their support article [Time Machine: How to transfer backups from a current backup drive to a new backup drive](https://support.apple.com/en-us/HT202380). But the next day Finder was still on "Preparing to copy". And it hadn't processed anywhere close to the about 27 million files in my 2 TB backup. Some searching revealed this is a common problem, where it will either never finish – or if it does the copy will not be usable in Time Machine.

- Restoring partition in Disk Utility

  This gave the error message "Source volume format on device '/dev/disk3s2' is not valid for restoring". It is a standard Mac OS Extended (Journaled) partition created by Time Machine. First aid in Disk Utility finds no problems.

- Using Carbon Copy Cloner

  [Carbon Copy Cloner](https://bombich.com) is an excellent application, I use it daily for scheduled backups. But it specifically [does not copy Time Machine backups](https://bombich.com/kb/ccc5/can-i-use-carbon-copy-cloner-clone-time-machine-backup).


But [SuperDuper](https://www.shirt-pocket.com/SuperDuper/SuperDuperDescription.html) managed it (in a little over 3 days) – using the default settings (Backup – all files). And it's free for basic functionality.

&nbsp;

References:
- [Apple Stack Exchange](https://apple.stackexchange.com/a/35183)
