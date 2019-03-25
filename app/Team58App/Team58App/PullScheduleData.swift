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
    
    let urlPath =  "https://cgi.sice.indiana.edu/~team58/getBBsched.php"
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Error")
            }else {
                print("Schedules downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
        
    }
//class PullScheduleData: NSObject, URLSessionDataDelegate {
    

  // weak var delegate: PullScheduleDataProtocol!
    
  //  var data = Data()
    
  //  let urlPath: String = "https://cgi.sice.indiana.edu/~team58/getSchedule.php"

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
            //need all parameters on pic i took except box_score_link
            
            if let opponent = jsonElement["opponent"] as? String,
                let date_time = jsonElement["date_time"] as? String,
                let home_score = jsonElement["home_score"] as? String,
                let away_score = jsonElement["away_score"] as? String
                //let gameday = jsonElement["gameday"] as? String,
               // let iuscore = jsonElement["iuscore"] as? String,
              //  let opponentscore = jsonElement["opponentscore"] as? String
            
            {
                print(opponent)
             //   print(gameday)
             //   print(iuscore)
            //    print(opponentscore)
                print(date_time)
                print(home_score)
                print(away_score)
                schedule.opponent = opponent
                schedule.date_time = date_time
                schedule.home_score = home_score
                schedule.away_score = away_score
             //   schedule.gameday = gameday
             //   schedule.iuscore = iuscore
             //   schedule.opponentscore = opponentscore
            
            }
        
            schedules.add(schedule)
    
        }
    
        DispatchQueue.main.async(execute: { () -> Void in
        
            self.delegate.itemsDownloaded(items: schedules)
        
        })
}

}
