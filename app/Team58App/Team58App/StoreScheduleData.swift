//
//  StoreScheduleData.swift
//  Team58App
//
//  Created by Michael Jacobucci on 2/18/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation

class StoreScheduleData: NSObject {
    
    //properties
    
    var opponent: String?
    var game_date: Date?
    var iu_score: Int?
    var opponent_score: Int?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(Opponent: String, DateofGame: Date, IndianaScore: Int, OpponentScore: Int) {
        
        self.opponent = Opponent
        self.game_date = DateofGame
        self.iu_score = IndianaScore
        self.opponent_score = OpponentScore
        
    }
    
    
    //prints object's current state
    
  //  override var description: String {
        //return "Opponent: \(String(describing: opponent)), Date of Game: \(Date(describing: game_date)), IU Score: \(Int(describing: iu_score)), Opponent Score: \(Int(describing: opponent_score))"
  //  }
    
    
}
