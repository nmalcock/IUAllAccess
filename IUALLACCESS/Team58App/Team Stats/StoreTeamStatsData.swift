//
//  StoreTeamStatsData.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/18/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit

class StoreTeamStatsData: NSObject {
    
  
    var stat_type: String?
    var stat_number: String?
    
    
    override init()
    {
        
    }
    
    
    init(stat_type: String, stat_number: String) {
        
   
        self.stat_type = stat_type
        self.stat_number = stat_number
    }
    
    //prints a team's statistics
    
    override var description: String {
        return "Stat_type: \(String(describing: stat_type))"
    }
    
}

