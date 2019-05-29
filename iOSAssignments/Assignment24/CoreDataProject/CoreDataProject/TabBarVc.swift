//
//  RootVC.swift
//  CoreDataProject
//
//  Created by Waseem Wani on 07/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class TabBarVc: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UserDefaults.standard.bool(forKey: "userlogin") == false) {
            showLoginScreen()
            
        }
    }
  
    
    func showLoginScreen() {
        
        let storyboardObj = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboardObj.instantiateViewController(withIdentifier: "LoginScreenVC") as? LoginScreenVC
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func logout() {
        UserDefaults.standard.removeObject(forKey: "userlogin")
        UserDefaults.standard.removeObject(forKey: "emailId")
        showLoginScreen()
    }

   @IBAction func addNewRecipe() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddRecipesVC") as? AddRecipesVC
        self.navigationController?.pushViewController(vc!, animated: true)
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


