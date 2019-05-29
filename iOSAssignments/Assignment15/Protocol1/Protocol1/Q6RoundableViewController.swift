//
//  Q6RoundableViewController.swift
//  Protocol1
//
//  Created by Waseem Wani on 04/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

protocol Roundable {
    func roundView()
}

protocol Borderable {
    func makeborderable(item: UIView)
    func makeborderable(item: UIImageView)
}

extension UIButton: Roundable {
    
    func roundView() {
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
    }
}

extension UILabel: Roundable {
    func roundView() {
        self.layer.cornerRadius = 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.blue.cgColor
    }
}

extension Borderable {
    
func makeborderable(item: UIView) {
    item.layer.borderWidth = 2
    item.layer.cornerRadius = item.frame.height / 2
    item.layer.borderColor = UIColor.blue.cgColor
}
    
func makeborderable(item: UIImageView) {
    item.layer.cornerRadius = item.frame.height / 2
    item.layer.borderWidth = 2
    item.layer.borderColor = UIColor.blue.cgColor
}
}

//class Q6RoundableViewController: UIViewController {
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


