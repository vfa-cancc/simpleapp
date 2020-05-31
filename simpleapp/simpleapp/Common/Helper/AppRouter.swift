//
//  AppRouter.swift
//  simpleapp
//
//  Created by HungNV on 5/31/20.
//  Copyright © 2020 VITALIFY ASIA. All rights reserved.
//

import UIKit

class AppRouter {
    static let shared = AppRouter()
    
    var rootNavigation: UINavigationController?
    
    /// Navigation root is Login flow
    func openLogin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        AppRouter.shared.rootNavigation = nil
        let loginVC = LoginViewController()
        let navigation = UINavigationController(rootViewController: loginVC)
        windowApp.rootViewController = navigation
    }
    
    /// Navigation root is TabBar flow
    func openHome() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        let tabBar = MainTabbar()
        windowApp.rootViewController = tabBar
    }
}
