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
        
        if UserDefaults.standard.bool(forKey: "ShowOneTimeVC") == false {
            presentOneTimeVC()
        }
    }

    func presentOneTimeVC() {
        let vc =  storyboard?.instantiateViewController(withIdentifier: "OneTimeVC") as! OneTimeVC
        self.present(vc, animated: true, completion: nil)
    }
}
