//
//  ErrorViewController.swift
//  Protocol1
//
//  Created by Waseem Wani on 29/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ErrorViewProtocol {
    
  @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
//    @IBOutlet var nameField: UITextField!
//    @IBOutlet weak var phoneTxtField: UITextField!
//    @IBOutlet weak var emailTxtField: UITextField!
//    @IBOutlet weak var ageTxtField: UITextField!
//    @IBOutlet weak var passwordTxtField: UITextField!
//
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = UserDefaults.standard.string(forKey: "uname")
        emailLabel.text = UserDefaults.standard.string(forKey: "uid")
        // Do any additional setup after loading the view.
        
    }
}

    //below functions perform validation of text in different textfields including name, phone number, age, email and password
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

