//
//  SwiftyLogTests.swift
//  SwiftyLogTests
//
//  Created by Zhihui Tang on 2018-03-30.
//  Copyright © 2018 Zhihui Tang. All rights reserved.
//

import XCTest
@testable import SwiftyLog

class SwiftyLogTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testConcurrentLogging() {
        let dispatchQueue = DispatchQueue(label: "com.crafttang.swiftyLog", attributes: .concurrent)
        let logger = Logger.shared
        logger.level = .info
        logger.ouput = .debugerConsoleAndFile
        //logger.showThread = true
        
        for i in 0...120 {
            randomDelay(maxDuration: 0.5)
            dispatchQueue.async {
                randomDelay(maxDuration: 0.5)
                logger.d("hello: \(i)")
            }
        }
        sleep(10)
        logger.d("test finished")
        logger.synchronize()
        
        // check manually if the SwiftyLog.txt has 120 records
        
        
    }
    
}
