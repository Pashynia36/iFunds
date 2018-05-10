//
//  MoneyViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController {
    
    @IBOutlet weak var containerConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        } else {
            containerConstant.constant = 0
        }
    }
}
