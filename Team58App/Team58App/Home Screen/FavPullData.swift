//
//  FavPullData.swift
//  favAttempt
//
//  Created by Becky Poplawski on 4/1/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol FavPullDataProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class FavPullData: NSObject, URLSessionDataDelegate {
    
    
    
    weak var delegate: FavPullDataProtocol!
    
    
    
    let urlPath =  "https://cgi.sice.indiana.edu/~team58/userFavorites.php"
    
    
    let URL_USER_ID = "http://cgi.sice.indiana.edu/~team58/userFavorites.php"
    
    
    let parameters: Parameters=[
        "userID": 95
    ]
    
    
    /*func sendUserID() {
        Alamofire.request(URL_USER_ID, method: .post, parameters: parameters).responseString
            {
                response in
                print(response.result.value!)
                
        }
        
    }*/

    
    func downloadItems() {
        
        Alamofire.request(URL_USER_ID, method: .post, parameters: parameters).responseString
            {
                response in

                //print(response.result.value!)
                let data = response.data
                self.parseJSON(data!)
                print(data!)
        }

    }
        
        /*let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            
            if error != nil {
                print("Error")
            }else {
                print("Favorites Downloaded")
                self.parseJSON(data!)
                print(data!)
            }
            
        }
        
        task.resume()
    }*/
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        //let athletes = NSMutableArray()
        let favorites = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            //let athlete_info = StoreData()
            let favorites_info = FavStoreData()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let fname = jsonElement["fname"] as? String,
                let lname = jsonElement["lname"] as? String,
                let image_path = jsonElement["image_path"] as? String
            {
                print(fname)
                print(lname)
                print(image_path)
                favorites_info.fname = fname
                favorites_info.lname = lname
                favorites_info.image_path = image_path

                
            }
            
            favorites.add(favorites_info)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: favorites)
            
        })
    }
    
}
