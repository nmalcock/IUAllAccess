//
//  StoreDataBS.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class StoreDataBS: NSObject {
    
    var fname: String?
    var lname: String?
    var number: String?
    var position: String?
    var year: String?
    var image_path: String?
    var teamID: String?
    var athleteID: String?
    var height: String?
    var weight: String?
    var hometown: String?
    var highschool: String?
    
    
    
    override init()
    {
        
    }
    
    //construct with parameters
    
    init(fname: String, lname: String, name: String, number: String, position: String, year: String, image_path: String, teamID: String,  athleteID: String, height: String, weight: String, hometown: String, highschool: String) {
        
        self.fname = fname
        self.lname = lname
        self.number = number
        self.position = position
        self.year = year
        self.image_path = image_path
        self.teamID = teamID
        self.athleteID = athleteID
        self.height = height
        self.weight = weight
        self.hometown = hometown
        self.highschool = highschool
        
    }
    
    //prints a player of roster's info
    
    override var description: String {
        return "Name: \(String(describing: fname)), Number: \(String(describing: number)), Position: \(String(describing: position)), Year: \(String(describing: year)), Image: \(String(describing: image_path))"
    }
    
}
