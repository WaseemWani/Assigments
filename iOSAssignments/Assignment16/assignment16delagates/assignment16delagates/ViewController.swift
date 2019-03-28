//
//  ViewController.swift
//  assignment16delagates
//
//  Created by Waseem Wani on 23/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit


class ViewController: UIViewController, Passable {

    @IBOutlet weak var passedDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
        
        
    @IBAction func pushViewController(_ sender: Any) {
        
        let vc: PassdataVC = self.storyboard?.instantiateViewController(withIdentifier: "passDataVc") as! PassdataVC
        vc.delg = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
 

    func passData(_ dict: [String:String]) {
    
        passedDateLabel.text = "the details entered are:\n Name: \(dict["Name"]!+"\nAge:  "+dict["Age"]!+"\nParentage: "+dict["Parentage"]!)"
  }
}
