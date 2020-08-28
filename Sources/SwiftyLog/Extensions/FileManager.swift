//
//  LoggerViewController.swift
//  SwiftyLog
//
//  Created by Zhihui Tang on 2018-01-10.
//


import UIKit

public extension FileManager {
  static var documentDirectoryURL: URL {
    return try! FileManager.default.url(
      for: .documentDirectory,
      in: .userDomainMask,
      appropriateFor: nil,
      create: false
    )
  }
}
