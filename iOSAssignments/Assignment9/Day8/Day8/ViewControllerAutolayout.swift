//
//  ViewControllerAutolayout.swift
//  Day8
//
//  Created by Waseem Wani on 06/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewControllerAutolayout: UIViewController {
    @IBOutlet var imageView : UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let radius = self.frame.width/2.0
       // imageView.layer.cornerRadius = imageView.frame.height / 2
        //imageView.layer.cornerRadius = radius
        // Do any additional setup after loading the view.
    }
    
//    func makeRounded() {
//
//        self.layer.masksToBounds = true
//    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


