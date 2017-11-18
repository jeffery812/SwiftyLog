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
        Logger.level = .info
        Logger.showThread = true
        //Logger.ouput = .deviceConsole
        Logger.i("viewDidLoad")
        Logger.d("This is debug log")
        Logger.w("This is warning log")
        Logger.e("This is error log")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        Logger.d("button tapped")
        DispatchQueue.global(qos: .background).async {
            Logger.w("running not in main thread")
        }
        
    }
}

