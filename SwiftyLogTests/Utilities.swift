//
//  Utilities.swift
//  SwiftyLogTests
//
//  Created by Zhihui Tang on 2018-05-02.
//  Copyright © 2018 Zhihui Tang. All rights reserved.
//

import Foundation

func randomDelay(maxDuration: Double) {
    let randomWait = arc4random_uniform(UInt32(maxDuration * Double(USEC_PER_SEC)))
    usleep(randomWait)
}
