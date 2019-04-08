

import Foundation
import UIKit
import CoreData

class FBteamStatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullTeamStatsDataFBProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedTeamStats : StoreTeamStatsDataFB = StoreTeamStatsDataFB()
    
    @IBOutlet var ListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ListTableView.delegate = self
        self.ListTableView.dataSource = self
        
        let pullTeamStatsDataFB = PullTeamStatsDataFB()
        pullTeamStatsDataFB.delegate = self
        pullTeamStatsDataFB.downloadItems()
        
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
        let cellIdentifier: String = "BasicCellFBStat"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the stats to be shown
        let item: StoreTeamStatsDataFB = feedItems[indexPath.row] as! StoreTeamStatsDataFB
        
        // Get references to labels of cell

        let titleStr: String = item.stat_type! + " " + item.stat_number!
        print(titleStr)
        
        
        myCell.textLabel!.text = titleStr
        myCell.textLabel!.numberOfLines = 0
        
        return myCell
    }
    
}
