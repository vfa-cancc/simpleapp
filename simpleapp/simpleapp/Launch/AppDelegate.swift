//
//  AppDelegate.swift
//  simpleapp
//
//  Created by HungNV on 5/31/20.
//  Copyright © 2020 VITALIFY ASIA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Config root window
        self.configureWindow()
        return true
    }
    
    private func configureWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        AppRouter.shared.openLogin()
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
    }
}
