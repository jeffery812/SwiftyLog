//
//  ViewController.swift
//  Example
//
//  Created by Zhihui Tang on 2018-03-30.
//  Copyright © 2018 Zhihui Tang. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        logger.d("ViewController loaded")

    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        logger.i("buttton tapped")
        logger.w("this is a warning message")
        logger.e("ooops, something is wrong.")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

