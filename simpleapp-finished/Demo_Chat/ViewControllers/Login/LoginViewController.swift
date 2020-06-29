//
//  LoginViewController.swift
//  Demo_Chat
//
//  Created by Nguyen Van Hung on 2/12/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit
import Firebase
import EZAlertController
import FBSDKCoreKit
import FBSDKLoginKit
import TwitterKit
import NCMB

class LoginViewController: BaseViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnRequestAccess: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnApple: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTerm: UILabel!
    
    var gesture: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AnalyticsHelper.shared.setFirebaseAnalytic(screenName: "login_screen", screenClass: classForCoder.description())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupView() {
        setAttributedForTextField(txt: txtEmail, placeholder: NSLocalizedString("h_email", ""), font: Theme.shared.font_primaryRegular(size: .small), delegate: self)
        setAttributedForTextField(txt: txtPassword, placeholder: NSLocalizedString("h_password", ""), font: Theme.shared.font_primaryRegular(size: .small), delegate: self)
        
        setBorderButton(btn: btnFacebook, isCircle: false)
        setBorderButton(btn: btnTwitter, isCircle: false)
        setBorderButton(btn: btnApple, isCircle: false)
        setBorderButton(btn: btnLogin, isCircle: false)
        setBorderImageView(imgView: imgLogo, isCircle: false)
        
        setButtonFontBold(btn: btnForgot, size: .small)
        setButtonFontBold(btn: btnRequestAccess, size: .small)
        setButtonFontBold(btn: btnFacebook, size: .small)
        setButtonFontBold(btn: btnTwitter, size: .small)
        setButtonFontBold(btn: btnLogin, size: .medium)
        btnForgot.setTitle(NSLocalizedString("h_forgot_password", ""), for: .normal)
        btnRequestAccess.setTitle(NSLocalizedString("h_request_accesss", ""), for: .normal)
        btnLogin.setTitle(NSLocalizedString("h_lets_go", ""), for: .normal)
        lblTerm.text = NSLocalizedString("h_term_lbl", "")
    }
    
    func setupGesture() {
        gesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedScreen))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        gesture.isEnabled = false
    }
    
    @objc func tappedScreen() {
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        gesture.isEnabled = false
    }
    
    @IBAction func actForgotPassword(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordViewController {
            appDelegate.window?.rootViewController!.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func actRequestAccess(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "registerVC") as? RegistUserViewController {
            appDelegate.window?.rootViewController!.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func actFacebookLogin(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if let error = error {
                EZAlertController.alert(kAppName, message: error.localizedDescription)
            } else if result!.isCancelled {
                #if DEBUG
                    print("FBLogin cancelled")
                #endif
            } else {
                self.startLoading()
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseLogin(credential: credential, provider: "Facebook")
            }
        }
        
        AnalyticsHelper.shared.sendFirebaseAnalytic(event: AnalyticsEventSelectContent, category: "user", action: "login", label: "facebook")
    }
    
    @IBAction func actAppleLogin(_ sender: Any) {
        
    }
    
    @IBAction func actTwitterLogin(_ sender: Any) {
        return
        
        Twitter.sharedInstance().logIn(with: self) { (session, error) in
            if let error = error {
                EZAlertController.alert(kAppName, message: error.localizedDescription)
                return
            }
            
            guard let token = session?.authToken else { return }
            guard let secret = session?.authTokenSecret else { return }
            
            self.startLoading()
            let credential = TwitterAuthProvider.credential(withToken: token, secret: secret)
            self.firebaseLogin(credential: credential, provider: "Twitter")
        }
        
        AnalyticsHelper.shared.sendFirebaseAnalytic(event: AnalyticsEventSelectContent, category: "user", action: "login", label: "twitter")
    }
    
    func firebaseLogin(credential: AuthCredential, provider: String) {
        Auth.auth().signInAndRetrieveData(with: credential, completion: { (data, error) in
            if let error = error {
                self.stopLoading()
                EZAlertController.alert(kAppName, message: error.localizedDescription)
            } else {
                if provider == "Facebook" {
                    if let email = data?.user.email {
                        Helper.shared.saveUserDefault(key: kUserInfo, value: ["user_id": data?.user.uid ?? "", "email": email, "pass": ""])
                        
                        let currInstallation: NCMBInstallation = NCMBInstallation.current()
                        self.appDelegate.handleInstallation(currInstallation: currInstallation)
                        
                        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(large)"])
                        let _ = request?.start(completionHandler: { (connection, result, error) in
                            guard let userInfo = result as? [String: Any] else { return }
                            guard let name = userInfo["name"] as? String else { return }
                            guard let url = ((userInfo["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String else { return }
                            self.addUserToDatabase(user: data!.user, provider: provider, displayName: name, email: email, imgURLStr: url)
                        })
                    }
                } else if provider == "Twitter" {
                    var displayName = ""
                    var email = ""
                    var url = ""
                    
                    if let displayNameStr = data?.user.displayName {
                        displayName = displayNameStr
                        Helper.shared.saveUserDefault(key: kUserInfo, value: ["user_id": data?.user.uid ?? "", "email": displayName, "pass": ""])
                        
                        let currInstallation: NCMBInstallation = NCMBInstallation.current()
                        self.appDelegate.handleInstallation(currInstallation: currInstallation)
                    }
                    if let emailStr = data?.user.email {
                        email = emailStr
                        Helper.shared.saveUserDefault(key: kUserInfo, value: ["user_id": data?.user.uid ?? "", "email": email, "pass": ""])
                    
                        let currInstallation: NCMBInstallation = NCMBInstallation.current()
                        self.appDelegate.handleInstallation(currInstallation: currInstallation)
                    }
                    if let photoURL = data?.user.photoURL {
                        url = photoURL.absoluteString
                    }
                    
                    self.addUserToDatabase(user: data!.user, provider: provider, displayName: displayName, email: email, imgURLStr: url)
                } else {
                    self.stopLoading()
                }
            }
        })
    }
    
    func addUserToDatabase(user: User, provider: String, displayName: String, email: String, imgURLStr: String) {
        let time_interval = "\(NSDate().timeIntervalSince1970)"
        let userInfo: [String:Any] = [
            "display_name": displayName,
            "email": email,
            "avatar": imgURLStr,
            "time_interval": time_interval,
            "provider": provider,
            "status": "",
            "login_date": time_interval,
            "is_online": "Available"
        ]
        self.addUserInfo(user: user, userInfo: userInfo, isDismiss: false)
    }
    
    @IBAction func actLogin(_ sender: Any) {
        self.startLoading()
        let (isOK, message) = self.isValidInput()
        if isOK == false {
            EZAlertController.alert(kAppName, message: message)
            self.stopLoading()
            return;
        }
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!, completion: { (data, error) in
            if let error = error {
                self.stopLoading()
                EZAlertController.alert(kAppName, message: error.localizedDescription)
            }
            
            if let data = data {
                Helper.shared.saveUserDefault(key: kUserInfo, value: ["user_id": data.user.uid, "email": self.txtEmail.text ?? "", "pass": self.txtPassword.text ?? ""])
                
                let currInstallation: NCMBInstallation = NCMBInstallation.current()
                self.appDelegate.handleInstallation(currInstallation: currInstallation)
                
                self.stopLoading()
                self.redirectToHomeVC()
            }
        })
        
        AnalyticsHelper.shared.sendFirebaseAnalytic(event: AnalyticsEventSelectContent, category: "user", action: "login", label: "touch")
    }
    
    func isValidInput() -> (Bool, String) {
        let errNotInfo = NSLocalizedString("h_sms_full_info", "")
        let errWrongEmailFormat = NSLocalizedString("h_sms_right_email", "")
        
        guard let email = txtEmail.text else { return (false, errNotInfo) }
        
        guard let pass = txtPassword.text else { return (false, errNotInfo) }
        
        if (email == "" || pass == "") {
            return (false, errNotInfo)
        }
        
        if !Helper.shared.isValidEmail(email: email) {
            return (false, errWrongEmailFormat)
        }
        
        return (true, "")
    }
    
    @IBAction func actTerm(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermVC") as? TermViewController {
            appDelegate.window?.rootViewController!.present(vc, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        gesture.isEnabled = true
        
        switch textField {
        case self.txtEmail:
            AnalyticsHelper.shared.sendFirebaseAnalytic(event: AnalyticsEventSelectContent, category: "user", action: "login", label: "input_email")
            break
            
        default:
            AnalyticsHelper.shared.sendFirebaseAnalytic(event: AnalyticsEventSelectContent, category: "user", action: "login", label: "input_password")
            break
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}
