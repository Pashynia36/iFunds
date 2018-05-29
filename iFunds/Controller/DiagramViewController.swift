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
    private var incomePurposes: [String] = []
    private let cellId = "barCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setBackground()
        collectionView.register(BarCell.self, forCellWithReuseIdentifier: cellId)
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        let transactionService = TransactionService()
        transactions = transactionService.getTransactions()
        fillIncomes()
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        }
    }
    
    func setBackground() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.alpha = 1
        self.navigationController?.navigationBar.topItem?.title = "Income Diagram"
        let gradient = CAGradientLayer()
        let colorOne = UIColor(red: 90.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorTwo = UIColor(red: 255.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorThree = UIColor(red: 255.0 / 255.0, green: 84.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        gradient.colors = [colorThree, colorTwo, colorOne]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height * 2)
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func fillIncomes() {
        
        incomeValues = []
        for i in 0..<transactions.count {
            if transactions[i].isIncome {
                incomeValues.append(transactions[i].amount)
                incomePurposes.append(transactions[i].purpose!)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return incomeValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? BarCell, let maximum = incomeValues.max() {
            
            let value = incomeValues[indexPath.row]
            let ratio = CGFloat(value / maximum)
            cell.barHeightConstraint?.constant = CGFloat(collectionView.frame.height * ratio)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "\(incomePurposes[indexPath.row])", message: "\(incomeValues[indexPath.row])", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                break
            case .cancel:
                break
            case .destructive:
                break
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 20, height: collectionView.frame.height)
    }
}
