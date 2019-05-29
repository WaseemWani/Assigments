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
    @IBOutlet weak var label: UILabel!
    var receivedString = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View 3"
        label.text = receivedString
        // Do any additional setup after loading the view.
        
        //  Question4 Customization of navigation item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "back to view 2", style: .plain, target: self, action: #selector(self.backButton))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Go to view 4", style: .plain, target: self,  action: #selector (self.forwardNavigate))
        // Do any additional setup after loading the view.
    }

    @objc func backButton() {
        let ViewController = self.navigationController?.viewControllers
        self.navigationController?.popToViewController(ViewController![1], animated: true)//(animated: true)
    }
    
    @objc func forwardNavigate() {
        let viewStory = UIStoryboard(name: "Main", bundle: nil)
        //let viewController =  self.navigationController?.viewControllers
        let view4 = viewStory.instantiateViewController(withIdentifier: "ViewController4")
        self.navigationController?.pushViewController(view4, animated: true)
    }
    
    @IBAction func jump() {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
        let view3 = viewController.instantiateViewController(withIdentifier: "ViewController4")
        self.navigationController?.pushViewController(view3, animated: true)
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

