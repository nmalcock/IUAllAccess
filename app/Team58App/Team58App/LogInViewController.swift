//
//  LogInViewController.swift
//  Team58App
//
//  Created by Becky Poplawski on 2/4/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit
import Alamofire



class LogInViewController: UIViewController {
    
    
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "http://192.168.1.105/SimplifiediOS/v1/login.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    

    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    
    
    @IBAction func buttonLogin(_ sender: UIButton) {
        let parameters: Parameters=[
            "username":textFieldUserName.text!,
            "password":textFieldPassword.text!
        ]
        
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        //getting user values
                        let userId = user.value(forKey: "id") as! Int
                        let userName = user.value(forKey: "username") as! String
                        let userEmail = user.value(forKey: "email") as! String
                        let userPhone = user.value(forKey: "phone") as! String
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userName, forKey: "username")
                        self.defaultValues.set(userEmail, forKey: "useremail")
                        self.defaultValues.set(userPhone, forKey: "userphone")
                        
                        //switching the screen
                        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        self.navigationController?.pushViewController(ViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        //self.labelMessage.text = "Invalid username or password"
                    }
                }
        }
    }
  
    

    
    
}



//hiding the navigation button


//if user is already logged in switching to profile screen
/*if defaultValues.string(forKey: "username") != nil{
    let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
    self.navigationController?.pushViewController(ViewController, animated: true)
}
*/
