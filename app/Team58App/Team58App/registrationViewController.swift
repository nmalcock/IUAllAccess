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

    let URL_USER_REGISTER = "http://cgi.sice.indiana.edu/~team58/createuser.php"

    
    //View variables

    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var labelMessage: UILabel!
    
    //Button action
    @IBAction func buttonRegister(sender: AnyObject) {
        

        //creating parameters for the post request
        let parameters: Parameters=[
            "email":textFieldEmail.text!,
            "password":textFieldPassword.text!
        ]

        //created NSURL
        let requestURL = URL(string: URL_USER_REGISTER)

        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL!)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values
        let email=textFieldEmail.text
        let password=textFieldPassword.text
        
        
        let postParameters = "email="+email!+"password="+password!;
        
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
        
    }

        //Sending http post request

        //**NOTE: NSDICTIONARIES ARE OUTDATED PACKAGES.
        //I changed ".responseJSON to .responseString
        //look for newer packages to replace. the rest of the NSDict.
    
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseString
            {

    /*Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON {

                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary

                    let JSONData = result as! NSDictionary
                    
                    //displaying the message in label
                    self.labelMessage.text = JSONData.value(forKey: "message") as! String?
                }

        }
    
        
        
    }

                    let jsonData = result as! NSDictionary
                    
                    //displaying the message in label
                    //self.labelMessage.text = jsonData.value(forKey: "message") as! String? */


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    



}

