//
//  BottomMenuView.swift
//  Demo_Chat
//
//  Created by Nguyen Van Hung on 2/6/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import Foundation
import SnapKit

protocol BottomMenuViewDelegate: class {
    func didSelectedBtnHome(_: BottomMenuView!)
    func didSelectedBtnGroup(_: BottomMenuView!)
    func didSelectedBtnCenter(_: BottomMenuView!)
    func didSelectedBtnNotification(_: BottomMenuView!)
    func didSelectedBtnSetting(_: BottomMenuView!)
    func didSelectedBtnContact(_: BottomMenuView!)
    func didSelectedBtnMap(_: BottomMenuView!)
    func didSelectedBtnMusic(_: BottomMenuView!)
    func didSelectedBtnMovie(_: BottomMenuView!)
    func didSelectedBtnCheckOut(_: BottomMenuView!)
}

let kHeightCenterButtonRatio = CGFloat(0.18)

class BottomMenuView: UIView {
    var itemsArr = [UIView]()
    var highlightViewArr = [UIView]()
    
    var currentIndex:Int = 0 {
        didSet {
            var index = 0
            for view in highlightViewArr {
                view.isHidden = (index != currentIndex)
                index += 1
            }
        }
    }
    
    weak var delegate: BottomMenuViewDelegate?
    lazy var viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    lazy var btnHome: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.tappedBtnHome(btn:)), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "tabbar_chat_off"), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "tabbar_chat_on"), for: .selected)
        btn.accessibilityIdentifier = "btnHomeBar"
        
        return btn
    }()
    
    lazy var btnGroup: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.tappedBtnGroup(btn:)), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "tabbar_group_off"), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "tabbar_group_on"), for: .selected)
        btn.accessibilityIdentifier = "btnGroupBar"
        
        return btn
    }()
    
    lazy var btnCenter: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.tappedBtnCenter(btn:)), for: .touchUpInside)
        let image = UIView.filledImage(from: #imageLiteral(resourceName: "icon_center"), with: Theme.shared.color_Dark_App())
        btn.setImage(image, for: .normal)
        btn.setImage(image, for: .highlighted)
        btn.accessibilityIdentifier = "btnCenterBar"
        
        return btn
    }()
    
    lazy var btnNotification: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.tappedBtnNotification(btn:)), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "tabbar_notification_off"), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "tabbar_notification_on"), for: .selected)
        btn.accessibilityIdentifier = "btnNotificationBar"
        
        return btn
    }()
    
    lazy var btnSetting: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.tappedBtnSetting(btn:)), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "tabbar_more_off"), for: .normal)
        btn.setImage(#imageLiteral(resourceName: "tabbar_more_on"), for: .selected)
        btn.accessibilityIdentifier = "btnSettingBar"
        
        return btn
    }()
    
    //MARK:- Sub button from center button
    lazy var viewBlueBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        return view
    }()
    
    lazy var imgViewEclipseBackground: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "eclipse_bg"))
        
        return img
    }()
    
    lazy var btnContact: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.tappedbtnContact(btn:)), for: .touchUpInside)
        let image = UIView.filledImage(from: #imageLiteral(resourceName: "icon_text"), with: Theme.shared.color_Dark_App())
        btn.setImage(image, for: .normal)
        btn.setImage(image, for: .highlighted)
        btn.accessibilityIdentifier = "btnContactBar"
        
        return btn
    }()
    
    lazy var btnMap: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.tappedBtnMap(btn:)), for: .touchUpInside)
        let image = UIView.filledImage(from: #imageLiteral(resourceName: "icon_text"), with: Theme.shared.color_Dark_App())
        btn.setImage(image, for: .normal)
        btn.setImage(image, for: .highlighted)
        btn.accessibilityIdentifier = "btnMapBar"
        
        return btn
    }()
    
    lazy var btnMusic: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.tappedBtnMusic(btn:)), for: .touchUpInside)
        let image = UIView.filledImage(from: #imageLiteral(resourceName: "icon_text"), with: Theme.shared.color_Dark_App())
        btn.setImage(image, for: .normal)
        btn.setImage(image, for: .highlighted)
        btn.accessibilityIdentifier = "btnMusicBar"
        
        return btn
    }()
    
    lazy var btnMovie: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.tappedBtnMovie(btn:)), for: .touchUpInside)
        let image = UIView.filledImage(from: #imageLiteral(resourceName: "icon_text"), with: Theme.shared.color_Dark_App())
        btn.setImage(image, for: .normal)
        btn.setImage(image, for: .highlighted)
        btn.accessibilityIdentifier = "btnMovieBar"
        
        return btn
    }()
    
    lazy var btnCheckOut: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.tappedBtnCheckOut(btn:)), for: .touchUpInside)
        let image = UIView.filledImage(from: #imageLiteral(resourceName: "icon_text"), with: Theme.shared.color_Dark_App())
        btn.setImage(image, for: .normal)
        btn.setImage(image, for: .highlighted)
        btn.accessibilityIdentifier = "btnCheckOutBar"
        
        return btn
    }()
    
    lazy var imgViewLogo: UIImageView = {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "icon_logo"))
        imgV.layer.cornerRadius = 30
        imgV.layer.borderWidth = 1.0
        imgV.layer.borderColor = UIColor.white.cgColor
        imgV.clipsToBounds = true
        
        return imgV
    }()
    
    lazy var imgViewIconContact: UIImageView = {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "iContact"))
        
        return imgV
    }()
    
    lazy var imgViewIconMap: UIImageView = {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "iMaker"))
        
        return imgV
    }()
    
    lazy var imgViewIconMusic: UIImageView = {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "iMusic"))
        
        return imgV
    }()
    
    lazy var imgViewIconMovie: UIImageView = {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "iMove"))
        
        return imgV
    }()
    
    lazy var imgViewIconCheckOut: UIImageView = {
        let imgV = UIImageView(image: #imageLiteral(resourceName: "iCalendar"))
        
        return imgV
    }()
    
    //MARK:- Gesture
    var isShowSubButton: Bool = false
    var gesture: UITapGestureRecognizer!
    
    func clearSelectButton() {
        btnHome.isSelected = false
        btnGroup.isSelected = false
        btnNotification.isSelected = false
        btnSetting.isSelected = false
    }
    
    //MARK:- Handle event
    @objc func tappedBtnHome(btn: UIButton) {
//        let url = URL(string: "http://static.new.tuoitre.vn/tto/i/s626/2017/06/01/nguyen-xuan-phuc-jpg-1496283435.jpg")
//        let str = url!.lastPathComponent
//        print(str)
        self.delegate?.didSelectedBtnHome(self)
    }
    
    @objc func tappedBtnGroup(btn: UIButton) {
        self.delegate?.didSelectedBtnGroup(self)
    }
    
    @objc func tappedBtnCenter(btn: UIButton) {
        if isShowSubButton {
            tappedScreen()
            return
        }
        isShowSubButton = true
        showSubButtons()
        gesture.isEnabled = true
        self.delegate?.didSelectedBtnCenter(self)
    }
    
    @objc func tappedBtnNotification(btn: UIButton) {
        self.delegate?.didSelectedBtnNotification(self)
    }
    
    @objc func tappedBtnSetting(btn: UIButton) {
        self.delegate?.didSelectedBtnSetting(self)
    }
    
    @objc func tappedbtnContact(btn: UIButton) {
        self.delegate?.didSelectedBtnContact(self)
        if isShowSubButton {
            tappedScreen()
            return
        }
    }
    
    @objc func tappedBtnMap(btn: UIButton) {
        self.delegate?.didSelectedBtnMap(self)
        if isShowSubButton {
            tappedScreen()
            return
        }
    }
    
    @objc func tappedBtnMusic(btn: UIButton) {
        self.delegate?.didSelectedBtnMusic(self)
        if isShowSubButton {
            tappedScreen()
            return
        }
    }
    
    @objc func tappedBtnMovie(btn: UIButton) {
        self.delegate?.didSelectedBtnMovie(self)
        if isShowSubButton {
            tappedScreen()
            return
        }
    }
    
    @objc func tappedBtnCheckOut(btn: UIButton) {
        self.delegate?.didSelectedBtnCheckOut(self)
        if isShowSubButton {
            tappedScreen()
            return
        }
    }
    
    //MARK:- View Setting
    convenience init(delegate: BottomMenuViewDelegate?) {
        self.init()
        self.delegate = delegate
        self.setupViewsAndLayout()
    }
    
    func setupViewsAndLayout() {
        self.addSubview(viewBackground)
        self.viewBackground.addSubview(btnHome)
        self.viewBackground.addSubview(btnGroup)
        self.viewBackground.addSubview(btnNotification)
        self.viewBackground.addSubview(btnSetting)
        
        self.addSubview(viewBlueBackground)
        self.addSubview(imgViewEclipseBackground)
        self.addSubview(btnContact)
        self.addSubview(btnMap)
        self.addSubview(btnMusic)
        self.addSubview(btnMovie)
        self.addSubview(btnCheckOut)
        self.addSubview(btnCenter)
        self.imgViewEclipseBackground.isHidden = true
        
        let items = [(btnContact, imgViewIconContact), (btnMap, imgViewIconMap), (btnMusic, imgViewIconMusic), (btnMovie, imgViewIconMovie), (btnCheckOut, imgViewIconCheckOut)]
        for (btn, img) in items {
            btn.addSubview(img)
            img.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
            })
            itemsArr.append(btn)
        }
        
        self.backgroundColor = UIColor.clear
        viewBlueBackground.isHidden = true
        setupGesture()
        
        btnCenter.layer.cornerRadius = kHeightCenterButtonRatio * UIManager.screenWidth() / 2
        btnCenter.layer.shadowOpacity = 1
        btnCenter.layer.shadowColor = Theme.shared.color_Dark_App().cgColor
        btnCenter.layer.shadowRadius = 15
        
        self.btnCenter.addSubview(imgViewLogo)
        imgViewLogo.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        
        self.btnCenter.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
            make.width.equalToSuperview().multipliedBy(kHeightCenterButtonRatio)
            make.height.equalTo(btnCenter.snp.width)
        }
        
        viewBlueBackground.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(UIManager.screenHeight())
        }
        
        viewBackground.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        let arr = [btnContact, btnMap, btnMusic, btnMovie, btnCheckOut];
        for btn in arr {
            btn.snp.makeConstraints({ (make) in
                make.centerX.equalTo(btnCenter)
                make.centerY.equalTo(btnCenter)
                make.width.equalTo(60)
                make.height.equalTo(btn.snp.width)
            })
        }
        
        let onePartWidth = ((1 - kHeightCenterButtonRatio)/8) * UIManager.screenWidth()
        self.btnHome.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-1)
            make.width.equalTo(55)
            make.height.equalToSuperview()
            make.centerX.equalTo(btnCenter.snp.leading).offset(-3*onePartWidth)
        }
        
        self.btnGroup.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-1)
            make.width.equalTo(55)
            make.height.equalToSuperview()
            make.centerX.equalTo(btnCenter.snp.leading).offset(-1.2*onePartWidth)
        }
        
        self.btnNotification.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-1)
            make.width.equalTo(55)
            make.height.equalToSuperview()
            make.centerX.equalTo(btnCenter.snp.trailing).offset(1.2*onePartWidth)
        }
        
        self.btnSetting.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-1)
            make.width.equalTo(55)
            make.height.equalToSuperview()
            make.centerX.equalTo(btnCenter.snp.trailing).offset(3*onePartWidth)
        }
        
        let arrButtons = [btnHome, btnGroup, btnNotification, btnSetting]
        for btn in arrButtons {
            let view = UIView()
            view.backgroundColor = Theme.shared.color_App()
            view.layer.cornerRadius = 2
            self.viewBackground.addSubview(view)
            highlightViewArr.append(view)
            view.snp.makeConstraints({ (make) in
                make.bottom.equalToSuperview()
                make.centerX.equalTo(btn)
                make.width.equalTo(btn.snp.width)
                make.height.equalTo(5)
            })
        }
        
        currentIndex = 0
        btnHome.isSelected = true
    }
    
    func setupGesture() {
        gesture = UITapGestureRecognizer(target: self, action: #selector(self.tappedScreen))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        gesture.isEnabled = false
    }
    
    @objc func tappedScreen() {
        hiddenSubButtons()
        isShowSubButton = false
        gesture.isEnabled = false
    }
    
    func showSubButtons() {
        viewBlueBackground.isHidden = false
        viewBlueBackground.alpha = 0
        
        self.imgViewEclipseBackground.isHidden = false
        self.imgViewEclipseBackground.center.x = self.btnCenter.center.x
        self.imgViewEclipseBackground.center.y = self.btnCenter.center.y - 20
        self.imgViewEclipseBackground.frame.size.width = 80*2
        
        UIView.animate(withDuration: 0.35, animations: {
            self.viewBlueBackground.alpha = 1
            let delta = 80
            
            switch self.itemsArr.count {
            case 3:
                self.itemsArr[0].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter)
                    make.centerX.equalTo(self.btnCenter).offset(-delta)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnContact.snp.width)
                })
                
                self.itemsArr[1].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter).offset(-delta)
                    make.centerX.equalTo(self.btnCenter)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnMap.snp.width)
                })
                
                self.itemsArr[2].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter)
                    make.centerX.equalTo(self.btnCenter).offset(delta)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnMusic.snp.width)
                })
                break
                
            case 4:
                self.itemsArr[0].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter)
                    make.centerX.equalTo(self.btnCenter).offset(-delta)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnContact.snp.width)
                })
                
                self.itemsArr[1].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter).offset(-60)
                    make.centerX.equalTo(self.btnCenter).offset(-delta/2)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnMap.snp.width)
                })
                
                self.itemsArr[2].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter).offset(-60)
                    make.centerX.equalTo(self.btnCenter).offset(delta/2)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnMusic.snp.width)
                })
                
                self.itemsArr[3].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter)
                    make.centerX.equalTo(self.btnCenter).offset(delta)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnMovie.snp.width)
                })
                break
                
            case 5:
                self.itemsArr[0].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter)
                    make.centerX.equalTo(self.btnCenter).offset(-delta)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnContact.snp.width)
                })
                
                self.itemsArr[1].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter).offset(-56.56)
                    make.centerX.equalTo(self.btnCenter).offset(-56.56)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnMap.snp.width)
                })
                
                self.itemsArr[2].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter).offset(-delta)
                    make.centerX.equalTo(self.btnCenter)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnMusic.snp.width)
                })
                
                self.itemsArr[3].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter).offset(-56.56)
                    make.centerX.equalTo(self.btnCenter).offset(56.56)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnMovie.snp.width)
                })
                
                self.itemsArr[4].snp.updateConstraints({ (make) in
                    make.centerY.equalTo(self.btnCenter)
                    make.centerX.equalTo(self.btnCenter).offset(delta)
                    make.width.equalTo(60)
                    make.height.equalTo(self.btnCheckOut.snp.width)
                })
                break
                
            default:
                break
            }
        }) { (finish) in
            
        }
    }
    
    func hiddenSubButtons() {
        self.imgViewEclipseBackground.isHidden = true
        viewBlueBackground.alpha = 1
        UIView.animate(withDuration: 0.35, animations: { 
            self.viewBlueBackground.alpha = 0
            let arr = [self.btnContact, self.btnMap, self.btnMusic, self.btnMovie, self.btnCheckOut];
            for btn in arr {
                btn.snp.updateConstraints({ (make) in
                    make.centerX.equalTo(self.btnCenter)
                    make.centerY.equalTo(self.btnCenter)
                    make.width.equalTo(60)
                    make.height.equalTo(btn.snp.width)
                })
            }
            self.layoutIfNeeded()
        }) { (finish) in
            self.viewBlueBackground.isHidden = true
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var height: CGFloat = 10
        if viewBlueBackground.isHidden == false {
            height = 160
        }
        let rect = CGRect(x: 0, y: -110, width: UIManager.screenWidth(), height: height)
        if rect.contains(point) {
            return true
        }
        return super.point(inside: point, with: event)
    }
}
