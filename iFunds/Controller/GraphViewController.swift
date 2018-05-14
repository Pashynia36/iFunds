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
    
    var transactions: [Transaction] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        getTransactions()
        fillTransactions()
        graphView.setNeedsDisplay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        }
    }

    func getTransactions() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            transactions = try managedContext.fetch(Transaction.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    func fillTransactions() {
        
        for i in 0..<transactions.count {
            
            if transactions[i].isIncome {
                graphView.graphPoints.append(Int(transactions[i].amount))
            } else {
                graphView.graphPoints.append(Int(-transactions[i].amount))
            }
            graphView.graphPoints.remove(at: 0)
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
