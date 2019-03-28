---
date: 2011-01-20 17:18:16+00:00
old_link: http://blog.nottoobadsoftware.com/user-interface/the-ultimate-word-processor/
slug: the-ultimate-word-processor
title: The ultimate word processor
wordpress_id: 328
categories:
- User-Interface
tags:
- Scrivener
- TextSmith
---


The ultimate writing software should let you:


	
  * go back to any previous version of any part of the text.

	
  * keep different versions of the same part of the text, and easily switch between them.

	
  * focus on content and structure.

	
  * write any type of text meant for humans.

	
  * export to any format imaginable.

	
  * collaborate with other people.

In May 2004, Adam C. Engst wrote about [WriteRight: The Writer’s Word Processor](http://db.tidbits.com/article/07670) where he laid out his idea of the perfect word processor. Over 6 1/2 years later there is still no such thing. [Scrivener](https://www.literatureandlatte.com/scrivener/overview) is a major leap forward but I feel it is still lacking in some areas, so here I have outlined my own ideas for the perfect writing software. Unfortunately all the good names are taken. The mediocre ones too. So I give you:

<!-- more -->

### TextSmith


TextSmith is a desktop application (with tablet versions geared towards proofreading and commenting). It focuses on the content and structure of the text, leaving formatting and layout for later (or preferably to other people). A TextSmith file is more like a project than a document, since it can contain as many separate pieces of text you want plus research, links, webpages, media files, PDFs, etc.


#### Fearless editing


Writing should be fun. And even when it isn’t, you should at least feel free to try whatever you want. Change that paragraph. Move that over here. Delete that. Write something, even if it most likely will be bad and soon discarded. The only way you will be able to do this without restraint is if you know you can always get back to how things were before you messed up.

This is why TextSmith lets you view the history of every paragraph, section or the entire text and restore it to a previous version. You can also make a snapshot and label the current version for future reference. And if you have made some changes you’re not quite sure about and want to get back to later, you can keep them as an alternative version of that part of the text.

So just like Time Machine on the Mac allows you to go back to previous versions of your files, TextSmith allows you to go back to any previous version of any part of your text.


### Focus


When writing it is best to focus only on the text itself, everything else is just distracting.

Which is why TextSmith will not let you do any formatting or layout in the editor. You can underline, strikethrough, embolden and italicise, but that’s it! No fiddling with points and centimetres and colours and what have you.

TextSmith will refuse to write two or more consecutive spaces, or leave single spaces at the beginning or end of a paragraph, since that is not something anyone is ever going to need. Nor can you add tabs or other special characters only used for layout. Not having to deal with all the invisible characters that somehow have snuck into the text is going to be a big relief.

You can view one section or even just one paragraph at a time, to keep you from nitpicking on what you just wrote and keep on writing. And you can view different versions of a section or paragraph side-by-side, to see which one works best.


#### Write once, read anywhere


Despite what Word, OpenOffice and Pages seem to think I am pretty sure the vast majority of text produced today will never end up on a piece of paper. But it does end up in many different formats in many different places, and there’s only one way a single piece of software can handle all that.

Namely by letting you add plugins for exporting, importing and syncing. They will allow you to export to and import from RTF, Word, OpenOffice, plain text, PDF, HTML, XML, laTex, ePub, Kindle or even Microsoft Works if anyone can be bothered to make a plugin for it. And you can send the text directly to a blog, CMS, wiki or to eBay, Craigslist, Amazon, your editor/publisher, etc. You get the point.

In order to use one editor to produce all these different types of documents there needs to be a very flexible way of organising and preparing the text so it can be properly formatted and exported later on. TextSmith lets you structure the text like in an outliner, and will then automatically detect headings and what level they are at. This leaves you with setting the type of the paragraphs (body, quote, info box, etc. plus any custom types). Words, paragraphs and sections can be tagged and annotated with any meta data you want.

Since TextSmith can be used to import and export just about any type of text, it will need to handle the following:

	
  * bulleted lists

	
  * numbered lists

	
  * footnotes *

	
  * endnotes *

	
  * images (with captions)

	
  * other media

	
  * tables

	
  * hyperlinks (both internal and external) *

	
  * bibliographies

	
  * automatic numbering and referencing (of headings, images, tables etc)

	
  * comments *


* _these are basically just selected parts of the text with added meta data_.


#### Collaboration


People who are lucky enough to have co-authors, editors or just know someone who’s willing to give feedback will probably want to get all that input without having to send a lot of e-mails with attachments back and forth.

If everyone involved uses TextSmith then they can all see everyone else’s changes as they are happening, right in the editor. No surprise there. Those who have not started using TextSmith yet can access the text on the TextSmith Document Server website, which has basic editing and commenting functionality. If Apache Wave (formerly Google Wave) takes off TextSmith will be compatible with it so people can contribute using their own Wave clients.

You can of course limit people to only commenting, but with full access to the history of your text you can safely allow other people to make changes and then easily dismiss their contributions or keep them as alternative versions.


#### Miscellaneous

	
  * Needless to say TextSmith will autosave your work for you. New projects will be saved in the designated draft folder until you can be bothered to move them where they belong.

	
  * The search function knows what a word, sentence, paragraph, section and heading is, and it will_ never_ ask if you want to continue searching from the beginning. You can save a search, making it similar to a smart playlist in iTunes.

	
  * You can add words to a project dictionary, meaning they will not be recognised in other projects or when spellchecking in other programs.

	
  * TextSmith is scriptable in AppleScript and Python.

	
  * You can set up a to do list which will not allow you to print or export until each item in it is checked. Some items can be automatically checked when completed, like making sure no adjacent paragraphs start with the same word.


### Other writing software


#### Word, Pages, OpenOffice Writer


These focus primarily on formatting and page layout. Word in particular is loaded with features, but finding and correctly using the ones you need isn’t always easy. And none of these are an option if you want to do some distraction free writing.


#### Scrivener


I love Scrivener, but let’s face it, it’s no TextSmith:

	
  * You can save snapshots, but they only contain the currently selected sections and not the entire project. If you forget to make a snapshot you’re left with the old linear undo.

	
  * A pretty good selection of export options, but no plug-ins. Exported RTF and Word documents do not include styles.

	
  * In general I don’t think it’s strict enough, though most people probably consider that a good thing. You can do all kinds of formatting and layout right in the editor.


### Now what?


I would love to see TextSmith developed, but that won’t be easy, fast or cheap. The editor will be a pretty complex bit of custom UI, and the backend datastore will have to handle very large amounts of text with lots of history, plus real-time collaboration. I think it should be possible to sell the basic application at a low price, and make money on the plug-ins.

### Update:


A more thorough introduction to this still-hypothetical application can be found [here](/textsmith).
