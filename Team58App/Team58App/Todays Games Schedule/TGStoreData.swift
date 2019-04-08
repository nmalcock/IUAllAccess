//
//  TGStoreData.swift
//  Team58App
//
//  Created by Michael Jacobucci on 4/7/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class StoreDataTG: NSObject {
    
    //properties
    
    var opponent: String?
    var Baseball: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    init( opponent: String, /* date_time: String, site: String, w_L: String, home_score: String, away_score: String, */ Baseball: String)
    {
        
        
        self.opponent = opponent
        self.Baseball = Baseball
        
        
    }
    
    
    override var description: String {
        
        
        return "Opponent: \(String(describing: opponent)), Baseball: \(String(describing: Baseball))"
    }
    
}
