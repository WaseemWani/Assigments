//
//  ImageVC.swift
//  Multithreading Client Server Communication
//
//  Created by Waseem Wani on 08/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

protocol Customize {
    func addBorder()
}


class ImageVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
     var openingUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Image Details"
      imageView.addBorder()
      downloadButton.addBorder()
      authorButton.addBorder()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func authorBtnTapped(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: openingUrl)! as URL)
    

    }
    
    
    @IBAction func logoutBtntapped(_ sender: Any) {
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
// extension on UIBUtton class, conforming the protocol customize. This is used to cuctomize Buttons
//@IBDesignable
extension UIButton: Customize {
    
    func addBorder() {
        self.layer.cornerRadius = 15
        //self.tintColor = UIColor.blue.cgColor
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.shadowColor = UIColor.cyan.cgColor
    }
    
    
}

