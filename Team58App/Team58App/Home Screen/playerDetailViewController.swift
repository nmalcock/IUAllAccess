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

class playerDetailViewController: UIViewController {
    
    
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

        
        let parameters: Parameters=[
            "athleteID":athleteID,
            "teamID":teamID

        ]
        Alamofire.request(getStatsURL, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)

                //getting the json value from the server
    
                

           
                    //error message in case of invalid credential
                    //self.labelMessage.text = "Invalid username or password"
                
        }
        
        
    }
    


    
    @IBAction func onClickDelete(_ sender: Any) {
        
        let favvc = storyboard?.instantiateViewController(withIdentifier:  "homeScreenViewController") as? homeScreenViewController
        
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
        
        
        self.navigationController?.pushViewController(favvc!, animated: true)
        
        
    }


    
    @IBAction func onClickFavorite(_ sender: Any) {
        
        let favvc = storyboard?.instantiateViewController(withIdentifier:  "homeScreenViewController") as? homeScreenViewController
        
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

        
        self.navigationController?.pushViewController(favvc!, animated: true)
        
        
    }
    
}
