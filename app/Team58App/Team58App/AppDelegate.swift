//
//  AppDelegate.swift
//  Team58App
//
//  Created by Becky Poplawski on 1/23/19.
//  Copyright © 2019 rpoplaws. All rights reserved.
//

import UIKit
import Alamofire

let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate


// stores all information about current user
var user : NSDictionary?


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
   // @objc var infoViewIsShowing = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
        // Override point for customization after application launch.

        
        // load content in user var
       // user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
        
        // if user is once logged in / register, keep him logged in
/*        if user != nil {
            
            let userID = user!["userID"] as? String
            if userID != nil {
                login()
            }
            
        }
        
        
        return true
    }*/
    

    // func to pass to home page ro to tabBar
   /* @objc func login() {
        
        // refer to our Main.storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // store our tabBar Object from Main.storyboard in tabBar var
        let taBar = storyboard.instantiateViewController(withIdentifier: "tabBar")
        
        // present tabBar that is storing in tabBar var
        window?.rootViewController = taBar
        
    }*/
 
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
