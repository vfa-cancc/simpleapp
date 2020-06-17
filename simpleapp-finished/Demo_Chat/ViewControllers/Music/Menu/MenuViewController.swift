//
//  MenuViewController.swift
//  TimeRecorder
//
//  Created by chau nguyen on 5/19/20.
//  Copyright © 2020 VFA. All rights reserved.
//

import UIKit

protocol MenuDelegate : class {
    func onClickEdit()
    func onClickDelete()
}

class MenuViewController: UIViewController {

    @IBOutlet weak var btnChangePassword: UIButton!
    weak var delegate : MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onPressEdit(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.onClickEdit()
        }
    }
    @IBAction func onPressDelete(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.onClickDelete()
        }
    }
}
