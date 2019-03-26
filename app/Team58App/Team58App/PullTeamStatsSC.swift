//
//  PullTeamStatsSC.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/24/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

protocol PullTeamStatsDataSCProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class PullTeamStatsDataSC: NSObject, URLSessionDataDelegate {
    
    
    
    weak var delegate: PullTeamStatsDataSCProtocol!
    
    let urlPath =  "https://cgi.sice.indiana.edu/~team58/getSCtstat.php"
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Error")
            }else {
                print("Team Stats downloaded")
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
        let teams = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let team_statistics = StoreTeamStatsDataSC()
            
            if let stat_type = jsonElement["stat_type"] as? String,
                let stat_number = jsonElement["stat_number"] as? String
                
            {
                print(stat_type)
                print(stat_number)
                
                
                team_statistics.stat_type = stat_type
                team_statistics.stat_number = stat_number
                
            }
            teams.add(team_statistics)
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: teams)
            
        })
    }
    
}
