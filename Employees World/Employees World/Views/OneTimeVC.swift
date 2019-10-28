//
//  OneTimeVC.swift
//  Employees World
//
//  Created by Waseem Wani on 20/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

//this class handles the screen, shown only once.
class OneTimeVC: UIViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView(view: continueBtn, crnrRadius: 12, bdrWidth: 0, brdrColor: .white )
        // Do any additional setup after loading the view.
    }
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "ShowOneTimeVC")
        self.dismiss(animated: true, completion: nil)
    }
}

extension OneTimeVC: CustomizedView {
}

