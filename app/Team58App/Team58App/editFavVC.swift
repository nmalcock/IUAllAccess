//
//  editFavVC.swift
//  Team58App
//
//  Created by Becky Poplawski on 3/26/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//
import UIKit
import Foundation

class editFavVC: UIViewController, UITableViewDataSource, UITableViewDelegate, PullDataProtocol {
    
    let cellId = "BasicCell"
    
    var feedItems: NSArray = NSArray()
    
    var star: String = ""
    
    var selectedTeam : StoreData = StoreData()
    
    
    @IBOutlet weak var TableView: UITableView!
    
    
    func callFavMethod(cell: UITableViewCell) {


    
    }



override func viewDidLoad() {
    super.viewDidLoad()
    
    self.TableView.delegate = self
    self.TableView.dataSource = self
    
    let pulldata = PullData()
    pulldata.delegate = self
    pulldata.downloadItems()
    
    TableView.register(FavoriteCell.self, forCellReuseIdentifier: cellId)
    
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
    // Return the number of feed items
    return feedItems.count
    
}





func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // Retrieve cell
    let cellIdentifier: String = "BasicCell"
    let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
    // Get the athletes to be shown
    let item: StoreData = feedItems[indexPath.row] as! StoreData
    
    //let titleStr = feedItems
    let titleStr: String = item.fname! + " " + item.lname!
    
   // let indexPathTapped = TableView.indexPath(for: myCell)
    //myCell.accessoryView?.tintColor = (indexPathTapped != nil) ? UIColor.red : UIColor.lightGray
    
    print(titleStr)
    /*for i in titleStr {
     star.append(i)
     }
     print(star)*/
    
    
    //myCell.accessoryView?.tintColor = hasFavorited ? UIColor.lightGray : .red
    
    myCell.textLabel!.text = titleStr
    
    return myCell
}

}
