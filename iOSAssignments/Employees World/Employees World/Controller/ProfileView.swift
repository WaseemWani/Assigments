//
//  ProfileView.swift
//  Employees World
//
//  Created by Waseem Wani on 17/06/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "logged in or signedup"
    }
}
