//
//  teamRosterViewController.swift
//  Team58App
//
//  Created by Michael Jacobucci on 2/13/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit

class teamRosterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullDataProtocol  {

    var feedItems: NSArray = NSArray()
    var selectedAthlete : StoreData = StoreData()
    @IBOutlet weak var athleteResultsFeed: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.athleteResultsFeed.delegate! = self
        self.athleteResultsFeed.dataSource! = self
        
        let pulldata = PullData()
        pulldata.delegate! = self
        pulldata.downloadItems()
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.athleteResultsFeed.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "stockCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the athletes to be shown
        let item: StoreData = feedItems[indexPath.row] as! StoreData
        
        let RosterStr: String = item.name!
        print(RosterStr)
        
        myCell.textLabel!.text = RosterStr
        
        return myCell
    }
    
}

