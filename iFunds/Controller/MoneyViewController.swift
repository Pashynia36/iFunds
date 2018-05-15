//
//  MoneyViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit
import Photos
import CoreData

final class MoneyViewController: UIViewController {
    
    @IBOutlet private weak var containerConstant: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    
    private var transactions: [Transaction] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        let transactionService = TransactionService()
        transactions = transactionService.getTransactions()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
            tableView.alpha = 1.0
        } else {
            containerConstant.constant = 0
            tableView.alpha = 0.5
        }
        tableView.setNeedsDisplay()
    }
}

extension MoneyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransactionsTableViewCell else { return UITableViewCell() }
        cell.prepareCellFor(transaction: transactions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let transaction = transactions[indexPath.row]
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(transaction)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            let transactionService = TransactionService()
            transactions = transactionService.getTransactions()
        }
        tableView.reloadData()
    }
}
