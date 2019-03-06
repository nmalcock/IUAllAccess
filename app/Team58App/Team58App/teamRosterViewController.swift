//
//  teamRosterViewController.swift
//  Team58App
//
//  Created by Michael Jacobucci on 2/13/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit
//class teamRosterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullDataProtocol  {
class teamRosterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullDataProtocol  {

    var feedItems: NSArray = NSArray()

    var selectedTeam : StoreData = StoreData()
    
    //was originally named athleteResultsfeed, changed to teamRosterListTableView for clarity.
    @IBOutlet weak var teamRosterListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.teamRosterListTableView.delegate = self
        self.teamRosterListTableView.dataSource = self
        
        let pulldata = PullData()
        pulldata.delegate = self
        pulldata.downloadItems()
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.teamRosterListTableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
        //
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       /* let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        cell.textLabel?.text = feedItems[indexPath.row] as! String //StoreData
        return cell
       */
       
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the athletes to be shown
       let item: StoreData = feedItems[indexPath.row] as! StoreData
        
       let titleStr: String? = item.fname
       print(titleStr)
        
        myCell.textLabel!.text = item.fname

        return myCell
    }
    
}

