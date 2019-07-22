//
//  ViewController.swift
//  Employees World
//
//  Created by Waseem Wani on 19/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class RootVC: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // show welcome screen if user is not logged in or app is being run first time
        if UserDefaults.standard.bool(forKey: "ShowOneTimeVC") == false || UserDefaults.standard.bool(forKey: "loggedIn") == false  {
            presentOneTimeVC()
        }
    }
    
    func presentOneTimeVC() {
        let vc =  storyboard?.instantiateViewController(withIdentifier: "OneTimeVC") as! OneTimeVC
        self.present(vc, animated: true, completion: nil)
    }
}
