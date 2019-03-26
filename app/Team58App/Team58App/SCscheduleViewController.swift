//
//  SCscheduleViewController.swift
//  Team58App
//
//  Created by Michael Jacobucci on 3/25/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit

class SCscheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullScheduleDataSCProtocol {
    
    @IBOutlet weak var TableView: UITableView!
    
    var feedItems: NSArray = NSArray()
    var selectedSchedule : StoreScheduleDataSC = StoreScheduleDataSC()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView.delegate = self
        self.TableView.dataSource = self
        
        let pullScheduleDataSC = PullScheduleDataSC()
        pullScheduleDataSC.delegate = self
        pullScheduleDataSC.downloadItems()
        
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
        let cellIdentifier: String = "SoccerBasicCell3"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the game to be shown
        let item: StoreScheduleDataSC = feedItems[indexPath.row] as! StoreScheduleDataSC
        // Get references to labels of cell
        
        //let titleStr = feedItems
        let titleStr: String = item.opponent! + " " + item.date_time! + " " + item.w_L! + " " + item.home_score! + " " + item.away_score!
        print(titleStr)
        
        
        myCell.textLabel!.text = titleStr
        
        return myCell
    }
    
}
