//
//  Q4IndicatorViewController.swift
//  Protocol1
//
//  Created by Waseem Wani on 04/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit


protocol  ActivityIndictor: class {
    func animateIndicator()
}

extension UIActivityIndicatorView: ActivityIndictor {
    func animateIndicator() {
        self.isHidden = false
        self.color = UIColor.blue
        self.startAnimating()
    }
}


//class Q4IndicatorViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


