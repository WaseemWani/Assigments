//
//  ViewController.swift
//  LocalizationApp
//
//  Created by Waseem Wani on 09/04/19.
//  Copyright © 2019 Waseem Wani All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var lottryLabel: UILabel!
   // @IBOutlet weak var dateofbirthTextField: UITextField!
    //@IBOutlet weak var lottrywonTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = NSLocalizedString("name", comment: "nameLabel")
        stateLabel.text = NSLocalizedString("state", comment: "stateLabel")
        countryLabel.text = NSLocalizedString("country", comment: "countryLabel")
        dobLabel.text = NSLocalizedString("dob", comment: "dobLabel")
        lottryLabel.text = NSLocalizedString("lottry", comment: "lottrylabel")
    }
}

