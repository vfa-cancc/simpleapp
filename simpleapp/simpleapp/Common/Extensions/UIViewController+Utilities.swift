//
//  UIViewController+Utilities.swift
//  simpleapp
//
//  Created by HungNV on 6/5/20.
//  Copyright © 2020 VITALIFY ASIA. All rights reserved.
//

import UIKit

protocol NibIdentifiable {
    static var nibNameIdentifier: String { get }
}

extension NibIdentifiable where Self: UIViewController {
    /// Name of nib
    static var nibNameIdentifier: String {
        return String(describing: self)
    }
    
    /// Get instance from xib
    ///
    /// - Returns: UIViewController instance
    static func instantiateFromXib() -> Self {
        
        let controller = Self(nibName:Self.nibNameIdentifier,bundle:nil)
        
        return controller
    }
    
}

extension UIViewController: NibIdentifiable {
    /// Get instance from storyboard
    ///
    /// - Parameter name: name of storyboard
    /// - Returns: UIViewController instance
    class func instantiateFromStoryboard(_ name: String = "Main") -> Self {
        return instantiateFromStoryboardHelper(name)
    }
    
    /// Get instance from storyboard
    ///
    /// - Parameter name: name of storyboard
    /// - Returns: UIViewController instance
    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
    
    /// Hide keyboard when tapped around on view controller
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    /// Dismiss keyboard
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
