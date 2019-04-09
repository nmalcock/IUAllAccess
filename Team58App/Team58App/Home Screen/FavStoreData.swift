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
    
    var userID: String?
    var fname: String?
    var lname: String?
    var image_path: String?
    var athleteID: String?
    var height: String?
    var weight: String?
    var hometown: String?
    var number: String?
    var position: String?
    var year: String?
    var highschool: String?
    var teamID: String?
    //var teamID: String?

    

    
    
    override init()
    {
        
    }
    
    //construct with parameters
    //FBathleteID: String, SCathleteID: String, BSathleteID: String,
    
    init(fname: String, lname: String, image_path: String, athleteID: String, height: String, weight: String, hometown: String, number: String, position: String, year: String, highschool: String, teamID: String) {
        

        self.fname = fname
        self.lname = lname
        self.athleteID = athleteID
        self.height = height
        self.weight = weight
        self.hometown = hometown
        self.number = number
        self.position = position
        self.year = year
        self.highschool = highschool
        self.teamID = teamID
        self.image_path = image_path
        //self.teamID = teamID

        
    }
    
    //prints a player of roster's info
    
    override var description: String {
        return "fname: \(String(describing: fname)), lname: \(String(describing: lname)), image_path: \(String(describing: image_path))"
    }
    
}
