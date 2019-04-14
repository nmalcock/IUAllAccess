//
//  SCteamRosterViewController.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit

class SCteamRosterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullDataSCProtocol  {
    
    var feedItems: NSArray = NSArray()
    
    var selectedTeam : StoreDataSC = StoreDataSC()

    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView.delegate = self
        self.TableView.dataSource = self
        
        let pulldataSC = PullDataSC()
        pulldataSC.delegate = self
        pulldataSC.downloadItems()
        
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
        let cellIdentifier: String = "SoccerBasicCell1"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the athletes to be shown
        let item: StoreDataSC = feedItems[indexPath.row] as! StoreDataSC
        
        //let titleStr = feedItems
        
        let titleStr: String = item.fname! + " " + item.lname! + " " + item.number! + " " + item.position! + " " + item.year! + " " + item.height! +  " " + item.weight! + " " + item.hometown! + " " + item.highschool!
        print(titleStr)
        
        myCell.textLabel!.text = titleStr
        myCell.textLabel!.numberOfLines = 0

        
        return myCell
    }
    
}


