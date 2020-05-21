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
    
    @PasswordValidator var pswd: String = ""
    
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
        }
    }
    
        @objc func settingsTapped() {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        if userNameTextField.text!.isEmpty {
            showToast(withMsg: "Please enter username")
        } else {
            pswd = passwordTextField.text!
            if !pswd.isEmpty {
                if let vc =  self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                showToast(withMsg: "Invalid password. Paswword should contain atleast 7 alphanumeric characters and one special character")
            }
        }
    }
    
    /// this function is used to show an error toast on screen
    /// - Parameter alertMsg: String. The message to be displayed on screen.
    func showToast(withMsg alertMsg: String) {
        let alert = UIAlertController(title: nil , message: alertMsg, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.view.layer.cornerRadius = 8
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alert.dismiss(animated: true)
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
    
    /// this function roundes corners of a button by 15 units of radius.
    func roundCorners() {
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }
}
 

/// this property wrapper is used to validate password
@propertyWrapper struct PasswordValidator {
    private var value: String = ""
    
    var wrappedValue: String {
        get {
            return value
        }
        set {
            value = isValidPassword(pswd: newValue) ? newValue : ""
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
    private func isValidPassword(pswd: String) -> Bool {
        let passwordRegex = "[0-9a-zA-Z]{7,}[@#$%&*]{1,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: pswd)
    }
}
