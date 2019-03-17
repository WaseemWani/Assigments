//
//  ViewController1.swift
//  waseem
//
//  Created by Waseem Wani on 01/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet var Button: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func jump3() {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
        let view = viewController.instantiateViewController(withIdentifier: "ViewController3")
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View 2"
        //self.title = "Waseem"
        print(label)
        
        //  Question4 Customization of navigation item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "back to view 1", style: .plain, target: self, action: #selector(self.backButton))
        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "go to view 3", style: .plain, target: self, action: #selector(self.forwardButton))
    
    }
    var label: String = "Waseem"
    
    @objc func backButton() {
        let ViewController = self.navigationController?.viewControllers
        self.navigationController?.popToViewController(ViewController![0], animated: true)
    }
    
    @objc func forwardButton() {
        //let ViewController = self.navigationController?.viewControllers
        let viewController = UIStoryboard(name: "Main", bundle: nil)
        let view = viewController.instantiateViewController(withIdentifier: "ViewController3")
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let secondViewController = segue.destination as! ViewController3
        
        // set a variable in the second view controller with the String to pass
        secondViewController.receivedString = textField.text!
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
