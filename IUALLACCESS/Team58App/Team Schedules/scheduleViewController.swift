//
//  scheduleViewController.swift
//  Team58App
//
//  Created by Michael Jacobucci on 2/18/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit

class scheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullScheduleDataProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedSchedule : StoreScheduleData = StoreScheduleData()

    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let pullScheduleData = PullScheduleData()
        pullScheduleData.delegate = self
        pullScheduleData.downloadItems()
        
    }
    
    func itemsDownloaded(items: NSArray) {
        
        feedItems = items
        self.listTableView.reloadData()
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
        let cellIdentifier: String = "BasicCell2"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the game to be shown
        let item: StoreScheduleData = feedItems[indexPath.row] as! StoreScheduleData
        // Get references to labels of cell
        
        //let titleStr = feedItems
        let titleStr: String = item.opponent! + " " + item.date_time! + " " + item.w_L! + " " + item.home_score! + " " + item.away_score!
        print(titleStr)
        
        
        myCell.textLabel!.text = titleStr
        
        return myCell
    }
    
}

