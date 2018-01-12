//
//  DeviceManager.swift
//  SwiftMagic
//
//  Created by Zhihui Tang on 2018-01-12.
//

import Foundation

class DeviceManager: NSObject {
    class func info() -> [String] {
        var data: [String] = []
        
        data.append("Device Name: \(deviceNameAlias())")
        if let bundleId = Bundle.main.bundleIdentifier {
            data.append("Bundle Identifier: \(bundleId)")
        }
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            data.append( "Host App Version: \(version).\(buildNumber)" )
        }
        
        if let venderId = UIDevice.current.identifierForVendor {
            data.append( "Identifier For Vendor: \(venderId)" )
        }
        
        data.append("System Version: \(getSystemVersion())")
        data.append("Model: \(platformModelString())")
        
        data.append("Total Disk Space(MB): \(UIDevice.current.totalDiskSpaceInMB)")
        data.append("Free Disk Space(MB): \(UIDevice.current.freeDiskSpaceInMB)")
        
        let lastRestarted = Date(timeIntervalSince1970: TimeInterval(Date().secondsSince1970 - uptime()))
        data.append("Uptime: \(uptime())/\(lastRestarted)")

        return data
    }
    
    class var isIpad:Bool {
        if #available(iOS 8.0, *) {
            return UIScreen.main.traitCollection.userInterfaceIdiom == .pad
        } else {
            return UIDevice.current.userInterfaceIdiom == .pad
        }
    }
    class var isIphone:Bool {
        if #available(iOS 8.0, *) {
            return UIScreen.main.traitCollection.userInterfaceIdiom == .phone
        } else {
            return UIDevice.current.userInterfaceIdiom == .phone
        }
    }
    
    ///Name of the devices, like Baudins's Iphone
    class func deviceNameAlias() -> String {
        return  UIDevice.current.name
    }
    
    class func processorCount() -> Int {
        return ProcessInfo.processInfo.activeProcessorCount
    }
    
    //Verion of the OS, like 9.0.1
    class func osVersion()-> String {
        return UIDevice.current.systemVersion;
    }
    
    class func platformModelString() -> String {
        if let key = "hw.machine".cString(using: String.Encoding.utf8) {
            var size: Int = 0
            sysctlbyname(key, nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname(key, &machine, &size, nil, 0)
            return String(cString: machine)
        }
        return "Unknown"
    }

    /** uptime in seconds **/
    class func uptime()  -> Int {
        var currentTime = time_t()
        var bootTime    = timeval()
        var mib         = [CTL_KERN, KERN_BOOTTIME]
        
        var size = MemoryLayout<timeval>.stride
        
        if sysctl(&mib, u_int(mib.count), &bootTime, &size, nil, 0) != -1 && bootTime.tv_sec != 0 {
            time(&currentTime)
            
            if (currentTime < bootTime.tv_sec) {
                return 0
            }
            
            return  currentTime - bootTime.tv_sec
        }
        return 0
    }
    
    class func getScreenBrightness() -> CGFloat {
        return UIScreen.main.brightness
    }
    
    class func getPhysicalMemory() -> UInt64 {
        return ProcessInfo.processInfo.physicalMemory
    }
    
    class func getSystemVersion() -> String {
        return UIDevice.current.systemVersion
    }
}
