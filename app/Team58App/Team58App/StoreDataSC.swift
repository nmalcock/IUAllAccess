//
//  StoreDataSC.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class StoreDataSC: NSObject {
    
    var fname: String?
    var lname: String?
    var number: String?
    var position: String?
    var year: String?
    var image_path: String?
    
    
    override init()
    {
        
    }
    
    //construct with parameters
    
    init(fname: String, lname: String, name: String, number: String, position: String, year: String, image_path: String) {
        
        self.fname = fname
        self.lname = lname
        self.number = number
        self.position = position
        self.year = year
        self.image_path = image_path
        
    }
    
    //prints a player of roster's info
    
    override var description: String {
        return "Name: \(String(describing: fname)), Number: \(String(describing: number)), Position: \(String(describing: position)), Year: \(String(describing: year)), Image: \(String(describing: image_path))"
    }
    
}
