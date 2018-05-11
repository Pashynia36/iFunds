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

class MoneyViewController: UIViewController {
    
    @IBOutlet weak var containerConstant: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    var transactions: [Transaction] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        getTransactions()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        } else {
            containerConstant.constant = 0
        }
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
            getTransactions()
        }
        tableView.reloadData()
    }
}
