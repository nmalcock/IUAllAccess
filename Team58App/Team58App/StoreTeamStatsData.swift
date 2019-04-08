//
//  StoreTeamStatsData.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/18/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit

class StoreTeamStatsData: NSObject {
    
  
    var stats: String?
//    var stat_number: String?
    
    
    override init()
    {
        
    }
    
    
    init(stats: String) {
        
   
        self.stats = stats
//        self.stat_number = stat_number
    }
    
    //prints a team's statistics
    
    override var description: String {
        return "Stats: \(String(describing: stats))"
    }
    
}

