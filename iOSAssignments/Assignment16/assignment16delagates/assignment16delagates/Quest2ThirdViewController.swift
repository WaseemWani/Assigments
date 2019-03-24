//
//  Quest2ThirdViewController.swift
//  assignment16delagates
//
//  Created by Waseem Wani on 23/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class Quest2ThirdViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "third view controller"
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(notifyButtontapped), name: NSNotification.Name(rawValue: "noticationIdentifier"), object: nil)
    }
    

    @objc func notifyButtontapped() {
        label.text = "i have been notified"
        label.backgroundColor = .red
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func buttonClickToNotifyTapped(_ sender: Any) {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "notificationIdentifier"), object: self)
        
        label.text = " Status: The controller has been notified."
    }
    

}
