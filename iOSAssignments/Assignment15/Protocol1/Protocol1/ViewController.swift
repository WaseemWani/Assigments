//
//  ViewController.swift
//  Protocol1
//
//  Created by Waseem Wani on 29/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

// MARK: - Question 1


// Mark:  - Question 6



class ViewController: UIViewController, Borderable, Loggable, ErrorViewProtocol {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtfield: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var imageUploadButton: UIButton!
    @IBOutlet weak var toastlabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.isHidden = true
        
        loginButton.roundView()
        imageUploadButton.roundView()
        makeborderable(item: imageView)
        let date = Date()
        dateLabel.text = date.changeDateFormat()
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
@IBAction func textEditingDidEnd(_ sender: UITextField) {
    
    switch sender.tag
    {
    case 1:
        let name: String = String(nameTxtField.text!)
        let flag = name.validateName()
        if flag == false {
            
            toastlabel.showToastMsg(message: "Not a valid name")
        }
        
    case 2:
        let mail = emailTxtfield?.text
        let flag =  mail?.validateMail()
        if flag == false {
            toastlabel.showToastMsg(message: "Not a valid mail")
        }
    case 3:
        let password = passwordTxtField.text!
        let flag = password.validatePassword()
        if flag ==  false {
            toastlabel.showToastMsg(message: "Please enter a strong password!!")
        }
    default:
        toastlabel.showToastMsg(message: "")
        
    }
}
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        //UserDefaults.standard.set(true, forKey: "UserLoggedIn")
        userLogin(/*state: UserDefaults.standard.bool(forKey: "UserLoggedIn"),*/ name: nameTxtField.text!, id: emailTxtfield.text!, pwd: passwordTxtField.text!)
        UserDefaults.standard.set(true, forKey: "userlogin")
        
        indicator.animateIndicator()
        
        if (nameTxtField.text!.isEmpty == true || emailTxtfield.text?.isEmpty == true || passwordTxtField.text!.isEmpty == true ) {
            errorLabel.text = showErrorMsg()
            } else {
            pushNextVC()
         }
    }
    
    func pushNextVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "userprofile")
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}



