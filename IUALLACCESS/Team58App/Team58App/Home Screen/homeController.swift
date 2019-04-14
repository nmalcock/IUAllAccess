//
//  homeController.swift
//  Team58App
//
//  Created by Becky Poplawski on 4/9/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class homeController: UITabBarController {

var userID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userID != nil {
            print(userID)
        }
    }
    
    
}

