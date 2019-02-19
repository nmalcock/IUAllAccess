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
    //let URL_USER_LOGIN = "http://cgi.sice.indiana.edu/~team58/login.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    
    
    @IBAction func buttonLogin(_ sender: UIButton) {

        // if no text entered
        if textFieldEmail.text!.isEmpty || textFieldPassword.text!.isEmpty {
            
            // text is entered
        } else {
            
            
            // remove keyboard
            self.view.endEditing(true)
            
            // shortcuts
           // let email = textFieldEmail.text!.lowercased()
           // let password = textFieldPassword.text!
            
            // send request to mysql db
            // url to access our php file
            let url = URL(string: "http://cgi.sice.indiana.edu/~team58/login.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "email=\(textFieldEmail.text!)&password=\(textFieldPassword.text!)"
            
            // append body to our request that gonna be sent
            request.httpBody = body.data(using: .utf8)
            
            // launch session
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    
                    
                    do {
                        // get json result
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        // assign json to new var parseJSON in guard/secured way
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            return
                        }
                        
                        // get id from parseJSON dictionary
                        let ID = parseJSON["ID"] as? String
                        
                        // successfully registered
                        if ID != nil {
                            // save user information we received from our host
                            UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                            user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                            let message = parseJSON["message"] as! String
                            print(message)
                        }
                        
                        
                        print(json!)
                        
                        
                        
                    } catch {
                        print(error)
                        
                    }
                    
                }
                
                // launch prepared session
                }.resume()
            
        }
        
        
    }
}
//yeet

