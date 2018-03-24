//
//  ViewController.swift
//  Example
//
//  Created by Zhihui Tang on 2018-03-23.
//  Copyright © 2018 Zhihui Tang. All rights reserved.
//

import UIKit
import SwiftMagic

let logger = Logger.shared
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        logger.level = .info
        logger.ouput = .debugerConsoleAndFile
        logger.d("Hello SwiftMagic")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        logger.i("Info: Button Tapped")
        logger.d("Debug: Button Tapped")
        logger.w("Warning message")
        logger.e("Error message")
    }
    
}


