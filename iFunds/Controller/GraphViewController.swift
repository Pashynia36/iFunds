//
//  GraphViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

final class GraphViewController: UIViewController {
    
    @IBOutlet weak var graphMaxLabel: UILabel!
    @IBOutlet private weak var containerConstant: NSLayoutConstraint!
    
    @IBOutlet private weak var graphView: GraphView!
    
    private var transactions: [Transaction] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setBackground()
        let transactionService = TransactionService()
        transactions = transactionService.getTransactions()
        fillTransactions()
        graphView.setNeedsDisplay()
        let max = maximum()
        graphMaxLabel.text = "Max: \(max)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        }
    }
    
    func maximum() -> String {
        
        var max: Float = 0
        for i in 0..<transactions.count {
            if transactions[i].amount > max {
                max = transactions[i].amount
            }
        }
        return String(max)
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
    
    func fillTransactions() {
        
        if transactions[0].isIncome {
            graphView.graphPoints[0] = Int(transactions[0].amount)
        } else {
            graphView.graphPoints[0] = Int(-transactions[0].amount)
        }
        for i in 1..<transactions.count {
            if transactions[i].isIncome {
                graphView.graphPoints[i] = graphView.graphPoints[i-1] + Int(transactions[i].amount)
            } else {
                graphView.graphPoints[i] = graphView.graphPoints[i-1] - Int(transactions[i].amount)
            }
        }
    }
}
