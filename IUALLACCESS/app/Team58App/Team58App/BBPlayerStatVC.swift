//
//  BBPlayerStatVC.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class BBPlayerStatVC: UIViewController, UITableViewDataSource, UITableViewDelegate, PullindividualStatsDataProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedTeamStats : StoreindividualStatsData = StoreindividualStatsData()
    
    
    @IBOutlet weak var ListTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ListTableView.delegate = self
        self.ListTableView.dataSource = self
        
        let pullindividualStatsData = PullindividualStatsData()
        pullindividualStatsData.delegate = self
        pullindividualStatsData.downloadItems()
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.ListTableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        //
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "PlayerStat1"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the stats to be shown
        let item: StoreindividualStatsData = feedItems[indexPath.row] as! StoreindividualStatsData
        
        // Get references to labels of cell
        
        //let titleStr = feedItems
        // let titleStr: String = item.GP! + " " + item.fieldgoalP! + " " + item.threepointP! + " " + item.freethrowP! + " " + item.ppg! + " " + item.rebounds! + " " + item.fouls! + " " + item.assists! + " " + item.turnovers! + " " + item.steals! + " " + item.blocks!
        let titleStr: String = item.FullName! + " " + item.stats!
        print(titleStr)
        
        
        myCell.textLabel!.text = titleStr
        myCell.textLabel!.numberOfLines = 0
        
        return myCell
    }
    
}

