//
//  AppDelegate.swift
//  Todoey
//
//  Created by Abrish Sabri on 9/9/19.
//  Copyright © 2019 Abrish Sabri. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //print("didFinishLaunchingWithOptions")
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
   
        
    
        
        do {
            _ = try Realm()
           
        }
        catch {
            print("Error initialising Realm \(error)")
        }
        
        return true
    }

  

}

