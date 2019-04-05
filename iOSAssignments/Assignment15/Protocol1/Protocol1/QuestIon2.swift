//
//  ToasMessageViewController.swift
//  Protocol1
//
//  Created by Waseem Wani on 29/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit


protocol Toast  {
    func showToastMsg(message: String)
}

extension Toast where Self: UILabel {
    
    func showToastMsg(message: String) {
        self.backgroundColor = .red
        self.layer.opacity = 0.5
        self.text = message
        self.layer.cornerRadius = 12
        UIView.animate(withDuration: 5, delay: 3, options: .transitionCrossDissolve, animations: {self.alpha = 0.0}, completion: {(isCompleted) in })
    }
}

extension UILabel: Toast {}

class QuestIon2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //toastLabel.showToastMsg(message: "Hello")
        // Do any additional setup after loading the view.
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
