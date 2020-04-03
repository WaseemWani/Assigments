//
//  SignUpViewController.swift
//  DarkModeDemo
//
//  Created by Waseem Wani on 09/01/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeProvider.register(observer: self)
        signUpButton.roundCorners()
        setupNavBar()
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "SIGN UP"
        if #available(iOS 13, *) {
            self.navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsTapped))
           // navigationItem.leftBarButtonItem = settings
        }
    }
    
    @objc func settingsTapped() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SignUpViewController: Themeable {
    func apply(theme: Theme) {
        //signUpButton.setTitleColor(theme.textColor, for: .normal)
    }
}
