//
//  TGPullData.swift
//  Team58App
//
//  Created by Michael Jacobucci on 4/7/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
protocol PullTGProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class PullDataTG: NSObject, URLSessionDataDelegate {
    
    
    
    weak var delegate: PullTGProtocol!
    
    let urlPath =  "https://cgi.sice.indiana.edu/~team58/getBStoday.php"
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
            
            let TGschedule = StoreDataTG()
            
            //the following insures none of the JsonElement values are nil through optional binding
            //need all parameters on pic i took except box_score_link
            
            if let opponent = jsonElement["opponent"] as? String,
                let Baseball = jsonElement["Baseball"] as? String
                
                
            {
                print(opponent)
                print(Baseball)
                TGschedule.opponent = opponent
                TGschedule.Baseball = Baseball
            }
            
            schedules.add(TGschedule)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: schedules)
            
        })
    }
    
}
