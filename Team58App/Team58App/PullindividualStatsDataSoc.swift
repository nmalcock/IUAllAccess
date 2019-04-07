//
//  PullindividualStatsDataSoc.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/24/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation

protocol PullindividualStatsDataSCProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class PullindividualStatsDataSC: NSObject, URLSessionDataDelegate {
    
    
    
    weak var delegate: PullindividualStatsDataSCProtocol!
    
    let urlPath =  "https://cgi.sice.indiana.edu/~team58/getSCstat.php"
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Error")
            }else {
                print("Athlete's stats downloaded")
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
        let stats = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let solo_statistics = StoreindividualStatsDataSC()
            
            if let stat_type = jsonElement["stat_type"] as? String,
                let stat_number = jsonElement["stat_number"] as? String
                
                
            {
                
                print(stat_type)
                print(stat_number)
                solo_statistics.stat_type = stat_type
                solo_statistics.stat_number = stat_number
            }
            
            stats.add(solo_statistics)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: stats)
            
        })
    }
    
}
