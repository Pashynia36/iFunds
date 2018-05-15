//
//  ProfileViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/11/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {

    @IBOutlet weak var totalSpent: UILabel!
    @IBOutlet weak var totalEarned: UILabel!
    @IBOutlet weak var clearProfit: UILabel!
    
    private var transactions: [Transaction] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        getTransactions()
        calculate()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    func calculate() {
        
        var income: Float = 0.0
        var outcome: Float = 0.0
        for i in 0..<transactions.count {
            if transactions[i].isIncome {
                income += transactions[i].amount
            } else {
                outcome -= transactions[i].amount
            }
        }
        totalSpent.text = "Total spent: " + String(outcome)
        totalEarned.text = "Total earned: " + String(income)
        clearProfit.text = "Clear profit: " + String(income + outcome)
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
}
