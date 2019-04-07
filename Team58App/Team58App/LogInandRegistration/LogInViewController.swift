//
//  LogInViewController.swift
//  Team58App
//
//  Created by Becky Poplawski on 3/26/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//
import UIKit
import Alamofire
import GoogleSignIn
import SwiftyJSON



class LogInViewController: UIViewController,GIDSignInUIDelegate, GIDSignInDelegate {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnGoogleSignIn:UIButton!
    
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "http://cgi.sice.indiana.edu/~team58/login.php"
    
    let defaultValues = UserDefaults.standard
    
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Google Sign in////
        btnGoogleSignIn.addTarget(self, action: #selector(signinUserUsingGoogle(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    @objc func signinUserUsingGoogle(_ sender: UIButton) {
        if btnGoogleSignIn.title(for: .normal) == "Sign Out" {
            GIDSignIn.sharedInstance().signOut()
            lblTitle.text = ""
            btnGoogleSignIn.setTitle("Sign in Google", for: .normal)
        } else {
            
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().signIn()
            
            
            
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("We have error signing in user == \(error.localizedDescription)")
        } else {
            performSegue(withIdentifier: "popOutNoteExpanded", sender: self)
            if let gmailUser = user {
                lblTitle.text = "You are signed in using id \(gmailUser.profile.email)"
                btnGoogleSignIn.setTitle("Sign Out", for: .normal)
                
                /// end google sign in ///
            }
        }
    }
    
    
    
    
    @IBAction func LoginButton(_ sender: UIButton) {
        let parameters: Parameters=[
            "email":textFieldEmail.text!,
            "password":textFieldPassword.text!,
        ]
        
        //making a post request
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    
                    //if there is no error
                    if let jsonData = result as? NSDictionary {
                        
                        //getting the user from response
                        let user = jsonData
                        //print(user)
                        //getting user values
                        let userID = user.value(forKey: "userID") as! Int
                        print(userID)
                        //saving user values to defaults
                        self.defaultValues.set(user, forKey: "userID")
                        //print(jsonData[2])

                        
                        //switching the screen
                        //let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
                        //self.navigationController?.pushViewController(profileViewController, animated: true)
                        
                        //self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        //self.labelMessage.text = "Invalid username or password"
                    }
                }
        
                    self.performSegue(withIdentifier: "homeScreenViewController", sender: nil)
                    
                    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                        let DestViewController : homeScreenViewController = segue.destination as! homeScreenViewController
                        //DestViewController.user = user
                        //DestViewController.label.text = self.textFieldEmail.text!
                        //print(DestViewController.label.text!)
                    }
        }
    }
}
