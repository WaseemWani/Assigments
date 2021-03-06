//
//  Quest2FirstViewController.swift
//  assignment16delagates
//
//  Created by Waseem Wani on 23/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class Quest2FirstViewController: UIViewController {
    
    @IBOutlet weak var notifLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "First View Controller"
        // Do any additional setup after loading the view.
       
        NotificationCenter.default.addObserver(self, selector: #selector(notifiyButtonTapped), name: NSNotification.Name(rawValue: "notificationIdentifier"), object: nil)
    }
    
    @objc func notifiyButtonTapped(_ notification: NSNotification) {
        if let msg =  notification.userInfo?["msg"] as? String {
        notifLabel.text = msg   //"I have been notified"
        }
        notifLabel.backgroundColor = .red
    }
    
    
    @IBAction func pushViewController() {
    let vc: Quest2SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! Quest2SecondViewController
    self.navigationController?.pushViewController(vc, animated: true)
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
