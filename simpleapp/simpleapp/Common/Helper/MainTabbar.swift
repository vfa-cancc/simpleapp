//
//  MainTabbar.swift
//  simpleapp
//
//  Created by HungNV on 5/31/20.
//  Copyright © 2020 VITALIFY ASIA. All rights reserved.
//

import UIKit

protocol TabbarProtocol: class {
    func tabbarSelected(index: Int)
}

let tabIconInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)

class MainTabbar: UITabBarController {
    
    weak var tabbarDelagate: TabbarProtocol?
    var listViewController = [UIViewController]()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.setUpTabbar()
    }
    
    /// Set up view tabbar
    func setUpTabbar() {
        /// Background color tabbar
        self.tabBar.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        let homeVC = HomeViewController()
        let movieVC = MovieViewController()
        homeVC.tabBarItem = setBarItem(title: NSLocalizedString("home_tab_bar_title", comment: ""), selectedImage: UIImage(named: "ic_home"), normalImage: UIImage(named: "ic_home"))
        movieVC.tabBarItem = setBarItem(title: NSLocalizedString("movie_tab_bar_title", comment: ""), selectedImage: UIImage(named: "ic_movie"), normalImage: UIImage(named: "ic_movie"))
        listViewController = [homeVC, movieVC]
        for controller in listViewController {
            controller.tabBarItem.imageInsets = tabIconInsets
        }
        addViewControllerToTabbar(listViewController: listViewController)
    }
    
    /// Add controller to listview
    func addViewControllerToTabbar(listViewController: [UIViewController]) {
        var listNavigationController = [UIViewController]()
        
        for (_, vc) in listViewController.enumerated() {
            let nc = UINavigationController(rootViewController: vc)
            listNavigationController.append(nc)
        }
        
        self.viewControllers = listNavigationController
    }
    
    /// Create tabbar icon
    func setBarItem(title: String? = nil, selectedImage: UIImage?, normalImage: UIImage?) -> UITabBarItem {
        let item = UITabBarItem(title: title, image: normalImage, selectedImage: selectedImage)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .selected)
        return item
    }
}

extension MainTabbar: UITabBarControllerDelegate {
    /// Event when click tabbar
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabbarDelagate?.tabbarSelected(index: tabBarController.selectedIndex)
    }
}

