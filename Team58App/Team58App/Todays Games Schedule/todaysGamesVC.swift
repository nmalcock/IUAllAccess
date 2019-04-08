//
//  todaysGamesVC.swift
//  Team58App
//
//  Created by Michael Jacobucci on 4/7/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit

class todaysGamesVC: ViewController, UITableViewDataSource, UITableViewDelegate, PullTGProtocol {
    
    var feedItems: NSArray = NSArray()
    var todaysGame : StoreDataTG = StoreDataTG()
    
    @IBOutlet weak var todaysTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todaysTableView.delegate = self
        self.todaysTableView.dataSource = self
        
        let pullDataTG = PullDataTG()
        pullDataTG.delegate = self
        pullDataTG.downloadItems()
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.todaysTableView.reloadData()
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
        let cellIdentifier: String = "TodaysGamesCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the game to be shown
        let item: StoreDataTG = feedItems[indexPath.row] as! StoreDataTG
        // Get references to labels of cell
        
        //let titleStr = feedItems
        
        let titleStr = String(item.opponent!)
        
        myCell.textLabel!.text = String("Baseball: " +  titleStr)
        
        return myCell
    }
    
}
    

