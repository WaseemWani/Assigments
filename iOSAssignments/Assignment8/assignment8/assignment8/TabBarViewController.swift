//
//  TabBarViewController.swift
//  assignment8
//
//  Created by Waseem Wani on 12/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {
    @IBOutlet var roundImageView: UIImageView!
    @IBOutlet weak var roundUIView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var greenView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orangeView.clipsToBounds = false
        self.orangeView.layer.masksToBounds = true
        
        
        
        
        roundImageView.backgroundColor = UIColor.red
        self.roundImageView.layer.cornerRadius = 10.0
        self.roundImageView.layer.masksToBounds = true
        
        self.roundUIView.layer.cornerRadius = 10
        self.roundUIView.backgroundColor = UIColor.blue
        self.roundUIView.layer.shadowColor = UIColor.brown.cgColor
        //self.roundUIView.layer.opacity = 1
        self.roundUIView.layer.shadowOffset =  CGSize(width: 7.0, height: 9.0)
        self.roundUIView.layer.shadowOpacity = 1.0
        //self.roundUIView.layer.masksToBounds = true
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
