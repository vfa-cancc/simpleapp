//
//  GoogleAdMobHelper.swift
//  Demo_Chat
//
//  Created by HungNV on 7/30/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit
import Firebase

struct GoogleAdsUnitID {
    struct Test {
        static var strBannerAdsID = "ca-app-pub-8391716737248301/3412485571"
        static var strInterstitialAdsID = "ca-app-pub-8391716737248301/7160158892"
    }
    
    struct Live {
        static var strBannerAdsID = "ca-app-pub-8391716737248301/3412485571"
        static var strInterstitialAdsID = "ca-app-pub-8391716737248301/7160158892"
    }
}

struct BannerViewSize {
    static var screenWidth: CGFloat = UIScreen.main.bounds.size.width
    static var screenHeight: CGFloat = 64
    static var height: CGFloat = CGFloat(UIDevice.current.userInterfaceIdiom == .pad ? 90 : 50)
}

protocol GoogleAdMobHelperDelegate: class {
    func didFinishedLoadAd(isDisplay: Bool)
}

class GoogleAdMobHelper: NSObject, GADInterstitialDelegate, GADBannerViewDelegate {
    static let shared: GoogleAdMobHelper = {
        let instance = GoogleAdMobHelper()
        return instance
    }()
    
    var isBannerViewDisplay = false
    private var isInitializeBannerView = false
    private var isInitializeInterstitial = false
    private var isBannerLiveID = false
    private var isInterstitialLiveID = false
    private var interstitialAds: GADInterstitial!
    private var bannerView: GADBannerView!
    weak var delegate: GoogleAdMobHelperDelegate?
    
    func initializeBannerView(isLiveUnitID: Bool) {
        self.isInitializeBannerView = true
        self.isBannerLiveID = isLiveUnitID
        self.createBannerView()
    }
    
    @objc private func createBannerView() {
        if UIApplication.shared.keyWindow?.rootViewController == nil {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(createBannerView), object: nil)
            self.perform(#selector(createBannerView), with: nil, afterDelay: 0.5)
        } else {
            bannerView = GADBannerView(frame: CGRect(x: 0, y: -(BannerViewSize.screenHeight), width: BannerViewSize.screenWidth, height: BannerViewSize.height))
            if self.isBannerLiveID == false {
                self.bannerView.adUnitID = GoogleAdsUnitID.Test.strBannerAdsID
            } else {
                self.bannerView.adUnitID = GoogleAdsUnitID.Live.strBannerAdsID
            }
            
            self.bannerView.rootViewController = UIApplication.shared.keyWindow?.rootViewController
            self.bannerView.delegate = self
            self.bannerView.backgroundColor = .clear
            self.bannerView.load(GADRequest())
            UIApplication.shared.keyWindow?.addSubview(bannerView)
        }
    }
    
    //MARK:- Show/Hide banner view
    func showBannerView() {
        if isInitializeBannerView == false {
            #if DEBUG
                print("First initalize banner view")
            #endif
        } else {
            #if DEBUG
                print("isBannerViewCreate: true")
            #endif
            self.bannerView.isHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                self.bannerView.frame = CGRect(x: 0, y: BannerViewSize.screenHeight, width: BannerViewSize.screenWidth, height: BannerViewSize.height)
            }, completion: { (isOK) in
                self.bannerView.isHidden = false
            })
        }
    }
    
    func hideBannerView() {
        if self.bannerView != nil {
            self.bannerView.isHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                self.bannerView.frame = CGRect(x: 0, y: -(BannerViewSize.screenHeight), width: BannerViewSize.screenWidth, height: BannerViewSize.height)
            }, completion: { (isOK) in
                self.bannerView.isHidden = false
            })
        }
    }
    
    private func showBanner() {
        if self.bannerView != nil && isBannerViewDisplay == true {
            self.bannerView.isHidden = false
        }
    }
    
    private func hideBanner() {
        if self.bannerView != nil {
            self.bannerView.isHidden = true
        }
    }
    
    //MARK:- Create Interstitial Ads
    func initializeInterstitial(isLiveUnitID: Bool) {
        self.isInitializeInterstitial = true
        self.isInterstitialLiveID = isLiveUnitID
        self.createInterstitial()
    }
    
    private func createInterstitial() {
        if self.isInterstitialLiveID == false {
            interstitialAds = GADInterstitial(adUnitID: GoogleAdsUnitID.Test.strInterstitialAdsID)
        } else {
            interstitialAds = GADInterstitial(adUnitID: GoogleAdsUnitID.Live.strInterstitialAdsID)
        }
        
        interstitialAds.delegate = self
        interstitialAds.load(GADRequest())
    }
    
    func showInterstitial() {
        if isInitializeInterstitial == false {
            #if DEBUG
                print("First initalize interstitial")
            #endif
        } else {
            if interstitialAds.isReady {
                interstitialAds.present(fromRootViewController: (UIApplication.shared.keyWindow?.rootViewController)!)
            } else {
                #if DEBUG
                    print("Interstitial not ready")
                #endif
                self.createInterstitial()
            }
        }
    }
    
    //MARK:- GADBannerViewDelegate
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        #if DEBUG
            print("adViewDidReceiveAd")
        #endif
        isBannerViewDisplay = true
        self.delegate?.didFinishedLoadAd(isDisplay: true)
        AnalyticsHelper.shared.sendFirebaseAnalytic(event: AnalyticsEventSelectContent, category: "adMob", action: "banner_view", label: "view")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        isBannerViewDisplay = false
        self.delegate?.didFinishedLoadAd(isDisplay: false)
    }
    
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        #if DEBUG
            print("adViewDidDismissScreen")
        #endif
    }
    
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        #if DEBUG
            print("adViewWillDismissScreen")
        #endif
    }
    
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        #if DEBUG
            print("adViewWillPresentScreen")
        #endif
    }
    
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        #if DEBUG
            print("adViewWillLeaveApplication")
        #endif
        AnalyticsHelper.shared.sendFirebaseAnalytic(event: AnalyticsEventSelectContent, category: "adMob", action: "banner_view", label: "click")
    }
    
    //MARK:- GADInterstitialDelegate
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        #if DEBUG
            print("interstitialDidReceiveAd")
        #endif
        AnalyticsHelper.shared.sendFirebaseAnalytic(event: AnalyticsEventSelectContent, category: "adMob", action: "interstitial", label: "view")
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        #if DEBUG
            print("interstitialDidDismissScreen")
        #endif
        self.createInterstitial()
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        #if DEBUG
            print("interstitialWillDismissScreen")
        #endif
        
        //self.showBannerView()
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        #if DEBUG
            print("interstitialWillPresentScreen")
        #endif
        //self.hideBannerView()
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        #if DEBUG
            print("interstitialWillLeaveApplication")
        #endif
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        #if DEBUG
            print("interstitialDidFail")
        #endif
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        #if DEBUG
            print("interstitial")
        #endif
    }
}
