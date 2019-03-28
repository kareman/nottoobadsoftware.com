---
comments: true
date: 2016-02-03 00:23:55+00:00
old_link: http://blog.nottoobadsoftware.com/swift/splitting-text-read-piece-by-piece/
slug: splitting-text-read-piece-by-piece
title: Splitting text read piece by piece
wordpress_id: 1078
categories:
- Swift
tags:
- Swift
---

_Swift version 2.1._

In the [previous post](/blog/swift/splitting-text-and-collections-lazily-in-swift/) we implemented lazy splitting of collections, very useful for say splitting large texts into lines. But in SwiftShell I need the same functionality for text which is acquired piecemeal, like the output of a long-running shell command read sequentially, when needed. Because shell commands which are piped together in the terminal should get to work right away, and not just hang around waiting for the previous command to finish. Like this:

<video preload='none' controls>
    <source src='/media/old/partialsource-vs-readall-lazy-splitting-of-lines.m4v' type='video/mp4' />
</video>

Both scripts start at the same time. The left one uses the functionality implemented below, while the right one reads the entire input into a string first, and therefore has to wait for the ‘linemaker’ command to finish before doing any actual work.

<!-- more -->

## The problem

This functionality can be used to split any collection over any Equatable element, but it is easier to visualise it if we think of it as splitting text over the newline character:

![Image of lines of text with non-square boxes with slightly different background colours signifying the different segments/collections](/media/old/Skjermbilde-2016-02-02-kl.-22.01.38.png)

In how many pieces the text is read is completely arbitrary, it can take several of them just to complete a line or one piece can contain everything. All we know is we want the same results no matter how the text is divided.

I struggled with coming up with a nice and clean implementation for this. When each piece is split individually the results can be turned into a sequence of sequences, which sounds like a job for the built-in [flatten method](http://swiftdoc.org/v2.1/protocol/SequenceType/#func-generator-element_-sequencetype-flatten). The problem is, after splitting, the last part of one piece must be joined with the first part of the next, and I don't know of any generic concept for that.

The end result is a bit messy, but fairly simple. Though I'm not really satisfied with any code which feels like it needs comments to be comprehensible.

## The code
    
```swift
public struct PartialSourceLazySplitSequence <Base: CollectionType where 
    Base.Generator.Element: Equatable,
    Base.SubSequence: RangeReplaceableCollectionType,
    Base.SubSequence.Generator.Element==Base.Generator.Element,
    Base.SubSequence==Base.SubSequence.SubSequence>: GeneratorType, LazySequenceType {
```

First we repeat the monstrous generic ‘where’ clause from the previous post, except this time the subsequence must be a [RangeReplaceableCollectionType](http://swiftdoc.org/v2.1/protocol/RangeReplaceableCollectionType/) because we need to join subsequences together.

```swift
    private var gs: LazyMapGenerator<AnyGenerator<Base>, LazySplitSequence<Base>>
    private var g: LazySplitSequence<Base>?

    public init (bases: ()->Base?, separator: Base.Generator.Element) {
        gs = anyGenerator(bases).lazy.map {
            LazySplitSequence($0, separator: separator, allowEmptySlices: true).generate()
            }.generate()
    }
```

To keep this as generic and reusable as possible, input 'bases' is a function returning the next piece of the collection every time it is called, until it is empty and returns nil. `gs` is a generator of generators, lazily turning each input collection into a [LazySplitSequence](/blog/swift/splitting-text-and-collections-lazily-in-swift/). `g` is the LazySplitSequence we are currently working on.

```swift
    public mutating func next() -> Base.SubSequence? {
        // Requires g handling repeated calls to next() after it is empty.
        // When g.remaining becomes nil there is always one item left in g.
        guard let head = g?.next() else {
            self.g = self.gs.next()
            return self.g == nil ? nil : next()
        }
        if g?.remaining == nil, let next = next() {
            return head + next
        } else {
            return head
        }
    }
}
```

If `g` is empty, get the next LazySplitSequence from `gs`. If `gs` is empty then we are done, return nil.

If there is no remaining part of the current LazySplitSequence to split further, but there is more left in `gs`, then split off the first part of the next LazySplitSequence and join it with the current head, which is the last part of the current LazySplitSequence.

[Here](https://github.com/kareman/SwiftShell/blob/d6045d1485ed0f24094ba2da8da6aebe17edc63f/SwiftShell/General/Lazy-split.swift) is the complete code including LazySplitSequence, with [unit test](https://github.com/kareman/SwiftShell/blob/d6045d1485ed0f24094ba2da8da6aebe17edc63f/SwiftShellTests/General/Collection_Tests.swift#L79).
