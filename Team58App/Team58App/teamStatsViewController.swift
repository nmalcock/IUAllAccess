//
//  teamStatsViewController.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/18/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class teamStatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullTeamStatsDataProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedTeamStats : StoreTeamStatsData = StoreTeamStatsData()
    
    @IBOutlet var ListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ListTableView.delegate = self
        self.ListTableView.dataSource = self
        
        let pullTeamStatsData = PullTeamStatsData()
        pullTeamStatsData.delegate = self
        pullTeamStatsData.downloadItems()
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.ListTableView.reloadData()
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
        let cellIdentifier: String = "BasicCell3"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the stats to be shown
        let item: StoreTeamStatsData = feedItems[indexPath.row] as! StoreTeamStatsData
        
        // Get references to labels of cell
        
        //let titleStr = feedItems
       // let titleStr: String = item.GP! + " " + item.fieldgoalP! + " " + item.threepointP! + " " + item.freethrowP! + " " + item.ppg! + " " + item.rebounds! + " " + item.fouls! + " " + item.assists! + " " + item.turnovers! + " " + item.steals! + " " + item.blocks!
        let titleStr: String = item.stat_type! + " " + item.stat_number!
        print(titleStr)
        
        
        myCell.textLabel!.text = titleStr
        myCell.textLabel!.numberOfLines = 0
        
        return myCell
    }
    
}
