//
//  PassdataVC.swift
//  assignment16delagates
//
//  Created by Waseem Wani on 23/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit
protocol Passable {
    func passData(_ dict: [String : String])
}

class PassdataVC: UIViewController {

     
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var parentageTextField: UITextField!
    @IBOutlet weak var pushButton: UIButton!
     var delg: Passable?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func popButtonTapped(_ sender: Any) {
        let  dict: Dictionary = ["Name": nameTextField.text!, "Age": ageTextField.text!, "Parentage": parentageTextField.text!]
        delg?.passData(dict)
        self.navigationController?.popViewController(animated: true)
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
