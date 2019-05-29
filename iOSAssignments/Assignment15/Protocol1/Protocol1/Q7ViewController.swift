//
//  Q7ViewController.swift
//  Protocol1
//
//  Created by Waseem Wani on 04/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

protocol Validator {
    func validateName() -> Bool
    func validateMail() ->Bool
    //func validatePhnNumber() -> Bool
    //func validateAge() -> Bool
    //func validatePassword() ->Bool
}

extension String: Validator {
    
    func validateName() -> Bool {
        let nameRegx = "[a-zA-Z]{2,}"
        let matchesResult = NSPredicate(format: "SELF MATCHES %@", nameRegx)
        let result = matchesResult.evaluate(with: self)
        
        if result == false {
            return false
        } else {
            return true
        }
    }
    
    func validateMail() -> Bool{
        let emailRegx = "[A-z0-9]{1,}@[A-z]{1,}[\\.][A-z]{2,}$"
        let matchResult = NSPredicate(format: "SELF MATCHES %@", emailRegx)
        let result = matchResult.evaluate(with: self)
        if result == false {
            return false
        } else {
            return true
        }
    }
    
    func validatePassword() -> Bool {
        let passwdRegx = "[A-Za-z]{1,}[0-9]{1,}[@#*&%]{1,}"
        let matchResult = NSPredicate(format: "SELF MATCHES %@", passwdRegx)
        let result = matchResult.evaluate(with: self)
        if (result == false && (self.count) < 6 ) {
            return false
        } else {
            return true
        }
    }
}

//class Q7ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

