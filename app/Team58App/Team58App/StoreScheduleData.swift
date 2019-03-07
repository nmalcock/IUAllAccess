//
//  StoreScheduleData.swift
//  Team58App
//
//  Created by Michael Jacobucci on 2/18/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit

class StoreScheduleData: NSObject {
    
    //properties
    
    var opponent: String?
  //  var gameday: String?
    var date_time: String?
  //  var iuscore: String?
    var home_score: String?
  //  var opponentscore: String?
    var away_score: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    init(opponent: String, date_time: String, home_score: String, away_score: String)
    {
   // init(opponent: String, gameday: String, iuscore: String, opponentscore: String) {
        
        self.opponent = opponent
        self.date_time = date_time
        self.home_score = home_score
        self.away_score = away_score
      //  self.gameday = gameday
     //   self.iuscore = iuscore
      //  self.opponentscore = opponentscore
      
    }
    
    
    override var description: String {
       // return "Opponent: \(String(describing: opponent)), Date of Game: \(String(describing: gameday)), IU Score: \(String(describing: iuscore)), Opponent Score: \(String(describing: opponentscore))"
        return "Opponent: \(String(describing: opponent)), Date_time: \(String(describing: date_time)), Home_score: \(String(describing: home_score)), Away_score: \(String(describing: away_score))"
}
    
}

