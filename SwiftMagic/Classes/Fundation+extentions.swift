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
}

public extension UInt32 {
    
    public var double: Double {
        return Double(self)
    }
    
}
