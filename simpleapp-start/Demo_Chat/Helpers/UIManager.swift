//
//  UIManager.swift
//  Demo_Chat
//
//  Created by Nguyen Van Hung on 2/5/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import Foundation

class UIManager: NSObject {
    static let shared = UIManager()
    var swRevealVC: SWRevealViewController? = nil
    
    var mainStoryBoard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func vcToSetFirst() -> UIViewController {
        guard let user = Helper.shared.getUserDefault(key: kUserInfo) else {
            let loginVC  = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            return loginVC
        }
        
        print(user)
        
        let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        
        let leftMenuVC = mainStoryBoard.instantiateViewController(withIdentifier: "LeftMenuVC") as! LeftMenuViewController
        let rightMenuVC = mainStoryBoard.instantiateViewController(withIdentifier: "RightMenuVC") as! RightMenuViewController
        
        let frontNaviVC = UINavigationController(rootViewController: homeVC)
        
        let rootVC = SWRevealViewController(rearViewController: leftMenuVC, frontViewController: frontNaviVC)
        
        rootVC?.rightViewController = rightMenuVC
        self.swRevealVC = rootVC
        
        return rootVC!
    }
    
    
    
    //MARK:- Screen size
    static func screenHeight() -> CGFloat {
        let screenSize: CGRect = UIScreen.main.bounds
        
        return screenSize.height
    }
    
    static func screenWidth() -> CGFloat {
        let screenSize: CGRect = UIScreen.main.bounds
        
        return screenSize.width
    }
    
    static func topSafeArea() -> CGFloat {
        var topPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        return topPadding
    }
    
    static func bottomSafeArea() -> CGFloat {
        var bottomPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPadding = window?.safeAreaInsets.bottom ?? 0
        }
        return bottomPadding
    }
    
    func popAllViewControllerAndShowLoginViewController() {
        let loginVC  = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        
        let navigationController:UINavigationController = UINavigationController(rootViewController: loginVC);
        navigationController.isNavigationBarHidden = true
        
        appDelegate.window!.rootViewController = navigationController
        appDelegate.window!.makeKeyAndVisible()
    }
    
    func moveToMessageController(room_chat: String) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            let navigationController = self.appDelegate.window?.rootViewController?.navigationController
//            let messageVC = self.mainStoryBoard.instantiateViewController(withIdentifier: "MessageVC") as! MessageViewController
//            messageVC.conversationKey = room_chat
//            navigationController?.pushViewController(messageVC, animated: true)
//        }
    }
}

extension UIManager: SWRevealViewControllerDelegate {
    func revealController(_ revealController: SWRevealViewController!, animationControllerFor operation: SWRevealControllerOperation, from fromVC: UIViewController!, to toVC: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        return nil
    }
}
