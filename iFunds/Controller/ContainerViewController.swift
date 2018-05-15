//
//  ContainerViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

final class ContainerViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    @IBAction func homePage(_ sender: UIButton) {

        tabBarController?.selectedIndex = 0
    }
}
