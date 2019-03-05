//
//  ViewController3.swift
//  waseem
//
//  Created by Waseem Wani on 01/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    
    @IBAction func pushto4() {
        
        let viewController4 = UIStoryboard(name: "Main", bundle: nil)
        let view = viewController4.instantiateViewController(withIdentifier: "ViewController5") as? ViewController5
        self.present(view!, animated: true, completion: nil)
        
    }
    @IBAction func pop0() {
        //let xyz = self.navigationController?.viewControllers
        self.navigationController?.popToRootViewController(animated: true)//(xyz![1], animated: true)
    }
    
    @IBAction func pop2() {
        let xyz1 = self.navigationController?.viewControllers
        self.navigationController?.popToViewController(xyz1![2], animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "4th view"
        //label.text = "Hello there!, this is view 4"
        //  Question4 Customization of navigation item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "back to view 3", style: .plain, target: self, action: #selector(self.backButton))
        // Do any additional setup after loading the view.
    }
    @objc func backButton() {
        let ViewController = self.navigationController?.viewControllers
        self.navigationController?.popToViewController(ViewController![2], animated: true)//(animated: true)
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
