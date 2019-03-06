//
//  registrationViewController.swift
//  Team58App
//
//  Created by Becky Poplawski on 1/28/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit




class registrationViewController: UIViewController {

    //Defined a constant that holds the URL for our web service
//ORIGINAL V
   //let URL_USER_REGISTER = "http://cgi.sice.indiana.edu/~team58/createuser.php"

    
    //let defaultValues = UserDefaults.standard

    //View variables

    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!




    
    
    //Button action
    @IBAction func buttonRegister(_ Sender: UIButton) {
        
        if  textFieldEmail.text!.isEmpty || textFieldPassword.text!.isEmpty {
            
        } else {
            
            // remove keyboard
            self.view.endEditing(true)
            
            // url to php file
            let url = URL(string: "http://cgi.sice.indiana.edu/~team58/createuser.php")!
            
            // request to this file
            var request = URLRequest(url: url)
            
            // method to pass data to this file (e.g. via POST)
            request.httpMethod = "POST"
            
            // body to be appended to url
            let body = "email=\(textFieldEmail.text!)&password=\(textFieldPassword.text!)"
            
            request.httpBody = body.data(using: .utf8)
            
            // proceed request
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let response = response {
                    print(response)
                }
                
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
                            let userID = parseJSON["userID"]
                            
                            // successfully registered
                            if userID != nil {
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
