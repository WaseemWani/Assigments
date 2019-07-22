//
//  ProfileVC.swift
//  Employees World
//
//  Created by Waseem Wani on 30/06/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var headingNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var uIDLabel: UILabel!
    @IBOutlet weak var subscriptionLabel: UILabel!
    @IBOutlet weak var logutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserDetails()
        customizeView(view: logutBtn, crnrRadius: 15, bdrWidth: 1, brdrClr: .black)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "loggedIn")
        //print(UserDefaults.standard.bool(forKey: "loggedIn"))
        deleteUserDetails()
        //self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func showUserDetails() {
        let defaults = UserDefaults.standard
        headingNameLabel.text = defaults.string(forKey: "lName")
        nameLabel.text = (defaults.string(forKey: "fName"))
        nameLabel.text?.append(" ")
        nameLabel.text?.append(defaults.string(forKey: "lName") ?? "")
        uIDLabel.text = defaults.string(forKey: "UID")
        subscriptionLabel.text = defaults.string(forKey: "status")
    }
    
    func deleteUserDetails() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "fName")
        defaults.removeObject(forKey: "lName")
        defaults.removeObject(forKey: "UID")
        defaults.removeObject(forKey: "status")
    }
}

extension ProfileVC : CustomizedView {
}
