//
//  SCstatsViewController.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SCstatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullTeamStatsDataSCProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedTeamStats : StoreTeamStatsDataSC = StoreTeamStatsDataSC()
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView.delegate = self
        self.TableView.dataSource = self
        
        let pullTeamStatsDataSC = PullTeamStatsDataSC()
        pullTeamStatsDataSC.delegate = self
        pullTeamStatsDataSC.downloadItems()
        
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
        let cellIdentifier: String = "SoccerBasicCell2"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the stats to be shown
        let item: StoreTeamStatsDataSC = feedItems[indexPath.row] as! StoreTeamStatsDataSC
        
        // Get references to labels of cell
        
        //let titleStr = feedItems
 
        let titleStr: String = item.stat_type! + " " + item.stat_number!
        print(titleStr)
        
        
        myCell.textLabel!.text = titleStr
        
        return myCell
    }
    
}
