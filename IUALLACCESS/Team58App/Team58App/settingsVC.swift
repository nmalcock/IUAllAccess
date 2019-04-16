//
//  settingsVC.swift
//  Team58App
//
//  Created by Becky Poplawski on 4/11/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class settingsVC: UIViewController, UITextFieldDelegate {
    
    var userID = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let userSettingsURL = "https://cgi.sice.indiana.edu/~team58/userSetting.php"
         let defaultValues = UserDefaults.standard
         let myUser = defaultValues.string(forKey: "userID")!
         
         let parameters: Parameters=[
         "userID":myUser
         ]
         
         Alamofire.request(userSettingsURL, method: .post, parameters: parameters).responseJSON
         {
         response in
         print(response)
         
         
         }*/
        getUserPrefs()
        
    }
    func getUserPrefs() {
        
        let defaultValues = UserDefaults.standard
        let myUser = defaultValues.string(forKey: "userID")!
        print(myUser)
        
        
        let parameters: Parameters=[
            "userID": myUser
        ]
        let userSettingsURL = "https://cgi.sice.indiana.edu/~team58/userSetting.php"
        
        Alamofire.request(userSettingsURL, method: .post, parameters: parameters).responseString
            {
                response in
                
                //print(response.result.value!)
                let data = response.data
                self.parseJSON(data!)
                print(data!)
        }
        
    }
    
    
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let gameReminder = jsonElement["gameReminder"] as? String,
                let statUpdate = jsonElement["statUpdate"] as? String
                
                
                
            {
                print(gameReminder)
                print(statUpdate)
            }
            
            
        }
        
        
    }
    
    
    
    
//TURNING GAME REMINDERS ON OR OFF
    @IBAction func reminders(_ sender: UISwitch) {
        
        if (sender.isOn == true ) {
            
            
            let gameRemindersURL = "https://cgi.sice.indiana.edu/~team58/ModuserSetting.php"
            let defaultValues = UserDefaults.standard
            let myUser = defaultValues.string(forKey: "userID")!
            
            let parameters: Parameters=[
                "userID":myUser,
                "gameReminder":"Yes"
            ]
        
        Alamofire.request(gameRemindersURL, method: .post, parameters: parameters).responseJSON
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
        } else {
            let gameRemindersURL = "https://cgi.sice.indiana.edu/~team58/ModuserSetting.php"
            let defaultValues = UserDefaults.standard
            let myUser = defaultValues.string(forKey: "userID")!
            
            let parameters: Parameters=[
                "userID":myUser,
                "gameReminder":"No",
                "statUpdate":"No"
            ]
            
            Alamofire.request(gameRemindersURL, method: .post, parameters: parameters).responseJSON
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
            
        }
        
    }
        
    
//TURNING STAT UPDATES ON OR OFF
    @IBAction func updates(_ sender: UISwitch) {
        
        if (sender.isOn == true ) {
            let gameRemindersURL = "https://cgi.sice.indiana.edu/~team58/statreminderupdate.php"
            let defaultValues = UserDefaults.standard
            let myUser = defaultValues.string(forKey: "userID")!
            
        let parameters: Parameters=[
                "userID":myUser,
                "statUpdate":"Yes"
        ]
            
        Alamofire.request(gameRemindersURL, method: .post, parameters: parameters).responseJSON
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
        } else {
            let gameRemindersURL = "https://cgi.sice.indiana.edu/~team58/ModuserSetting.php"
            let defaultValues = UserDefaults.standard
            let myUser = defaultValues.string(forKey: "userID")!
            
            let parameters: Parameters=[
                "userID":myUser,
                "gameReminder":"No",
                "statUpdate":"Yes"
            ]
            
            Alamofire.request(gameRemindersURL, method: .post, parameters: parameters).responseJSON
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
            
        }
        
    }
    
    
    
    

    
    
    
    
    
    
    
    @IBOutlet weak var enterEmail: UITextField!
    
    
    @IBOutlet weak var oldPassword: UITextField!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    
//CHANGING THE PASSWORD
    @IBAction func changePsw(_ sender: Any) {
        
        let changePassURL = "https://cgi.sice.indiana.edu/~team58/changePW.php"
        
        let defaultValues = UserDefaults.standard
        let myUser = defaultValues.string(forKey: "userID")!
        
        let parameters: Parameters=[
            "userID":myUser,
            "email":enterEmail.text!,
            "oldPW":oldPassword.text!,
            "newPW":newPassword.text!,
            "confirmNewPW":confirmPassword.text!
        ]
        
        Alamofire.request(changePassURL, method: .post, parameters: parameters).responseJSON
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
 
    
}
