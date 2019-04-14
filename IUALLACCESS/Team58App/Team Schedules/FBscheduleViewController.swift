import UIKit

class FBscheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullScheduleDataFBProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedSchedule : StoreScheduleDataFB = StoreScheduleDataFB()
    
   @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let pullScheduleDataFB = PullScheduleDataFB()
        pullScheduleDataFB.delegate = self
        pullScheduleDataFB.downloadItems()
        
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
        let cellIdentifier: String = "BasicCellFBSchedule"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the game to be shown
        let item: StoreScheduleDataFB = feedItems[indexPath.row] as! StoreScheduleDataFB
        // Get references to labels of cell
        
        //let titleStr = feedItems
        let titleStr: String = item.opponent! + " " + item.date_time! + " " + item.w_L! + " " + item.home_score! + " " + item.away_score!
        print(titleStr)
        
        
        myCell.textLabel!.text = titleStr
        
        return myCell
    }
    
}
