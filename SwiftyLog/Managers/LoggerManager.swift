//
//  DataProvider.swift
//  SwiftMagic
//
//  Created by Zhihui Tang on 2018-01-09.
//

import Foundation
import MessageUI


extension UIWindow {
    open override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        guard Logger.shared.level != .none else { return }
        guard Logger.shared.ouput == .debugerConsoleAndFile
            || Logger.shared.ouput == .deviceConsoleAndFile
            || Logger.shared.ouput == .fileOnly else { return }
        
        Logger.shared.saveAsync()
        let manager = LoggerManager()
        manager.show()
    }
}

protocol LoggerAction {
    func removeAll()
}

class LoggerManager: NSObject {
    let controller = LoggerViewController()
    public func show() {
        guard let topViewController = UIApplication.topViewController() else { return }
        guard topViewController .isKind(of: LoggerViewController.self) == false else { return }
        
        controller.data = " \(loadLog())\(deviceInfo())"
        controller.delegate = self
        
        topViewController.present(controller, animated: true, completion: nil)
    }
    
    private func loadLog() -> String {
        var texts: [String] = []
        
        guard let data = Logger.shared.load() else { return "" }
        
        data.forEach { (string) in
            texts.append("<pre style=\"line-height:8px;\">\(string)</pre>")
        }
        
        return texts.joined()
    }
    
    private func deviceInfo() -> String {
        var texts:[String] = []
        
        texts.append("<pre style=\"line-height:8px;\">==============================================</pre>")
        DeviceManager.info().forEach { (string) in
            texts.append("<pre style=\"line-height:8px;\">\(string)</pre>")
        }
        return texts.joined()
    }
}

extension LoggerManager: LoggerAction {
    func removeAll() {
        Logger.shared.removeAllAsync()
        controller.data = deviceInfo()
    }
}
