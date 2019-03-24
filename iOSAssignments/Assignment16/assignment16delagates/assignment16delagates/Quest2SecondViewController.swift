//
//  Quest2SecondViewController.swift
//  assignment16delagates
//
//  Created by Waseem Wani on 23/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class Quest2SecondViewController: UIViewController {

    @IBOutlet weak var notify2Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Second View Controller"
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(notifyButtonTapped), name: NSNotification.Name(rawValue: "notificationIdentifier"), object: nil)
    }
    
    @objc func notifyButtonTapped() {
        notify2Label.text = "I have been notified"
        notify2Label.backgroundColor = .red
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
    @IBAction func pushViewController() {
        let vc: Quest2ThirdViewController = self.storyboard?.instantiateViewController(withIdentifier: "ThirdVC") as! Quest2ThirdViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
