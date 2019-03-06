//
//  PullData.swift
//  Team58App
//
//  Created by Michael Jacobucci on 2/13/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//
// code structure https://www.skysilk.com/blog/2018/how-to-connect-an-ios-app-to-a-mysql-database-swift/

//*********************************************************
//HOME MODEL = ROSTER PULL DATA
//*********************************************************

import Foundation

protocol PullDataProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class PullData: NSObject, URLSessionDataDelegate {
    
    
    
    weak var delegate: PullDataProtocol!
    
    let urlPath =  "https://cgi.sice.indiana.edu/~team58/GetAthlete.php"
    
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
            
            let athlete_info = StoreData()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let fname = jsonElement["fname"] as? String,
                let lname = jsonElement["lname"] as? String,
                let number = jsonElement["number"] as? String,
                let position = jsonElement["position"] as? String,
                let year = jsonElement["year"] as? String
                
            {
                print(fname)
                print(lname)
                print(number)
                print(position)
                print(year)
                athlete_info.fname = fname
                athlete_info.lname = lname
                athlete_info.number = number
                athlete_info.position = position
                athlete_info.year = year
                
                
            }
            
            athletes.add(athlete_info)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: athletes)
            
        })
    }
    
}
