//
//  StoreTeamStatsData.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/18/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit

class StoreTeamStatsData: NSObject {
    
   // var GP: String?
  //  var fieldgoalP: String?
  //  var threepointP: String?
  //  var freethrowP: String?
  //  var ppg: String?
  //  var rebounds: String?
  //  var fouls: String?
  //  var assists: String?
  //  var turnovers: String?
  //  var steals: String?
  //  var blocks: String?
    var stat_type: String?
    var stat_number: String?
    
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with parameters
   // init(GP: String, fieldgoalP: String, threepointP: String, freethrowP: String, ppg: String, rebounds: String, fouls: String, assists: String, turnovers: String, steals: String, blocks: String) {
    
    
    init(stat_type: String, stat_number: String) {
        
     /*   self.GP = GP
        self.fieldgoalP = fieldgoalP
        self.threepointP = threepointP
        self.freethrowP = freethrowP
        self.ppg = ppg
        self.rebounds = rebounds
        self.fouls = fouls
        self.assists = assists
        self.turnovers = turnovers
        self.steals = steals
        self.blocks = blocks
        */
        self.stat_type = stat_type
        self.stat_number = stat_number
    }
    
    //prints a team's statistics
    
    override var description: String {
        return "Stat_type: \(String(describing: stat_type)), Stat_number: \(String(describing: stat_number))"
    }
    
    
}

