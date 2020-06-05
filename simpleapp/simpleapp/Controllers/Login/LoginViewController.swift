//
//  LoginViewController.swift
//  simpleapp
//
//  Created by HungNV on 5/31/20.
//  Copyright © 2020 VITALIFY ASIA. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- Action methods
    @IBAction func requestAccessTapped(_ sender: Any) {
        let vc = RegistUserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        AppRouter.shared.openHome()
    }
    
    @IBAction func fogotPasswordTapped(_ sender: Any) {
        let vc = RegistUserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func facebookTapped(_ sender: Any) {
        let vc = RegistUserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func twitterTapped(_ sender: Any) {
        let vc = RegistUserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func termTapped(_ sender: Any) {
        
    }
}
