//
//  ViewController.swift
//  localization
//
//  Created by Waseem Wani on 12/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var lotteryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var countrytxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var stateTxtField: UITextField!
    @IBOutlet weak var lotteryTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         name.text = NSLocalizedString("name", comment: "nameLabel")
        country.text = NSLocalizedString("country", comment: "nameLabel")
        lotteryLabel.text = NSLocalizedString("lotteryLabel", comment: "nameLabel")
        stateLabel.text = NSLocalizedString("stateLabel", comment: "nameLabel")
//        name.text = NSLocalizedString("name", comment: "nil")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    


}

