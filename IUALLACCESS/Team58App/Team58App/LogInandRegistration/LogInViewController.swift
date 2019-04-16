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



class LogInViewController: UIViewController,GIDSignInUIDelegate, GIDSignInDelegate, UITextFieldDelegate {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnGoogleSignIn:UIButton!
    @IBOutlet weak var Login: UIButton!
    
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
        self.textFieldEmail.delegate = self
        self.textFieldPassword.delegate = self
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
            //performSegue(withIdentifier: "homeScreenViewController", sender: self)
            if let gmailUser = user {
                lblTitle.text = "You are signed in as: \(gmailUser.profile.email!)"
                btnGoogleSignIn.setTitle("Sign Out", for: .normal)
                performSegue(withIdentifier: "homeScreenViewController", sender: self)
                /// end google sign in ///
            }
        }
    }
    
    
    
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        
        if self.Login.title(for: .normal) == "Log Out" {
            lblTitle.text = ""
            textFieldEmail.text = ""
            textFieldPassword.text = ""
            self.Login.setTitle("Log In", for: .normal)
        } else {
            
        let parameters: Parameters=[
            "email":textFieldEmail.text!,
            "password":textFieldPassword.text!,
        ]

        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response.result.value!)
                
                //getting the json value from the server
                if let result = response.result.value{
                    ///////////////////////////////////////
                    
                    
                  ///////////////////////////////////////////
                    //if(response.result.value.contains("true"){
                    let result = response.result.value
                    //if there is no error
                    let jsonData = result as? NSDictionary
                    
                    //getting the user from response
                    let user = jsonData
                    //print(user)
                    //getting user values
                    if let userID = user!.value(forKey: "userID") as? Int {
                        print("hi",userID)
                        
                        //saving user values to defaults
                        self.defaultValues.set(userID, forKey: "userID")
                        //////// THIS CALLS IT FROM APP DELEGATE:
                        let myuser = UserDefaults.standard.integer(forKey: "userID")
                        print("yo", myuser)
                        //print(jsonData[2])
                        self.lblTitle.text = "You are signed in as: \(self.textFieldEmail.text!)"

                        
                        self.performSegue(withIdentifier: "homeScreenViewController", sender: nil)
                        self.Login.setTitle("Log Out", for: .normal)
                        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                            let DestViewController : homeScreenViewController = segue.destination as! homeScreenViewController
                            DestViewController.email = self.textFieldEmail.text!
                            //                        DestViewController.label.text = self.textFieldEmail.text!
                            //                        print(DestViewController.label.text!)
                        }
                    
                }else{
                    //error message in case of invalid credential
                    self.createAlert(title: "", message: "Invalid username or password")
                }
                }
                
        }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
