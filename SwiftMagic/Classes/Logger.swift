//
//  Logger.swift
//  SwiftMagic
//
//  Created by Zhihui Tang on 2017-10-14.
//


import Foundation


public enum LoggerLevel: Int {
    case info = 1
    case debug
    case warning
    case error
    case none
    
    var name: String {
        switch self {
        case .info: return "I"
        case .debug: return "D"
        case .warning: return "W"
        case .error: return "E"
        case .none: return "N"
        }
    }
}

public enum LoggerOutput: String {
    case debuggerConsole
    case deviceConsole
}

public class Logger: NSObject {
    public static var tag: String?
    public static var level: LoggerLevel = .info
    public static var ouput: LoggerOutput = .debuggerConsole
    public static var showThread: Bool = false
    
    private override init() {
        super.init()
    }
    
    class func log(_ level: LoggerLevel, message: String, currentTime: Date, fileName: String , functionName: String, lineNumber: Int, thread: Thread) {
        
        guard level.rawValue >= self.level.rawValue else { return }
        
        let _fileName = fileName.split(separator: "/")
        let text = "\(showThread ? thread.description : "")[\(_fileName.last ?? "?")#\(functionName)#\(lineNumber)]\(tag ?? "")-\(level.name): \(message)"
        if self.ouput == .deviceConsole {
            NSLog(text)
        } else {
            print("\(currentTime.iso8601) \(text)")
        }
    }
    
    public class func i(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.info, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
    public class func d(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.debug, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
    public class func w(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.warning, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
    public class func e(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.error, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
}


