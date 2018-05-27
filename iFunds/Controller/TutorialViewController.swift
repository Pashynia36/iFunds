//
//  TutorialViewController.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/27/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit
import CoreLocation

final class TutorialViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonView: UIButton!
    
    // MARK: - Variables
    private let content = TutorialContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = content.images.count
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
