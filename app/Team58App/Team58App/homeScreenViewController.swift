//
//  homeScreenViewController.swift
//  IUALLACCESS
//
//  Created by Becky Poplawski on 1/28/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit


class homeScreenViewController: UIViewController {

    @IBOutlet weak var labelEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "email"){
            //setting the name to label
            labelEmail.text = name
        }else{
            //send back to login view controller
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
