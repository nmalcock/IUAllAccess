//
//  StoreIndividualStatsDataFB.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class StoreindividualStatsDataFB: NSObject {
    
    var FullName: String?
    var stats: String?
//    var stat_type: String?
//    var stat_number: String?
    
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    
//    init(stat_type: String, stat_number: String) {
    init(FullName: String, stats: String) {
    
//        self.stat_type = stat_type
//        self.stat_number = stat_number
        self.FullName = FullName
        self.stats = stats
    }
    
    //prints a team's statistics
    
    override var description: String {
        
//        return "Stat_type: \(String(describing: stat_type)), Stat_number: \(String(describing: stat_number))"
        return "FullName: \(String(describing: FullName)), Stats: \(String(describing: stats))"
    }
    
}
