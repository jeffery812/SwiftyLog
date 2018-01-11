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

class LoggerManager: NSObject {
    let controller = LoggerViewController()
    public func show() {
        guard let topViewController = UIApplication.topViewController() else { return }
        guard topViewController .isKind(of: LoggerViewController.self) == false else { return }
        topViewController.present(controller, animated: true, completion: nil)
    }
}
