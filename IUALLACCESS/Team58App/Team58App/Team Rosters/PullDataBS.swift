//
//  PullDataBS.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/24/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation

protocol PullDataBSProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class PullDataBS: NSObject, URLSessionDataDelegate {
    
    
    
    weak var delegate: PullDataBSProtocol!
    
    let urlPath =  "https://cgi.sice.indiana.edu/~team58/getBSrost.php"
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            
            if error != nil {
                print("Error")
            }else {
                print("Rosters downloaded")
                self.parseJSON(data!)
                print(data!)
            }
            
        }
        
        task.resume()
    }
    
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let athletes = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let athlete_info = StoreDataBS()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let fname = jsonElement["fname"] as? String,
                let lname = jsonElement["lname"] as? String,
                let number = jsonElement["number"] as? String,
                let position = jsonElement["position"] as? String,
                let year = jsonElement["year"] as? String,
                let image_path = jsonElement["image_path"] as? String,
                let teamID = jsonElement["teamID"] as? String,
                let height = jsonElement["height"] as? String,
                let weight = jsonElement["weight"] as? String,
                let hometown = jsonElement["hometown"] as? String,
                let highschool = jsonElement["highschool"] as? String,
                let athleteID = jsonElement["BSathleteID"] as? String
            {
                print(fname)
                print(lname)
                print(number)
                print(position)
                print(year)
                print(image_path)
                print(teamID)
                print(height)
                print(weight)
                print(hometown)
                print(highschool)
                print(athleteID)
                athlete_info.fname = fname
                athlete_info.lname = lname
                athlete_info.number = number
                athlete_info.position = position
                athlete_info.year = year
                athlete_info.image_path = image_path
                athlete_info.teamID = teamID
                athlete_info.height = height
                athlete_info.weight = weight
                athlete_info.hometown = hometown
                athlete_info.highschool = highschool
                athlete_info.athleteID = athleteID
                
            }
            
            athletes.add(athlete_info)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: athletes)
            
        })
    }
    
}
