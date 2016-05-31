//
//  ViewController.swift
//  RWSBounceButton
//
//  Created by Ranjithkumar Matheswaran on 05/31/2016.
//  Copyright (c) 2016 Ranjithkumar Matheswaran. All rights reserved.
//

import UIKit
import RWSBounceButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = RWSBounceButton(frame: CGRectMake(40, 200, 140, 54),selectedString : "Request Sent", normalString : "Add Friend")
        self.view.addSubview(button)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

