//
//  ViewController.swift
//  DarkMode
//
//  Created by Waseem Wani on 16/02/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var signInIcon: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        signInButton.roundCorners()
        signUpButton.roundCorners()
        themeProvider.register(observer: self)
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "SIGN IN"
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
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        if let vc =  self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SignInViewController: Themeable {
    func apply(theme: Theme) {
        self.navigationController?.navigationBar.barTintColor = theme.backgroundColor
        self.view.backgroundColor = theme.backgroundColor
        signInButton.backgroundColor = theme.buttonBackGroundColor
        signUpButton.backgroundColor = theme.buttonBackGroundColor
        userNameTextField.textColor = theme.textColor
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "User Name", attributes: [NSAttributedString.Key.foregroundColor: theme.separatorColor])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: theme.separatorColor])
        passwordTextField.textColor = theme.textColor
    }
}

extension UIButton {
    func roundCorners() {
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }
}
 
