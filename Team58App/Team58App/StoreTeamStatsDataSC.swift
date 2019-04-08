//
//  StoreTeamStatsDataSC.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class StoreTeamStatsDataSC: NSObject {
    
    
    var stats: String?
    
    
    override init()
    {
        
    }
    
    
    init(stats: String) {
        
        
        self.stats = stats
    }
    
    //prints a team's statistics
    
    override var description: String {
        return "Stats: \(String(describing: stats))"
    }
    
}
