# SwiftMagic

[![CI Status](http://img.shields.io/travis/zhihuitang/SwiftMagic.svg?style=flat)](https://travis-ci.org/zhihuitang/SwiftMagic)
[![Version](https://img.shields.io/cocoapods/v/SwiftMagic.svg?style=flat)](http://cocoapods.org/pods/SwiftMagic)
[![License](https://img.shields.io/cocoapods/l/SwiftMagic.svg?style=flat)](http://cocoapods.org/pods/SwiftMagic)
[![Platform](https://img.shields.io/cocoapods/p/SwiftMagic.svg?style=flat)](http://cocoapods.org/pods/SwiftMagic)

## 1. Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 2. Requirements

## 3. Installation

SwiftMagic is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftMagic'
# or
# pod 'SwiftMagic', :git => 'https://github.com/zhihuitang/SwiftMagic.git'
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
        
        logger.d("Application stated")
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
2018-01-13T21:20:46.149Z 💚d-<NSThread: 0x1c0261dc0>{number = 1, name = main}[AppDelegate.swift#application(_:didFinishLaunchingWithOptions:)#26]: Application stated
```

### View logs by shaking device:

**Shake** your device to view the logs on your test iPhone. In that page, you also can click button **Send email** to send the log file to specified email inbox:

<img src="./res/logview.png" width="350">

## 5. Author

Zhihui Tang, crafttang@gmail.com

## 6. License

SwiftMagic is available under the MIT license. See the LICENSE file for more info.


