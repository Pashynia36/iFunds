//
//  TransactionsTableViewCell.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit
import CoreData
import Photos

class TransactionsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageInTheCell: UIImageView!
    @IBOutlet weak var purposeInTheCell: UILabel!
    @IBOutlet weak var amountInTheCell: UILabel!
    
    func prepareCellFor(transaction: Transaction) {
        
        purposeInTheCell.text = transaction.purpose
        amountInTheCell.text = String(transaction.amount)
        if transaction.photo != "" {
            let asset = PHAsset.fetchAssets(withLocalIdentifiers: [transaction.photo!], options: nil)
            PHImageManager.default().requestImage(
                for: asset[0],
                targetSize: imageInTheCell.frame.size,
                contentMode: .aspectFill,
                options: nil) { (image, _) -> Void in
                    self.imageInTheCell.image = image
            }
        } else if transaction.isIncome {
            imageInTheCell.backgroundColor = UIColor.green
        } else {
            imageInTheCell.backgroundColor = UIColor.red
        }
        imageInTheCell.layer.cornerRadius = 25.0
    }
}
