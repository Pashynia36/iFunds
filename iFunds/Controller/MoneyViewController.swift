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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var detailedView: UIView!
    
    @IBOutlet weak var backgroundColor: UIScrollView!
    @IBOutlet private weak var containerConstant: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    
    private var transactions: [Transaction] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        let transactionService = TransactionService()
        transactions = transactionService.getTransactions()
        drawBackground()
        tableView.delegate = self
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
        
       detailedView.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.alpha = 1
    }
    
    func drawBackground() {
        
        backgroundColor.frame.size.width = view.frame.width
        backgroundColor.frame.size.height = view.frame.height * 2
        let values: (Float, Float) = getThemValues()
        backgroundColor.frame.origin.y = -100
        let gradient = CAGradientLayer()
        let colorOne = UIColor(red: 90.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorTwo = UIColor(red: 255.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorThree = UIColor(red: 255.0 / 255.0, green: 84.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        gradient.colors = [colorThree, colorTwo, colorOne]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height * 2)
        self.backgroundColor.layer.insertSublayer(gradient, at: 0)
    }
    
    func getThemValues() -> (Float, Float) {
        
        var max: Float = 0.0
        var summary: Float = 0.0
        for i in 0..<transactions.count {
            if transactions[i].isIncome {
                summary += transactions[i].amount
            } else {
                summary -= transactions[i].amount
            }
            if transactions[i].amount > max {
                max = transactions[i].amount
            }
        }
        return (max, summary)
    }
    
    func presentView(indexPath: Int) {
        
        purposeLabel.text = transactions[indexPath].purpose
        descriptionLabel.text = transactions[indexPath].descr
        amountLabel.text = String(transactions[indexPath].amount)
        if transactions[indexPath].photo != "" {
            let asset = PHAsset.fetchAssets(withLocalIdentifiers: [transactions[indexPath].photo!], options: nil)
            PHImageManager.default().requestImage(
                for: asset[0],
                targetSize: imageView.frame.size,
                contentMode: .aspectFill,
                options: nil) { (image, _) -> Void in
                    self.imageView.image = image
            }
        } else if transactions[indexPath].isIncome {
            imageView.image = nil
        } else {
            imageView.image = nil
        }
        if transactions[indexPath].isIncome {
            imageView.layer.borderColor = UIColor.green.cgColor
        } else {
            imageView.layer.borderColor = UIColor.red.cgColor
        }
        imageView.layer.cornerRadius = 50.0
        imageView.layer.borderWidth = 2.0
        detailedView.isHidden = false
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        
        if containerConstant.constant == 0 {
            containerConstant.constant -= 200
        } else {
            containerConstant.constant = 0
        }
        tableView.setNeedsDisplay()
    }
    
    @IBAction func closeDetail(_ sender: UIButton) {
        
        detailedView.isHidden = true
    }
}

extension MoneyViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        presentView(indexPath: indexPath.row)
    }
}
