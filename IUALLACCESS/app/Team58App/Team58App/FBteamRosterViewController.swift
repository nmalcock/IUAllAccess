//
//  FBteamRosterViewController.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit
//class teamRosterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullDataProtocol  {
class FBteamRosterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullDataFBProtocol  {
    
    var feedItems: NSArray = NSArray()
    
    var selectedTeam : StoreDataFB = StoreDataFB()
    
    //was originally named athleteResultsfeed, changed to teamRosterListTableView for clarity.
    @IBOutlet weak var teamRosterListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.teamRosterListTableView.delegate = self
        self.teamRosterListTableView.dataSource = self
        
        
        let pulldataFB = PullDataFB()
        pulldataFB.delegate = self
        pulldataFB.downloadItems()
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.teamRosterListTableView.reloadData()
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
        let cellIdentifier: String = "BasicCellFBRost"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the athletes to be shown
        let item: StoreDataFB = feedItems[indexPath.row] as! StoreDataFB
        
        //let titleStr = feedItems
        
        let titleStr: String = item.fname! + " " + item.lname! + " " + item.number! + " " + item.position! + " " + item.year! + " " + item.image_path!
        print(titleStr)
        
        myCell.textLabel!.text = titleStr
        
        return myCell
    }
    
}

