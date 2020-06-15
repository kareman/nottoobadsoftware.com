---
date: 2019-08-18
title: Parsing Unicode property data files
categories:
- TextPicker
- Patterns
tags:
- text parsing
- regex alternative
- Unicode property data file
---

When developing the [word boundary recogniser](https://github.com/kareman/Patterns/blob/master/Sources/Patterns/Atomic%20Patterns/Word.swift) for the [Patterns](https://github.com/kareman/Patterns) framework, I needed to access data in Unicode property data files from Swift. These files look something like this:

```text

# Total code points: 88

# ================================================

0780..07A5    ; Thaana # Lo  [38] THAANA LETTER HAA..THAANA LETTER WAAVU
07B1          ; Thaana # Lo       THAANA LETTER NAA

```

For all the Unicode property data files you could possibly want, see [here](https://www.unicode.org/Public/12.0.0/ucd/) and [here](https://www.unicode.org/Public/12.0.0/ucd/auxiliary/). 
{: .note }

where the hexadecimal numbers/ranges at the beginning of the line and the property name ("Thaana") are the interesting parts. So we need to find all hexadecimal numbers that are at the beginning of a line – optionally followed by ".." and another hexadecimal – followed by spaces, a semi-colon, a single space, the property name and another space.

<!-- more -->

## Programmatically

So we have some text, and we want to get a series of ranges and their corresponding property names. If a line has only a single number and not a range, we turn it into a single-element range. In the example above it would be `07B1...07B1`. We convert the hexadecimal numbers to `UInt32` because Unicode code points can be up to 21 bits long.


```swift
func unicodeProperty(fromDataFile text: String) -> [(range: ClosedRange<UInt32>, property: Substring)] {
```
We will be using the Patterns framework itself for the text processing. It serves the same purpose as regex'es, except it might actually be readable for people who haven't used it before. That's the general idea, anyway.

We begin by defining a hexadecimal number. Thankfully a pattern for hexadecimal digits is already provided by Patterns:

```swift
let hexNumber = Capture(name: "hexNumber", hexDigit.repeat(1...))
```

Here we repeat the hexadecimal digit one or more times to get a number. `Capture` means this is a part of the text we want to extract, and we can retrieve it later using the name "hexNumber".

```swift
let hexRange = Patterns("\(hexNumber)..\(hexNumber)") || hexNumber
```

`Patterns` matches a sequence of other patterns, and here we define it using string interpolation.  `Patterns("\(hexNumber)..\(hexNumber)")` is the same as `Patterns(hexNumber, Literal(".."), hexNumber)`. `||` provides a choice between 2 other patterns; if the pattern to its left fails, it tries the one to its right.

```swift
let rangeAndProperty: Patterns = "\n\(hexRange, Skip()); \(Capture(name: "property", Skip())) "
```

This puts it all together. We start at the beginning of a line, match the 1 or 2 numbers in `hexRange`, skip everything until "`; `", and then capture everything until the next space.


```swift
return rangeAndProperty.matches(in: text).map { match in
	let propertyName = text[match[one: "property"]!]
	let oneOrTwoNumbers = match[multiple: "hexNumber"].map { 
		UInt32(text[$0], radix: 16)! 
	}
	let range = oneOrTwoNumbers.first! ... oneOrTwoNumbers.last!
	return (range, propertyName)
}
```

`rangeAndProperty.matches(in: text)` returns a lazy sequence of matches, so it doesn't start the actual text processing until you start reading elements from it. Each `Match` instance contains a `fullRange` index range of the part of the text the entire pattern matched, and using subscripting we can get hold of the index ranges within `fullRange` matched by `Capture` patterns.

You can find all the code in the ["unicode_property"](https://github.com/kareman/Patterns/blob/952e46c6a236eea0dfa37dbbd59cc97aeb54ff54/Sources/unicode_properties/main.swift#L6) commandline application in the Patterns framework.


## Graphically 

If you just want to quickly copy out the information you can use my [TextPicker app](https://nottoobadsoftware.com/textpicker/). It lets you select parts of the text you are interested in, and tries to find other parts that are similar:

<div class="videoWrapper">
	<iframe width="560" height="315" src="https://www.youtube.com/embed/SxNgkRpIg_I" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

<div class="videoWrapper">
	<iframe width="560" height="315" src="https://www.youtube.com/embed/uy5qDVMMf5E" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

The application doesn't support marking 2 different types of information simultaneously (yet) so I had to copy the numbers and names separately.

