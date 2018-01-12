//
//  ViewController.swift
//  SwiftMagic
//
//  Created by Zhihui Tang on 10/14/2017.
//  Copyright (c) 2017 Zhihui Tang. All rights reserved.
//

import UIKit
import SwiftMagic

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let logger = Logger.shared
        logger.level = .info
        logger.showThread = false
        logger.ouput = .fileOnly
        
        logger.i("viewDidLoad: \(Date().iso8601)")
        logger.d("This is debug log")
        logger.w("This is warning log")
        logger.e("This is error log")
        logger.e("Hello SwiftMagic")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        Logger.shared.d("button tapped")
        DispatchQueue.global(qos: .background).async {
            Logger.shared.w("running not in main thread")
        }
    }
}

