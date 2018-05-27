//
//  LoadingViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {

    @IBOutlet private weak var iFundsLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var saveLabel: UILabel!
    @IBOutlet private weak var predictLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setBackground()
        self.iFundsLabel.center.y += self.view.bounds.height
        self.countLabel.alpha = 0.0
        self.saveLabel.alpha = 0.0
        self.predictLabel.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.1, options: [.curveEaseOut], animations: {
            self.iFundsLabel.center.y -= self.view.bounds.height
        })
        UIView.animate(withDuration: 1.5, animations: {
            self.countLabel.alpha = 1.0
            self.saveLabel.alpha = 1.0
            self.predictLabel.alpha = 1.0
        }, completion: { (finished) in
            if finished {
                self.performSegue(withIdentifier: "homeLoad", sender: self)
            }
        })
    }
    
    func setBackground() {
        
        let gradient = CAGradientLayer()
        let colorOne = UIColor(red: 90.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorTwo = UIColor(red: 255.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorThree = UIColor(red: 255.0 / 255.0, green: 84.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        gradient.colors = [colorThree, colorTwo, colorOne]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height * 2)
        view.layer.insertSublayer(gradient, at: 0)
    }
}
