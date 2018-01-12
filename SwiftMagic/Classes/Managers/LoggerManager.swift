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
        Logger.shared.save()
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
        
        let deviceInfo = DeviceManager.info().joined(separator: "\n")
        controller.data = " \(Logger.shared.load() ?? "")=====>\n\(deviceInfo)\n<====="
        controller.delegate = self
        
        topViewController.present(controller, animated: true, completion: nil)
    }
}

extension LoggerManager: LoggerAction {
    func removeAll() {
        Logger.shared.removeAll()
        controller.data = Logger.shared.load()
    }
}
