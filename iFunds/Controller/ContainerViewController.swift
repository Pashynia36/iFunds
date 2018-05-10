//
//  ContainerViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func homePage(_ sender: UIButton) {
        
        tabBarController?.selectedIndex = 0
    }
}
