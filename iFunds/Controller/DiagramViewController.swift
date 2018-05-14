//
//  DiagramViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

class DiagramViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var containerConstant: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var transactions: [Transaction] = []
    var incomeValues: [Float] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getTransactions()
        collectionView.register(BarCell.self, forCellWithReuseIdentifier: "barCell")
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.backgroundColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        collectionView.reloadData()
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
        for i in 0..<transactions.count {
            if transactions[i].isIncome {
                incomeValues.append(transactions[i].amount)
            }
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
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        } else {
            containerConstant.constant = 0
        }
    }
}
