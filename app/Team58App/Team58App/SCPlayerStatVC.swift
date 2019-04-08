//
//  SCPlayerStatVC.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class SCPlayerStatVC: UIViewController, UITableViewDataSource, UITableViewDelegate, PullindividualStatsDataSCProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedTeamStats : StoreindividualStatsDataSC = StoreindividualStatsDataSC()

    @IBOutlet weak var TableView: UITableView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView.delegate = self
        self.TableView.dataSource = self
        
        let pullindividualStatsDataSC = PullindividualStatsDataSC()
        pullindividualStatsDataSC.delegate = self
        pullindividualStatsDataSC.downloadItems()
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.TableView.reloadData()
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
        let cellIdentifier: String = "PlayerStat3"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the stats to be shown
        let item: StoreindividualStatsDataSC = feedItems[indexPath.row] as! StoreindividualStatsDataSC
        
        // Get references to labels of cell
        
        //let titleStr = feedItems
        
        let titleStr: String = item.FullName! + " " + item.stats!
        print(titleStr)
        
        
        myCell.textLabel!.text = titleStr
        myCell.textLabel!.numberOfLines = 0
        
        return myCell
    }
    
}

