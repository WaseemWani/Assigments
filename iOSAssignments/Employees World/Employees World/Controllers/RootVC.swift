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
        
//        print("OneTime:", UserDefaults.standard.bool(forKey: "ShowOneTimeVC"),"login:", UserDefaults.standard.bool(forKey: "loggedIn"))

        if UserDefaults.standard.bool(forKey: "ShowOneTimeVC") == false || UserDefaults.standard.bool(forKey: "loggedIn") == false  {
            presentOneTimeVC()
        }
    }
    
    func presentOneTimeVC() {
        let vc =  storyboard?.instantiateViewController(withIdentifier: "OneTimeVC") as! OneTimeVC
        self.present(vc, animated: true, completion: nil)
    }
}
