//
//  TutorialModel.swift
//  iFunds
//
//  Created by Pavlo Novak on 5/27/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import Foundation
import UIKit

final class TutorialContent {
    public let titles: [String] = {
        return ["Let me introduce you the app that will help you save your money. This is iFunds.",
                "All the given information is in easy-read style with each cell clickable and deletable.",
                "Smart calculations will show you graph of your spents and incomes with charts."]
    }()
    
    public let images: [UIImage?] = {
        return [UIImage(named: "first"),
                UIImage(named: "second"),
                UIImage(named: "third")]
    }()
}
