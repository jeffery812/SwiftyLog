# SwiftMagic

[![CI Status](http://img.shields.io/travis/zhihuitang/SwiftMagic.svg?style=flat)](https://travis-ci.org/zhihuitang/SwiftMagic)
[![Version](https://img.shields.io/cocoapods/v/SwiftMagic.svg?style=flat)](http://cocoapods.org/pods/SwiftMagic)
[![License](https://img.shields.io/cocoapods/l/SwiftMagic.svg?style=flat)](http://cocoapods.org/pods/SwiftMagic)
[![Platform](https://img.shields.io/cocoapods/p/SwiftMagic.svg?style=flat)](http://cocoapods.org/pods/SwiftMagic)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

SwiftMagic is a tool to record log in an elegant way. You also can send the log to the specified email address by shaking the device. Easy to use

## 1. Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 2. Requirements

Xcode: 9.0

iOS: 8.0

## 3. Installation

SwiftMagic is available through [CocoaPods](http://cocoapods.org) and Carthage. To install
it, simply add the following line to your Podfile:

Cocoapods:
```ruby
pod 'SwiftMagic'
# or
# pod 'SwiftMagic', :git => 'https://github.com/zhihuitang/SwiftMagic.git'
```

Or Carthage:

```ruby
github "https://github.com/zhihuitang/SwiftMagic" ~> 0.2
```

## 4. Usage

```swift
import SwiftMagic

let logger = Logger.shared

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
        // Disabled by default
        // Logger.shared.level = .none
        logger.level = .info
        logger.showThread = true
        logger.ouput = .debugerConsoleAndFile
        
        logger.d("Application started")
        // logger.i("information log")
        // logger.e("error log")
        // logger.d("debug log")
        // logger.w("warning log")

        return true
    }

}
```

output:
```
2018-01-13T21:20:46.149Z 💚d-<NSThread: 0x1c0261dc0>{number = 1, name = main}[AppDelegate.swift#application(_:didFinishLaunchingWithOptions:)#26]: Application started
```

### View logs by shaking device:

**Shake** your device to view the logs on your test iPhone. In that page, you also can click button **Send email** to send the log file to specified email inbox:

<img src="./res/logview.png" width="350">

## 5. Author

Zhihui Tang, crafttang@gmail.com

## 6. License

SwiftMagic is available under the MIT license. See the LICENSE file for more info.

