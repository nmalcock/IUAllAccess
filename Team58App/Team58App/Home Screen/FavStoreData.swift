//
//  FavStoreData.swift
//  favAttempt
//
//  Created by Becky Poplawski on 4/1/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//


import Foundation
import UIKit

class FavStoreData: NSObject {
    
    var fname: String?
    var lname: String?
    var image_path: String?

    
    
    override init()
    {
        
    }
    
    //construct with parameters
    
    init(fname: String, lname: String, image_path: String) {
        

        self.fname = fname
        self.lname = lname
        self.image_path = image_path
        
    }
    
    //prints a player of roster's info
    
    override var description: String {
        return "fname: \(String(describing: fname)), lname: \(String(describing: lname)), image_path: \(String(describing: image_path))"
    }
    
}
