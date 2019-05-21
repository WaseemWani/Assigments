//
//  OneTimeVC.swift
//  Employees World
//
//  Created by Waseem Wani on 20/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class OneTimeVC: UIViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "ShowOneTimeVC")
        self.dismiss(animated: true, completion: nil)
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
