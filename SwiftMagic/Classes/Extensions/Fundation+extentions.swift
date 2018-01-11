//
//  Fundation+extentions.swift
//  Pods
//
//  Created by Zhihui Tang on 2017-10-30.
//

import Foundation

public extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    var secondsSince1970:Int {
        return Int((self.timeIntervalSince1970).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    func getCurrentTimeString(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let nowDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = Foundation.TimeZone(identifier: "UTC")
        //formatter.dateStyle = .MediumStyle
        //formatter.timeStyle = .MediumStyle
        return formatter.string(from: nowDate)
    }
    
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}


public extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

public extension String {
    var dateFromISO8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
    
    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }
    
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append2File(fileURL: fileURL)
    }
}

extension Data {
    func append2File(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}

public extension UInt32 {
    
    public var double: Double {
        return Double(self)
    }
    
}

public extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
