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
        return ["Hello!My name is Wezze. I’m the app that will forever save others from thinking about You: 'He/She got dressed not in the weather ...'",
                "Now I need to know your geoposition for optimal composition of your looks for the next 3 days.Click Agree -> Allow.",
                "Now I offer you different types of clothes that can be in your wardrobe, just follow instructions and enjoy result : ) Good luck!"]
    }()
    
    public let images: [UIImage?] = {
        return [UIImage(named: "trysiki"),
                UIImage(named: "geo"),
                UIImage(named: "hand")]
    }()
}
