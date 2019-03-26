//
//  StoreScheduleDataSC.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class StoreScheduleDataSC: NSObject {
    
    //properties
    
    var opponent: String?
    var date_time: String?
    var w_L: String?
    var home_score: String?
    var away_score: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    init(opponent: String, date_time: String, w_L: String, home_score: String, away_score: String)
    {
        
        
        self.opponent = opponent
        self.date_time = date_time
        self.w_L = w_L
        self.home_score = home_score
        self.away_score = away_score
        
        
    }
    
    
    override var description: String {
        
        return "Opponent: \(String(describing: opponent)), w_L: \(String(describing: w_L)),Date_time: \(String(describing: date_time)), Home_score: \(String(describing: home_score)), Away_score: \(String(describing: away_score))"
    }
    
}
