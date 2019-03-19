//
//  RoundImageViewController.swift
//  Assignment10
//
//  Created by Waseem Wani on 12/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class RoundImageViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2.0
        self.imageView.clipsToBounds = true
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
