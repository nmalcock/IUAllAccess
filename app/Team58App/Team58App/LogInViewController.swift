//
//  LogInViewController.swift
//  Team58App
//
//  Created by Becky Poplawski on 2/4/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit
import Alamofire
import GoogleSignIn



class LogInViewController: UIViewController,GIDSignInUIDelegate, GIDSignInDelegate {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnGoogleSignIn:UIButton!
    
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "http://cgi.sice.indiana.edu/~team58/login.php"
    
    let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    
    
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
                
                if let result = response.result.value {
                    
                    let jsonData = result as! NSDictionary
                    
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                        
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        /*//getting user values - not neccesary
                         let userId = user.value(forKey: "id") as! Int
                         let userEmail = user.value(forKey: "email") as! String
                         let userPassword = user.value(forKey: "password") as! String
                         
                         
                         //saving user values to defaults
                         self.defaultValues.set(userId, forKey: "userid")
                         self.defaultValues.set(userEmail, forKey: "useremail")
                         self.defaultValues.set(userPassword, forKey: "userpassword")*/
                        
                        //switching the screen
                        let homeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenViewController") as! homeScreenViewController
                        self.navigationController?.pushViewController(homeScreenViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        print("Request: \(String(describing: response.request))")   // original url request
                        print("Response: \(String(describing: response.response))") // http url response
                        print("Result: \(response.result)")
                    }
                }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Google Sign in////
        btnGoogleSignIn.addTarget(self, action: #selector(signinUserUsingGoogle(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
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
        } else {
            if let gmailUser = user {
                lblTitle.text = "You are signed in using id \(gmailUser.profile.email)"
                btnGoogleSignIn.setTitle("Sign Out", for: .normal)
                
                /// end google sign in ///
                
                // Do any additional setup after loading the view, typically from a nib.
                
                //if user is already logged in switching to profile screen
                if defaultValues.string(forKey: "email") != nil{
                    let homeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeScreenViewController") as! homeScreenViewController
                    self.navigationController?.pushViewController(homeScreenViewController, animated: true)
                    
                }
                
            }
        }
    }
}

