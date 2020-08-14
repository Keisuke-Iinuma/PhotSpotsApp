//
//  AppDelegate.swift
//  PhotSpotsApp
//
//  Created by 飯沼圭哉 on 2020/08/08.
//  Copyright © 2020 keisuke.iinuma. All rights reserved.
//

import UIKit
import Firebase    // 追加

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /*override init() {
            super.init()
            FirebaseApp.configure()
       }*/
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()    // 追加
        sleep(2);// <<<<<<<<<<<< 追加
        return true
    }

}

