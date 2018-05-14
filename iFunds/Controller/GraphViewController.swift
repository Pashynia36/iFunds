//
//  GraphViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    
    @IBOutlet weak var containerConstant: NSLayoutConstraint!
    
    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // TODO:- Implement transfer from CoreData to graphView.graphPoints(last 7 values)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        }
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        } else {
            containerConstant.constant = 0
        }
    }
}
