//
//  playerDetailViewController.swift
//  AthleteProfile
//
//  Created by Becky Poplawski on 3/26/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation



class playerDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PullindividualStatsDataProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectedTeamStats : StoreindividualStatsData = StoreindividualStatsData()

    
    @IBOutlet weak var ListTableView: UITableView!
    
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var lblnum: UILabel!
    @IBOutlet weak var lblpos: UILabel!
    @IBOutlet weak var lblyear: UILabel!
   
    @IBOutlet weak var lblhometown: UILabel!
    
    @IBOutlet weak var lblweight: UILabel!
    
    
    @IBOutlet weak var lblhighschool: UILabel!
    
    @IBOutlet weak var lblheight: UILabel!
    
    
    var image = UIImage()
    var name = ""
    var number = ""
    var position = ""
    var year = ""
    var teamID = ""
    var hometown = ""
    var weight = ""
    var height = ""
    var highschool = ""
    var athleteID = ""
    //var
    

    
    let addFavURL = "http://cgi.sice.indiana.edu/~team58/userFavoriteadd.php"
    
    let getStatsURL = "http://cgi.sice.indiana.edu/~team58/getindividualstat.php"
    
    let deleteFavURL = "http://cgi.sice.indiana.edu/~team58/userFavoriteDelete.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        lbl.text = "\(name)"
        img.image = image
        lblnum.text = "Number: \(number)"
        lblpos.text = "Position: \(position)"
        lblyear.text = "Year: \(year)"
        lblhometown.text = "Hometown: \(hometown)"
        lblweight.text = "Weight: \(weight)"
        lblhighschool.text = "Highschool: \(highschool)"
        lblheight.text = "Height: \(height)"
        
        
        self.ListTableView.delegate = self
        self.ListTableView.dataSource = self
        
        
        
        let parameters: Parameters=[
            "teamID":teamID,
            "athleteID":athleteID
        ]
        
        
        Alamofire.request(getStatsURL, method: .post, parameters: parameters).responseString
            {
                response in
                
                //print(response.result.value!)
                let data = response.data!
                
                let pullindividualstatsdata = PullindividualStatsData()
                pullindividualstatsdata.delegate = self
                //favpulldata.sendUserID()
                pullindividualstatsdata.parseJSON(data)

        }
        



        
    }
    
    


    
    @IBAction func onClickDelete(_ sender: Any) {
        
        let goHome = storyboard?.instantiateViewController(withIdentifier:  "homeController") as? UITabBarController
        
        let parameters: Parameters=[
            "userID":95,
            "teamID":teamID,
            "athleteID":athleteID
        ]
        
        Alamofire.request(deleteFavURL, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    print(result)
                    //print(jsonData[2])
                }else{
                    //error message in case of invalid credential
                    //self.labelMessage.text = "Invalid username or password"
                }
        }
        
        
        
        
        //favvc?.favimage = image
        //favvc?.favname = name
        
        
        self.navigationController?.pushViewController(goHome!, animated: true)
        
        
    }


    
    @IBAction func onClickFavorite(_ sender: Any) {
        
        let goHome = storyboard?.instantiateViewController(withIdentifier:  "homeController") as? UITabBarController
        
        let parameters: Parameters=[
            "userID":95,
            "teamID":teamID,
            "athleteID":athleteID
            ]
        
        Alamofire.request(addFavURL, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    print(result)
                        //print(jsonData[2])
                    }else{
                        //error message in case of invalid credential
                        //self.labelMessage.text = "Invalid username or password"
                    }
            }
        
        
        
        
        //favvc?.favimage = image
        //favvc?.favname = name

        
        self.navigationController?.pushViewController(goHome!, animated: true)
        
        
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
        let titleStr: String = item.stat_type! + " " + item.stat_number!
        print(titleStr)
        
        
        myCell.textLabel!.text = titleStr
        myCell.textLabel!.numberOfLines = 0
        
        return myCell
    }

}
