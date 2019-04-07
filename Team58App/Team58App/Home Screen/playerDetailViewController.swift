//
//  playerDetailViewController.swift
//  AthleteProfile
//
//  Created by Becky Poplawski on 3/26/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit

class playerDetailViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var lblnum: UILabel!
    @IBOutlet weak var lblpos: UILabel!
    @IBOutlet weak var lblyear: UILabel!
    
    var image = UIImage()
    var name = ""
    var number = ""
    var position = ""
    var year = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl.text = "\(name)"
        img.image = image
        lblnum.text = "Number: \(number)"
        lblpos.text = "Position: \(position)"
        lblyear.text = "Year: \(year)"
    }
    
    @IBAction func onClickFavorite(_ sender: Any) {
        let favvc = storyboard?.instantiateViewController(withIdentifier:  "homeScreenViewController") as? homeScreenViewController
        //favvc?.favimage = image
        //favvc?.favname = name

        
        self.navigationController?.pushViewController(favvc!, animated: true)
        
        
    }
    
}
