//
//  ContainerViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/10/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

final class ContainerViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        view.backgroundColor = .clear
    }
    
    @IBAction func homePage(_ sender: UIButton) {

        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func settingsButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "iFunds", message: "Coming soon.", preferredStyle: UIAlertControllerStyle.alert)
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
    
    @IBAction func aboutButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "iFunds", message: "Designed and created by Pavlo Novak.", preferredStyle: UIAlertControllerStyle.alert)
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
}
