//
//  AppDelegate.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 6/21/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var rootAssembly = RootAssembly()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootAssembly.presentationAssembly.getRootViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

