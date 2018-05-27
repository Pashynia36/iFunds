//
//  TutorialViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/27/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

final class TutorialViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonView: UIButton!
    
    // MARK: - Variables
    private let content = TutorialContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        pageControl.numberOfPages = content.images.count
    }
    
    func setBackground() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.alpha = 1
        let gradient = CAGradientLayer()
        let colorOne = UIColor(red: 90.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorTwo = UIColor(red: 255.0 / 255.0, green: 207.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        let colorThree = UIColor(red: 255.0 / 255.0, green: 84.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0).cgColor
        gradient.colors = [colorThree, colorTwo, colorOne]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height * 2)
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TutorialViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

// MARK: - UICollectionViewDelegate
extension TutorialViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = currentPage
        
        if currentPage == 1 {
            buttonView.isHidden = true
        } else if currentPage == 2 {
            buttonView.isHidden = false
            buttonView.titleLabel?.text = "Got it!"
        } else {
            buttonView.isHidden = true
        }
    }
}

// MARK: - UICollectionViewDataSource
extension TutorialViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCell", for: indexPath) as! TutorialCell
        
        cell.initCell(image: content.images[indexPath.row]!,
                      title: content.titles[indexPath.row])
        
        return cell
    }
}
