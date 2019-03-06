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
    //var name: String?
    var number: String?
    var position: String?
    var year: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with parameters
    
    init(fname: String, lname: String, name: String, number: String, position: String, year: String) {
        
        self.fname = fname
        self.lname = lname
        //self.name = "\(fname)\(lname)"
        self.number = number
        self.position = position
        self.year = year
        
    }
    
    //prints a player of roster's info
    
    override var description: String {
        return "Name: \(String(describing: fname)), Number: \(String(describing: number)), Position: \(String(describing: position)), Year: \(String(describing: year))"
    //return "Name: \(String(describing: fname))"
    }
    
 
 }
