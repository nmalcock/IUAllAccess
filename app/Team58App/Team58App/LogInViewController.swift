//
//  LogInViewController.swift
//  Team58App
//
//  Created by Becky Poplawski on 2/4/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit
import GoogleSignIn
import Alamofire


class LogInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    

    
    @IBOutlet weak var btnGoogleSignIn: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnGoogleSignIn.addTarget(self, action: #selector(signinUserUsingGoogle(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
        if defaultValues.string(forKey: "username") != nil{
            let homeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenViewcontroller") as! homeScreenViewController
            self.navigationController?.pushViewController(homeScreenViewController, animated: true)
            
        }
    }
    
    @objc func signinUserUsingGoogle(_ sender: UIButton) {
        if btnGoogleSignIn.title(for: .normal) == "Sign out" {
            GIDSignIn.sharedInstance()?.signOut()
            lblTitle.text = ""
        } else {
            GIDSignIn.sharedInstance()?.delegate = self
            GIDSignIn.sharedInstance()?.uiDelegate = self
            GIDSignIn.sharedInstance()?.signIn()
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("We have error signing in user == \(error.localizedDescription)")
        }
        /*else {
            if let gmailUser = user {
                lblTitle.text = "You are signed in using id \(gmailUser.profile.email)"
                btnGoogleSignIn.setTitle("Sign Out", for: .normal)
            }
        }*/
    }
    
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "http://cgi.sice.indiana.edu/~team58/login.php"
    
    let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var ResponseLabel: UILabel!
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        
        let parameters: Parameters=[
            "email":textFieldEmail.text!,
            "password":textFieldPassword.text!
        ]
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseString
            {
                response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")
                //self.ResponseLabel.text = "Result: \(response.result)"
                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary

                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){

                        
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary

                        //getting user values - not neccesary
                        let userId = user.value(forKey: "id") as! Int
                        let userEmail = user.value(forKey: "email") as! String
                        let userPassword = user.value(forKey: "password") as! String

                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userEmail, forKey: "useremail")
                        self.defaultValues.set(userPassword, forKey: "userpassword")
                        
                        //switching the screen
                        let homeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenViewController") as! homeScreenViewController
                        self.navigationController?.pushViewController(homeScreenViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        //print("Request: \(String(describing: response.request))")   // original url request
                        //print("Response: \(String(describing: response.response))") // http url response
                        //print("Result: \(response.result)")
                        self.ResponseLabel.text = "Invalid Email or Password"
                    }
                }
        }
    }
}

//****other code, dont delete 

/*if  textFieldEmail.text!.isEmpty || textFieldPassword.text!.isEmpty {
 
 } else {
 
 // remove keyboard
 self.view.endEditing(true)
 
 // url to php file
 let url = URL(string: "http://cgi.sice.indiana.edu/~team58/login.php")!
 
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
 */
