# SwiftMagic

[![CI Status](http://img.shields.io/travis/zhihuitang/SwiftMagic.svg?style=flat)](https://travis-ci.org/zhihuitang/SwiftMagic)
[![Version](https://img.shields.io/cocoapods/v/SwiftMagic.svg?style=flat)](http://cocoapods.org/pods/SwiftMagic)
[![License](https://img.shields.io/cocoapods/l/SwiftMagic.svg?style=flat)](http://cocoapods.org/pods/SwiftMagic)
[![Platform](https://img.shields.io/cocoapods/p/SwiftMagic.svg?style=flat)](http://cocoapods.org/pods/SwiftMagic)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SwiftMagic is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftMagic'
# or
# pod 'SwiftMagic', :git => 'https://github.com/zhihuitang/SwiftMagic.git'
```

## Usage

```swift
import SwiftMagic

...

Logger.level = .info
Logger.showThread = true
Logger.ouput = .deviceConsole
Logger.i("viewDidLoad")
```

output:
```
2017-10-14 11:38:34.836740+0200 SwiftMagic_Example[2060:1788178] [ViewController.swift#viewDidLoad()#19]-I: viewDidLoad
```

## Author

Zhihui Tang, crafttang@gmail.com

## License

SwiftMagic is available under the MIT license. See the LICENSE file for more info.


