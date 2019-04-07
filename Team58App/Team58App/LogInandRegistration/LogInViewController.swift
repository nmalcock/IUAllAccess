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



class LogInViewController: UIViewController,GIDSignInUIDelegate, GIDSignInDelegate {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnGoogleSignIn:UIButton!
    
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "http://cgi.sice.indiana.edu/~team58/login.php"
    
    //let defaultValues = UserDefaults.standard
    
    
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
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseString
            {
                response in

                
                //                print("Request: \(String(describing: response.request))")   // original url request
                //print("Response: \(String(describing: response))") // http url response
                print("Result: \(response.result)")
                print("hi")
                let s = response.result.value!
                let i = s.index(s.startIndex, offsetBy: 53)
                let b = s.index(s.startIndex, offsetBy: 54)
                print(s[i])
                print(s[b])
                var user = ""
                user.append(s[i])
                user.append(s[b])
                print(user)
                //let user2 = s
                //print(jsonResult[0]["userID"])
                
                ////////////this prints the userID v
                print(response.result.value!)
                

                /*
 
                result, which is a JSON array
                 if result["status"] == true {
                    then get the user id
                    userid = result['userID']
                 
                    create view controller
                    show it...
                 
                 
                 } else {
                 
 */


                
                //
                //                //self.ResponseLabel.text = "Result: \(response.result)"
                
                //                let result = response.result.value
                
                
                
                //if there is no error
                
                //                    if result["SUCCESS"] {
                //result, which is a JSON array
                    //if response.["status"] == true {
                    //then get the user id
                    //userid = result['userID']
                if response.result.value!.contains("true") {
                    
                    
                    
                    
                    //getting the user from response
                    //
                    //                        //getting user values - not neccesary
                    //                        if let userEmail = result["email"] {
                    //                            self.defaultValues.set(userEmail, forKey: "email")
                    //                        }
                    //                        if let userPassword = result["password"] {
                    //                            self.defaultValues.set(userPassword, forKey: "password")
                    //                        }
                    self.performSegue(withIdentifier: "homeScreenViewController", sender: nil)
                    
                    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                        let DestViewController : homeScreenViewController = segue.destination as! homeScreenViewController
                        DestViewController.user = user
                        //DestViewController.label.text = self.textFieldEmail.text!
                        //print(DestViewController.label.text!)
                    }
                    
                    
                    
                    
                    //
                } else  {
                    
                    self.createAlert(title: "", message: "invalid username or password")
                    
                    
                }
                
                
                
        }
    }
}
