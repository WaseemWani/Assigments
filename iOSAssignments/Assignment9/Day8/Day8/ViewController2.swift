//
//  ViewController2.swift
//  Day8
//
//  Created by Waseem Wani on 05/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var goToNxtpageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.imageView.layer.cornerRadius = self.imageView.frame.width / 2.0
         self.imageView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
   
    @IBAction func goToNxtpage() {
     let storyObj =  UIStoryboard(name: "Main", bundle: nil)
        let welcomeView = storyObj.instantiateViewController(withIdentifier: "segmentedView")
        self.navigationController?.pushViewController(welcomeView, animated: true)
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
