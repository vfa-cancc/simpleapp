//
//  AnalyticsHelper.swift
//  Demo_Chat
//
//  Created by HungNV on 7/18/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit
import Firebase

class AnalyticsHelper: NSObject {
    static let shared = AnalyticsHelper()
    
    //MARK:- Firebase analytic
    func setFirebaseAnalytic(screenName: String, screenClass: String) {
        Analytics.setScreenName(screenName, screenClass: screenClass)
    }
    
    func sendFirebaseAnalytic(event: String, category: String, action: String, label: String) {
        Analytics.logEvent(event, parameters: [
            "Category": category as NSObject,
            "Action": action as NSObject,
            "Label": label as NSObject
            ])
    }
}
