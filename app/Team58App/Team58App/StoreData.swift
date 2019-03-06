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
    var name: String?
    var number: Int?
    var position: String?
    var year: Int?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with parameters
    
    init(fname: String, lname: String, name: String, number: Int, position: String, year: Int) {
        
        self.fname = fname
        self.lname = lname
        //self.name = "\(fname)\(lname)"
        self.number = number
        self.position = position
        self.year = year
        
    }
    
    //prints a player of roster's info
    
    override var description: String {
      //  return "Name: \(fname), Number: \(number), Position: \(position), Year: \(year)"
        return "Name: \(String(describing: fname))"
    }
    
 
 }
