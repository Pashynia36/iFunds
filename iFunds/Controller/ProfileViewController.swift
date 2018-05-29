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
        let transactionService = TransactionService()
        transactions = transactionService.getTransactions()
        calculate()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setBackground()
    }
    
    func setBackground() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.alpha = 1
        let gradient = CAGradientLayer()
        let colorOne = UIColor(red: 90.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorTwo = UIColor(red: 255.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorThree = UIColor(red: 255.0 / 255.0, green: 84.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        gradient.colors = [colorThree, colorTwo, colorOne]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height * 2)
        view.layer.insertSublayer(gradient, at: 0)
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
        totalSpent.text = "Total spent: " + String(outcome) + "₴"
        totalEarned.text = "Total earned: " + String(income) + "₴"
        clearProfit.text = "Clear profit: " + String(income + outcome) + "₴"
    }
}
