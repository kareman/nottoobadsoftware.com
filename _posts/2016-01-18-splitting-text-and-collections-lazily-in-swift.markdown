---
comments: true
date: 2016-01-18 22:56:53+00:00
old_link: http://blog.nottoobadsoftware.com/swift/splitting-text-and-collections-lazily-in-swift/
slug: splitting-text-and-collections-lazily-in-swift
title: Splitting text and collections lazily in Swift
wordpress_id: 1071
categories:
- Swift
tags:
- Swift
---

_Swift version 2.1_

There are already methods for [splitting collections](http://swiftdoc.org/v2.1/protocol/CollectionType/#comment-func-generator-element_-equatable-split_maxsplit_allowemptyslices_) in the Swift Standard Library, but they do all the work immediately and return the results in an array. When dealing with large strings, or streams of text, I find it better to do the work [lazily](http://swiftdoc.org/v2.1/protocol/LazySequenceType/), when needed. The overall performance is not necessarily better, but it is smoother, as you get the first results immediately instead of having to wait a little while and then get everything at once. And memory usage is lower, no need to store everything in an array first.

<!-- more -->

## The original

This is how the CollectionType.split method in the Standard Library splits strings over ",":

    
```swift
func testCollectionTypeSplit_AllowingEmptySlices () {
    let split = {(s: String) -> [String] in
        s.characters.split(",", allowEmptySlices: true).map {String($0)}
    }

    XCTAssertEqual(split("ab,c,de,f"), ["ab","c","de","f"])
    XCTAssertEqual(split(",a"),        ["","a"])
    XCTAssertEqual(split("a,"),        ["a",""])
    XCTAssertEqual(split("a,,b,,,c"),  ["a","","b","","","c"])
    XCTAssertEqual(split(""),          [""])
    XCTAssertEqual(split(","),         ["",""])
    XCTAssertEqual(split("ab"),        ["ab"])
}

func testCollectionTypeSplit_NoEmptySlices () {
    let split = {(s: String) -> [String] in
        s.characters.split(",", allowEmptySlices: false).map {String($0)}
    }

    XCTAssertEqual(split("ab,c,de,f"), ["ab","c","de","f"])
    XCTAssertEqual(split(",a"),        ["a"])
    XCTAssertEqual(split("a,"),        ["a"])
    XCTAssertEqual(split("a,,b,,,c"),  ["a","b","c"])
    XCTAssertEqual(split(""),          [])
    XCTAssertEqual(split(","),         [])
    XCTAssertEqual(split("ab"),        ["ab"])
}
```

I want our split method to behave in exactly the same way.

The results when allowing empty slices may seem a bit strange, but think of it as text split on the newline character into separate lines, and consider there may be several empty lines in a row plus they may be at the beginning and/or the end.

## The first step

So what is the simplest operation needed here, and will it be useful on its own? When splitting collections into smaller pieces the smallest possible operation is to split the collection once into 2 pieces. And yes I believe that operation will be useful on its own:


```swift
extension CollectionType where Generator.Element: Equatable {

    /**
    Return everything before the first occurrence of ‘separator’ as 'head', and everything after it as 'tail'.

    If ‘separator’ is first, ‘head’ is empty. If it is last, ‘tail’ is empty.
    If ‘separator’ is not found then ‘head’ contains everything and 'tail' is nil.
    */
    public func splitOnce (separator: Generator.Element) -> (head: SubSequence, tail: SubSequence?) {
        guard let nextindex = indexOf(separator) else { return (self[startIndex..<endIndex], nil) }
        return (self[startIndex..<nextindex], self[nextindex.successor()..<endIndex])
    }
}
```

Pretty straightforward, just find the first separator and return everything before it and everything after it.

## The output

This functionality naturally belongs in LazyCollectionType. We will be following [Apple's guidelines for extending it](http://swiftdoc.org/v2.1/protocol/LazySequenceType/) (they are the same as for LazySequenceType), except we will use the same struct for the sequence and generator because I don't want to write this monster of a generic `where` clause more often than strictly necessary:


```swift
public struct LazySplitSequence <Base: CollectionType where Base.Generator.Element: Equatable,
    Base.SubSequence: CollectionType,
    Base.SubSequence.Generator.Element==Base.Generator.Element,
    Base.SubSequence==Base.SubSequence.SubSequence>: GeneratorType, LazySequenceType {
```

This defines restrictions on the source collection's subsequences which you would think must be valid for all subsequences. All sequences, and therefore collections, [should satisfy them](https://github.com/apple/swift-evolution/blob/master/proposals/0014-constrained-AnySequence.md), so I don't think we are excluding anything here. These restrictions are in any case necessary for the following code, which deals entirely in subsequences and their subsequences:


```swift
    private var remaining: Base.SubSequence?
    private let separator: Base.Generator.Element
    private let allowEmptySlices: Bool

    public init (_ base: Base, separator: Base.Generator.Element, allowEmptySlices: Bool = false) {
        self.separator = separator
        self.remaining = base[base.startIndex..<base.endIndex]
        self.allowEmptySlices = allowEmptySlices
    }

    public mutating func next () -> Base.SubSequence? {
        guard let remaining = self.remaining else { return nil }
        let (head, tail) = remaining.splitOnce(separator)
        self.remaining = tail
        return (!allowEmptySlices && head.isEmpty) ? next() : head
    }
}

```

In the initialiser we set `remaining` to a subsequence of the entire collection. Then for every iteration we return everything before the next occurrence of `separator`, set everything after it to `remaining` and optionally skip empty results.

You may have noticed this sequence does not have a ‘generate’ method even though it is a required part of the protocol. That is because of this [clever little extension](https://github.com/apple/swift/blob/31f17e212ce3bea62a9525454f7f5ed35d7c4a03/stdlib/public/core/Sequence.swift#L204-L211) in the standard library, which automatically generates one for us.

## The actual method

Then all that remains is the method itself, where we meet the monstrous generic `where` clause again:


```swift
extension LazyCollectionType where Elements.Generator.Element: Equatable, 
    Elements.SubSequence: CollectionType,
    Elements.SubSequence.Generator.Element==Elements.Generator.Element,
    Elements.SubSequence==Elements.SubSequence.SubSequence {

    public func split (separator: Elements.Generator.Element, allowEmptySlices: Bool = false) -> LazySplitSequence<Elements> {
        return LazySplitSequence(self.elements, separator: separator, allowEmptySlices: allowEmptySlices)
    }
}
```

It can be called like this:


```swift
for line in largetext.characters.lazy.split("\n") {
    print(line)
}
// or
let r = largetext.characters.lazy.split("\n").map { /* do something else with it */ }\
```

The complete code can be found [in the SwiftShell project](https://github.com/kareman/SwiftShell/blob/5ac1b5f6909531444d5798a5f6a3fb937e6577fa/SwiftShell/General/Lazy-split.swift#L8-L51), with [unit tests](https://github.com/kareman/SwiftShell/blob/5ac1b5f6909531444d5798a5f6a3fb937e6577fa/SwiftShellTests/General/Collection_Tests.swift).
