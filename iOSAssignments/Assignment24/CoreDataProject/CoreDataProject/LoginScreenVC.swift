//
//  LoginScreenVC.swift
//  CoreDataProject
//
//  Created by Waseem Wani on 07/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit


protocol CredValidator {
   func emailValidation() -> Bool
    func passwordValidation() -> Bool
}


class LoginScreenVC: UIViewController {

    
    @IBOutlet weak var emailTxtfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var toastLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func loginBtnTapped() {
        
        if ((emailTxtfield.text?.emailValidation())! && passwordTextField.text?.passwordValidation() == false )  //
            {
            UIView.transition(with: emailTxtfield, duration: 0.5, options: .transitionFlipFromBottom, animations: {}, completion: nil)
                emailTxtfield.text = ""
            UIView.transition(with: passwordTextField, duration: 0.5, options: .transitionFlipFromBottom, animations: {}, completion: nil)
                passwordTextField.text = ""
                
                toastLabel.showToastMsg(message: "Please enter valid credentials")
                
        
        } else {
    
            UserDefaults.standard.set(true, forKey: "UserLoggedIn")
            saveCredentials( state: UserDefaults.standard.bool(forKey: "UserLoggedIn"), id: emailTxtfield.text!)
            
                 addNewRecipe()
                 self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func addNewRecipe() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVc") as? TabBarVc
        self.navigationController?.pushViewController(vc!, animated: true)
        }
    
    
    // this function saves email id using Userdefaults
    func saveCredentials(state: Bool, id: String) {
        
        switch state {
        case true:
            UserDefaults.standard.set(id, forKey: "emailId")
        
        case false:
             print( "unable to to login")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension String : CredValidator {
    
    func  emailValidation() -> Bool {
        
        // email validation
        let emailRegx = "[A-z0-9]{1,}@[A-z]{1,}[\\.][A-z]{2,}$"
        let matchesResult = NSPredicate(format: "SELF MATCHES %@", emailRegx)
        //let result =
        if (matchesResult.evaluate(with: self) == true) {
            return true
                         //if result == true {
        } else {
            return false
        }
    }
    
    // password validation
    func  passwordValidation() -> Bool  {
        
        let passwdRegx = "[A-Za-z]{1,}[0-9]{1,}[@#*&%]{1,}"
        let matchResult = NSPredicate(format: "SELF MATCHES %@", passwdRegx)
        let result2 = matchResult.evaluate(with: self)
        
        //below code lines return for valid password or false otherwise
        if (self.count < 8 && result2 == false ) {
            return false
            
        } else {
            return true
        }
    }
}

