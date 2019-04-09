//
//  LoginScreenVC.swift
//  CoreDataProject
//
//  Created by Waseem Wani on 07/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class LoginScreenVC: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnTapped() {
        
        if userNameTextField.text == "" {
            UIView.transition(with: userNameTextField, duration: 0.5, options: .transitionFlipFromBottom, animations: {}, completion: nil)
            
        } else if passwordTextField.text == "" {
            UIView.transition(with: passwordTextField, duration: 0.5, options: .transitionFlipFromBottom, animations: {}, completion: nil)
            
        } else {
                addNewRecipe()
            //UserDefaults.standard.set(true, forKey: "userLogin")
            //self.dismiss(animated: true, completion: nil)
            
        }
        
        
        
    }
    
    func addNewRecipe() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVc") as? TabBarVc
        self.navigationController?.pushViewController(vc!, animated: true)
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
        //MARK: - Login Functionality
        
        //Don't ask for login credentials if user logged in last time
        


