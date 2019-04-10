//
//  FavBSVC.swift
//  AthleteProfile
//
//  Created by Becky Poplawski on 3/31/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class FavBSVC: UIViewController, UITableViewDataSource, UITableViewDelegate, PullDataBSProtocol {
    
    //var name = ["Evan Fitzner", "Romeo Langford"]
    var feedItems: NSArray = NSArray()
    var selectedTeam : StoreDataBS = StoreDataBS()
    
    /////////////////////////////////////////////////////////
    var refreshCtrl: UIRefreshControl!
    var tableData:[AnyObject]!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    
    //var selectedTeam : StoreDataBS = StoreDataBS()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        //self.refreshCtrl = UIRefreshControl()
        //self.refreshCtrl.addTarget(self, action: #selector(homeScreenViewController2.refreshTableView), for: .touchUpInside)
        //self.refreshControl = self.refreshCtrl
        
        
        
        self.tableData = []
        self.cache = NSCache()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let pulldata = PullDataBS()
        pulldata.delegate = self
        pulldata.downloadItems()
        
        
        
        
    }
    
    
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.tableView.reloadData()
        
    }
    
    /*func refreshTableView(){
     
     let url:URL! = URL(string: "https://iuhoosiers.com/images/2018/8/15/Web_Langford.jpg?width=80")
     task = session.downloadTask(with: url, completionHandler: { (playerPic: URL?, response: URLResponse?, error: Error?) -> Void in
     
     if playerPic != nil{
     let data:Data! = try? Data(contentsOf: playerPic!)
     do{
     let item = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as AnyObject
     self.tableData = item.value(forKey : "image_path") as? [AnyObject]
     DispatchQueue.main.async(execute: { () -> Void in
     self.tableView.reloadData()
     self.refreshCtrl?.endRefreshing()
     })
     }catch{
     print("something went wrong, try again")
     }
     }
     })
     task.resume()
     }*/
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return feedItems.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavTableViewCell
        //possibly call the array that passes image here?
        let item: StoreDataBS = feedItems[indexPath.row] as! StoreDataBS
        cell?.lbl.text = item.fname! + " " + item.lname!
        
        //cell?.img?.image = UIImage(named: "placeholder")
        
        cell?.imageView?.image = nil  //or the placeholder image
        
        
        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            // 2
            // Use cache
            //print("Cached image used, no need to download it")
            cell?.imageView?.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        }else{
            // 3
            let artworkUrl = item.image_path! as String
            let url:URL! = URL(string: artworkUrl)
            print(url)
            task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                if let data = try? Data(contentsOf: url){
                    // 4
                    DispatchQueue.main.async(execute: { () -> Void in
                        // 5
                        // Before we assign the image, check whether the current cell is visible
                        if let updateCell = tableView.cellForRow(at: indexPath) {
                            let img:UIImage! = UIImage(data: data)
                            updateCell.imageView?.image = img
                            self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                            self.tableView.reloadData()
                        }
                    })
                }
            })
            task.resume()
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier:  "playerDetailViewController") as? playerDetailViewController
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavTableViewCell
        let item: StoreDataBS = feedItems[indexPath.row] as! StoreDataBS
        vc?.image = (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage)!
        vc?.name = item.fname! + " " + item.lname!
        vc?.number = item.number!
        vc?.position = item.position!
        vc?.year = item.year!
        vc?.athleteID = item.athleteID!
        vc?.teamID = item.teamID!
        vc?.height = item.height!
        vc?.weight = item.weight!
        vc?.hometown = item.hometown!
        vc?.highschool = item.highschool!

        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
}
