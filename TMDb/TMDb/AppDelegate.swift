//
//  AppDelegate.swift
//  TMDb
//
//  Created by Symbat Bashkeyeva on 6/20/19.
//  Copyright © 2019 Symbat Bashkeyeva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let mainVC = MainTabBarController()
        window?.rootViewController = mainVC
        return true
    }
}
