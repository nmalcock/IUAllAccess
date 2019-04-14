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
                
                let responseString = String(data: data!, encoding: .utf8)
                print("responseString = \(responseString)")
                
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
        
    }
    
    func parseJSON(_ data:Data) {
        
       // var jsonResult = NSArray()
        
        do{
            let jsonResult = try JSONSerialization.jsonObject(with: data, options:[])
            
            guard let jsonArray = jsonResult as? [[String: Any]] else{
                print("JSON parse empty")
                return
            }
            
        
     //   var jsonElement = NSDictionary()
        var schedules = [StoreDataTG]()
        
        for item in jsonArray
        {
            let jsonElement = item as [String: Any?]
            
            let TGschedule = StoreDataTG()
        
            
            if let opponent = jsonElement["opponent"] as? String,
                let Baseball = jsonElement["Baseball"] as? String
                
                
            {
                print(opponent)
                print(Baseball)
                TGschedule.opponent = opponent
                TGschedule.Baseball = Baseball
            }
            
            schedules.append(TGschedule)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: schedules as NSArray)
            
            
        })
        } catch let error as NSError {
            print(error)
            
        }
    }
}
