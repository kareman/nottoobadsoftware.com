---
author: kare.morstol@mac.com
comments: true
date: 2015-05-24 18:57:55+00:00
layout: post
link: http://blog.nottoobadsoftware.com/uncategorized/swift-associated-types/
slug: swift-associated-types
title: 'Swift: Associated Types'
wordpress_id: 814
post_format:
- Link
tags:
- Swift
---

[Russ Bishop](http://www.russbishop.net/swift-associated-types) has a clarifying post about Swift protocols and generics:



<blockquote>
Type parameters force everyone to know the types involved and specify them repeatedly (when you compose with them it can also lead to an explosion in the number of type parameters). They're part of the public interface. The code that uses the concrete thing (class/struct/enum) makes the decision about what types to select.

By contrast an associated type is part of the implementation detail. It's hidden, just like a class can hide its internal ivars. The abstract type member is for the concrete thing (class/struct/enum) to provide later. You select the actual type when you adopt the protocol, not when you instantiate the class/struct. It leaves control over which types to select in a different set of hands.
</blockquote>



But I do think he is too harsh on the functional programming hipster kids.
