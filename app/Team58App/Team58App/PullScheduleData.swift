//
//  PullScheduleData.swift
//  Team58App
//
//  Created by Michael Jacobucci on 2/18/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

// code structure https://codewithchris.com/iphone-app-connect-to-mysql-database/ 

import Foundation

protocol PullScheduleDataProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class PullScheduleData: NSObject, URLSessionDataDelegate {
    
    
    
    weak var delegate: PullScheduleDataProtocol!
    
    let urlPath =  "https://cgi.sice.indiana.edu/~team58/scheduleSelect.php"
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Error")
            }else {
                print("statistics downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
        
    }
//class PullScheduleData: NSObject, URLSessionDataDelegate {
    

  // weak var delegate: PullScheduleDataProtocol!
    
  //  var data = Data()
    
  //  let urlPath: String = "https://cgi.sice.indiana.edu/~team58/scheduleSelect.php"

  //  func downloadItems() {
        
    //    let url: URL = URL(string: urlPath)!
    //    let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
    //    let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
     //       if error != nil {
     //           print("Error downloading data")
     //       }else {
     //           print("Schedules downloaded")
     //           self.parseJSON(data!)
     //       }
            
   // }
        
    //    task.resume()
  //  }
//}
     func parseJSON(_ data:Data) {
    
        var jsonResult = NSArray()
    
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        
        } catch let error as NSError {
            print(error)
        
        }
    
        var jsonElement = NSDictionary()
        let schedules = NSMutableArray()
    
        for i in 0 ..< jsonResult.count
        {
        
            jsonElement = jsonResult[i] as! NSDictionary
        
            let schedule = StoreScheduleData()
        
        //the following insures none of the JsonElement values are nil through optional binding
            
            if let opponent = jsonElement["Opponent"] as? String,
                let game_date = jsonElement["DateofGame"] as? Date,
                let iu_score = jsonElement["IndianaScore"] as? Int,
                let opponent_score = jsonElement["OpponentScore"] as? Int
            {
            
                schedule.opponent = opponent
                schedule.game_date = game_date
                schedule.iu_score = iu_score
                schedule.opponent_score = opponent_score
            
            }
        
            schedules.add(schedule)
    
        }
    
        DispatchQueue.main.async(execute: { () -> Void in
        
            self.delegate.itemsDownloaded(items: schedules)
        
        })
}
}
