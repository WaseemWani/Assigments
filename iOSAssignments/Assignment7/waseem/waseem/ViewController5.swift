//
//  ViewController4.swift
//  waseem
//
//  Created by Waseem Wani on 04/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController5: UIViewController {

    @IBOutlet var button: UIButton!
    
    @IBAction func dismiss4() {
    
        self.dismiss(animated: true, completion: nil)
        
        //self.navigationController?.pushViewController(xyz, animated: true) let viewcontroller4 = UIStro
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "view 5"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "back to view 4", style: .plain, target: self, action: #selector(self.backButton))
        // Do any additional setup after loading the view.
    }
    @objc func backButton() {
        let ViewController = self.navigationController?.viewControllers
        self.navigationController?.popToViewController(ViewController![3], animated: true)//(animated: true)
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
