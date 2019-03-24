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
        //let  dict: Dictionary = ["Name": name, "Age": age, "Parentage": parentage]
   
        //print("heLLO"+name)
    //        let vc: ViewController = self.storyboard?.instantiateViewController(withIdentifier:"viewController2") as! ViewController
    //        vc.delegate = self
    //
//        var keyvalues = [Any]() //, values = []
//        for (key, value) in dict {
//         keyvalues.append([key, value])
//        }
        passedDateLabel.text = "the details entered are:\n Name: \(dict["Name"]!+"\nAge:  "+dict["Age"]!+"\nParentage: "+dict["Parentage"]!)"
  }
}
