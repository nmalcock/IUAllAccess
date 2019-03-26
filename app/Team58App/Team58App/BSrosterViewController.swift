//
//  BSrosterViewController.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit

class BSrosterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullDataBSProtocol  {
    
    var feedItems: NSArray = NSArray()
    
    var selectedTeam : StoreDataBS = StoreDataBS()
    
    
    @IBOutlet weak var TableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView.delegate = self
        self.TableView.dataSource = self
        
        let pulldataBS = PullDataBS()
        pulldataBS.delegate = self
        pulldataBS.downloadItems()
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.TableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
        //
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the athletes to be shown
        let item: StoreDataBS = feedItems[indexPath.row] as! StoreDataBS
        
        //let titleStr = feedItems
        
        let titleStr: String = item.fname! + " " + item.lname! + " " + item.number! + " " + item.position! + " " + item.year! + " " + item.image_path!
        print(titleStr)
        
        myCell.textLabel!.text = titleStr
        
        return myCell
    }
    
}




