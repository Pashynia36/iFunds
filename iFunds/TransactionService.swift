//
//  TransactionService.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/15/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import Foundation

class TransactionService {
    
    public var transactions: [Transaction] = []
    
    func getTransactions() -> [Transaction] {
        
        let managedContext = AppDelegate.viewContext
        do {
            transactions = try managedContext.fetch(Transaction.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        return transactions
    }
}
