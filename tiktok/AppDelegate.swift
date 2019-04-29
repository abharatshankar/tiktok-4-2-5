//
//  AppDelegate.swift
//  tiktok
//
//  Created by Bharat shankar on 18/02/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import CoreData
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import IQKeyboardManagerSwift
import GoogleSignIn
import TwitterKit



@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate  {
    fileprivate var player = Player()
   private let sdkManager: FBSDKLoginManager = FBSDKLoginManager()
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            print("user id:",userId ?? "no user id came")
            print("idToken :",idToken!)
            print("fullName :",fullName!)
            print("givenName :",givenName!)
            print("email id:",email!)
            
        }
    }
    
    
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        print("gmail sign in error came",error)
    }

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //IQKeyboardManager is third party for keyboard
        
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().alpha = 0.8
//
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage()
        
        //for fb
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // for keyboard manager
        IQKeyboardManager.shared.enable = true
        
        
        GIDSignIn.sharedInstance().clientID = "937093259306-msq430635a6783la18s7d8lpnhshbvid.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
//        UITabBar.appearance().barTintColor = UIColor.clear
//        UITabBar.appearance().backgroundImage = UIImage(named: "")
        
        TWTRTwitter.sharedInstance().start(withConsumerKey:"MIDSBP3T8kUwpR9iRN3FRjgUD", consumerSecret:"GeXGfKFNbyqGCHqiK08jpjyDGXj6R7FrsWFq3SlsUPqo5pcSf2")

        let myCheck = Bundle.main.object(forInfoDictionaryKey: "FacebookAppID") as? String
        print(myCheck!)
        
        return true
    }

    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let sendingAppID = options[.sourceApplication]
        print("sending app id",sendingAppID!)
        
        
        if TWTRTwitter.sharedInstance().application(app, open:url, options: options) {
            return true
        }
        
        if let _ = Bundle.main.object(forInfoDictionaryKey: "FacebookAppID") as? String {
            
            return  SDKApplicationDelegate.shared.application(app, open: url, options: options)
        }
        
        
        let isGoogleOpenUrl = GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        if isGoogleOpenUrl { return true }
        
//        //return GIDSignIn.sharedInstance().handle(url as URL?,
//                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
//                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return false
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        let googleSignIn = GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
        
        return  googleSignIn
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        player.stop()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
         player.stop()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "tiktok")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

