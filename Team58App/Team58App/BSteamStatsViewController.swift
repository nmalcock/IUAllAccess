//
//  BSteamStatsViewController.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/26/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BSteamStatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullTeamStatsDataBSProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedTeamStats : StoreTeamStatsDataBS = StoreTeamStatsDataBS()

    @IBOutlet weak var TableView: UITableView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView.delegate = self
        self.TableView.dataSource = self
        
        let pullTeamStatsDataBS = PullTeamStatsDataBS()
        pullTeamStatsDataBS.delegate = self
        pullTeamStatsDataBS.downloadItems()
        
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
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "BasicCellBSStat"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the stats to be shown
        let item: StoreTeamStatsDataBS = feedItems[indexPath.row] as! StoreTeamStatsDataBS
        
        // Get references to labels of cell
        
        let titleStr: String = item.stat_type! + " " + item.stat_number!
        print(titleStr)
        
        
        myCell.textLabel!.text = titleStr
        myCell.textLabel!.numberOfLines = 0
        
        return myCell
    }
    
}
