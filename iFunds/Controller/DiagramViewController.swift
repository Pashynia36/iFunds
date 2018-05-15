//
//  DiagramViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

final class DiagramViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet private weak var containerConstant: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var transactions: [Transaction] = []
    private var incomeValues: [Float] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.register(BarCell.self, forCellWithReuseIdentifier: "barCell")
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.backgroundColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        collectionView.reloadData()
        let transactionService = TransactionService()
        transactions = transactionService.getTransactions()
        fillIncomes()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        }
    }
    
    func fillIncomes() {
        
        for i in 0..<transactions.count {
            if transactions[i].isIncome {
                incomeValues.append(transactions[i].amount)
            }
        }
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        } else {
            containerConstant.constant = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return incomeValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "barCell", for: indexPath) as? BarCell, let maximum = incomeValues.max() {
            
            let value = incomeValues[indexPath.row]
            let ratio = CGFloat(value / maximum)
            cell.barHeightConstraint?.constant = CGFloat(collectionView.frame.height * ratio - 50.0)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 20, height: collectionView.frame.height)
    }
}
