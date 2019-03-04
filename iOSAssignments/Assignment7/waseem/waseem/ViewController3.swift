//
//  ViewController2.swift
//  waseem
//
//  Created by Waseem Wani on 01/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    @IBOutlet var button: UIButton!
    
    @IBAction func jump() {
        let abc = UIStoryboard(name: "Main", bundle: nil)
        let xyz = abc.instantiateViewController(withIdentifier: "ViewController4")
        self.navigationController?.pushViewController(xyz, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View 3"
        // Do any additional setup after loading the view.
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "back to view 2", style: .plain, target: self, action: #selector(self.backButton))
        // Do any additional setup after loading the view.
    }
    
    @objc func backButton() {
        let ViewController = self.navigationController?.viewControllers
        self.navigationController?.popToViewController(ViewController![1], animated: true)//(animated: true)
    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

