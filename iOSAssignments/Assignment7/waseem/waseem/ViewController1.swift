//
//  ViewController.swift
//  waseem
//
//  Created by Waseem Wani on 01/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    
    @IBAction func pushViewController() {
        let viewController1 = UIStoryboard(name: "Main", bundle: nil)
        let view = viewController1.instantiateViewController(withIdentifier: "ViewController2")
        self.navigationController?.pushViewController(view, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "welcome"
        self.title = "View 1"
        // Do any additional setup after loading the view, typically from a nib.
    }

}
