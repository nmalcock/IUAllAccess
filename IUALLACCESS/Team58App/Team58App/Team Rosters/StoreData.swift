//
//  StoreData.swift
//  Team58App
//
//  Created by Michael Jacobucci on 2/13/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

//*********************************************************
//LOCATION MODEL = ROSTER STORE DATA
//WAS STOCK MODEL
//*********************************************************

import UIKit

class StoreData: NSObject {
   
    var fname: String?
    var lname: String?
    var number: String?
    var position: String?
    var year: String?
    var image_path: String?
    var teamID: String?
    var height: String?
    var weight: String?
    var hometown: String?
    var highschool: String?
    var athleteID: String?
    

    
    override init()
    {
        
    }
    
    //construct with parameters
    
    init(fname: String, lname: String, name: String, number: String, position: String, year: String, image_path: String, teamID: String, height: String, weight: String, hometown: String, highschool: String, athleteID: String) {
        
        self.fname = fname
        self.lname = lname
        self.number = number
        self.position = position
        self.year = year
        self.image_path = image_path
        self.teamID = teamID
        self.height = height
        self.weight = weight
        self.hometown = hometown
        self.highschool = highschool
        self.athleteID = athleteID
        
    }
    
    //prints a player of roster's info
    
    override var description: String {
        return "Name: \(String(describing: fname)), Number: \(String(describing: number)), Position: \(String(describing: position)), Year: \(String(describing: year)), Image: \(String(describing: image_path))"
    }
    
 }
