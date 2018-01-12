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
        case .info: return "💙i"
        case .debug: return "💚d"
        case .warning: return "💛w"
        case .error: return "❤️e"
        case .none: return "N"
        }
    }
}

public enum LoggerOutput: String {
    case debuggerConsole
    case deviceConsole
    case file
    case debugerConsoleAndFile
    case deviceConsoleAndFile
}


private let fileExtension = "txt"

public class Logger: NSObject {
    public static let shared = Logger()
    public var tag: String?
    public var level: LoggerLevel = .info
    public var ouput: LoggerOutput = .debuggerConsole
    public var showThread: Bool = false
    private var data: [String] = []
    
    private let logSubdiretory = FileManager.documentDirectoryURL.appendingPathComponent(fileExtension)
    
    var logUrl: URL? {
        let fileName = "SwiftMagic"
        try? FileManager.default.createDirectory(at: logSubdiretory, withIntermediateDirectories: false)
        let url = logSubdiretory.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        return url
    }
    
    private override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
    }
    
    @objc private func appMovedToBackground() {
        let lock = NSLock()
        lock.lock()
        defer { lock.unlock() }
        save()
    }
    
    func save() {
        guard let url = logUrl else { return }
        var stringsData = Data()
        for string in data {
            if let stringData = (string + "\n").data(using: String.Encoding.utf8) {
                stringsData.append(stringData)
            } else {
                self.e("MutalbeData failed")
            }
        }
        
        do {
            try stringsData.append2File(fileURL: url)
            data.removeAll()
        } catch let error as NSError {
            self.e("wrote failed: \(url.absoluteString), \(error.localizedDescription)")
        }
    }
    
    func removeAll() {
        guard let url = logUrl else { return }
        try? FileManager.default.removeItem(at: url)
    }
    
    func load() -> String? {
        guard let url = logUrl else { return nil }
        guard let strings = try? String(contentsOf: url, encoding: String.Encoding.utf8) else { return nil }

        return strings
    }

    public func log(_ level: LoggerLevel, message: String, currentTime: Date, fileName: String , functionName: String, lineNumber: Int, thread: Thread) {
        
        guard level.rawValue >= self.level.rawValue else { return }
        
        
        let _fileName = fileName.split(separator: "/")
        let text = "\(level.name)-\(showThread ? thread.description : "")[\(_fileName.last ?? "?")#\(functionName)#\(lineNumber)]\(tag ?? ""): \(message)"
        if self.ouput == .deviceConsole {
            NSLog(text)
        } else {
            print("\(currentTime.iso8601) \(text)")
        }
        data.append("\(currentTime.iso8601) \(text)")
    }
    
    public func i(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.info, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
    public func d(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.debug, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
    public func w(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.warning, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
    public func e(_ message: String, currentTime: Date = Date(), fileName: String = #file, functionName: String = #function, lineNumber: Int = #line, thread: Thread = Thread.current ) {
        log(.error, message: message, currentTime: currentTime, fileName: fileName, functionName: functionName, lineNumber: lineNumber, thread: thread)
    }
}


