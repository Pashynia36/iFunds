//
//  BarCell.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/14/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

import UIKit

final class BarCell: UICollectionViewCell {
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3.0
        return view
    }()
    
    var barHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(barView)
        
        barHeightConstraint = barView.heightAnchor.constraint(equalToConstant: 300)
        barHeightConstraint?.isActive = true
        
        barView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        barView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        barView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder wasn't implemented.")
    }
}
