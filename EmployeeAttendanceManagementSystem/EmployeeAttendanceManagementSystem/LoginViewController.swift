//
//  LoginViewController.swift
//  EmployeeAttendanceManagementSystem
//
//  Created by Waseem Wani on 22/04/21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var errorLabelBottonConstraint: NSLayoutConstraint!
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    var isSecureEntryEnabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LOGIN"
        loginButton.roundCorners()
        loginButton.addShadow()
        idTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.rightViewMode = UITextField.ViewMode.always
        imageView.isUserInteractionEnabled = true
        if isSecureEntryEnabled {
            let image = UIImage(systemName: "eye.slash.fill")
            imageView.image = image
            passwordTextField.rightView = imageView
            passwordTextField.isSecureTextEntry = true
        }
        addTapGesture(on: imageView)
    }
    
    func addTapGesture(on view: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func didTapImageView(_:Any) {
        if isSecureEntryEnabled {
            imageView.image = UIImage(systemName: "eye.slash.fill")
            passwordTextField.isSecureTextEntry = true
            isSecureEntryEnabled = false
        } else {
            imageView.image = UIImage(systemName: "eye.fill")
            passwordTextField.isSecureTextEntry = false
            isSecureEntryEnabled = true
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let id = idTextField.text, let password = passwordTextField.text else { return }
        if id.isEmpty || password.isEmpty {
            errorLabel.text = "Please fill all the fields"
            errorLabel.textColor = .red
        } else if id == UserDefaults.standard.string(forKey: AppConstants.idKey) && password == UserDefaults.standard.string(forKey: AppConstants.passwordKey) {
            errorLabel.text = nil
            UserDefaults.standard.set(true, forKey: AppConstants.loggedInKey)
            showHomeViewController()
            showToast(title: "Done", message: "Logged in succesfully!", completionHandler: nil)
        } else {
            errorLabel.text = "Invalid login credentials"
            errorLabel.textColor = .red
        }
    }
    
    private func showHomeViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
        navigationController?.setViewControllers([homeViewController], animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabelBottonConstraint.constant = 150
        errorLabel.text = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
            errorLabelBottonConstraint.constant = 30
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == idTextField {
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength && string.validateId()
        }
        return true
    }
}
