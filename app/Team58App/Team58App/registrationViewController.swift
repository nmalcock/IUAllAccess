//
//  registrationViewController.swift
//  Team58App
//
//  Created by Becky Poplawski on 1/28/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit
import Alamofire


class registrationViewController: UIViewController {

    //Defined a constant that holds the URL for our web service
    let URL_USER_REGISTER = "http://192.168.1.105/SimplifiediOS/v1/register.php"
    
    //View variables

    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!

    
    //Button action
    @IBAction func buttonRegister(_ sender: UIButton) {
        
        //creating parameters for the post request
        let parameters: Parameters=[
            "password":textFieldPassword.text!,
            "email":textFieldEmail.text!
        ]
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                //if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    //let jsonData = result as! NSDictionary
                    
                    //displaying the message in label
                    //self.labelMessage.text = jsonData.value(forKey: "message") as! String?

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
