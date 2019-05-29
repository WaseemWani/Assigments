//
//  ViewController.swift
//  Assignment10
//
//  Created by Waseem Wani on 11/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet var btn4Qustion1: UIButton!
    @IBOutlet var btn4Qustion2: UIButton!
    @IBOutlet var btn4Qustion3: UIButton!
    @IBOutlet var btn4Qustion4: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pushImageView() {
  let pushView2 = UIStoryboard(name: "Main", bundle: nil)
  let imageView = pushView2.instantiateViewController(withIdentifier: "imageViewController")
    self.navigationController?.pushViewController(imageView, animated: true)
}
    
    @IBAction func pushEmojiView() {
        let pushView4 = UIStoryboard(name: "Main", bundle: nil)
        let emojiView = pushView4.instantiateViewController(withIdentifier: "emojiViewController")
        self.navigationController?.pushViewController(emojiView, animated: true)
    }

    @IBAction func pushRoundimageView() {
        let pushView3 = UIStoryboard(name: "Main", bundle: nil)
        let roundImageView = pushView3.instantiateViewController(withIdentifier: "roundImageViewController")
        self.navigationController?.pushViewController(roundImageView, animated: true)
    }
    
    
    @IBAction func pushCalcView() {
        let pushView5 = UIStoryboard(name: "Main", bundle: nil)
        let calcView = pushView5.instantiateViewController(withIdentifier: "calcViewController")
        self.navigationController?.pushViewController(calcView, animated: true)
    }
}


