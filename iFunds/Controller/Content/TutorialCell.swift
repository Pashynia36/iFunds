
//
//  TutorialCell.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/27/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

final class TutorialCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    
    // MARK: - Init cell
    public func initCell(image: UIImage, title: String) {
        imageView.image = image
        titleView.text = title
    }
    
}
