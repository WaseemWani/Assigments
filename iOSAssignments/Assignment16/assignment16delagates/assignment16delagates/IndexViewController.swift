//
//  IndexViewController.swift
//  assignment16delagates
//
//  Created by Waseem Wani on 24/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pushQuestion1(_ sender: Any) {
        let vc:ViewController = storyboard?.instantiateViewController(withIdentifier: "ViewControllerQ1") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func pushQuestion2(_ sender: Any) {
        let vc: Quest2FirstViewController = storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! Quest2FirstViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func pushQuestion3(_ sender: Any) {
        let vc: NotificationViewController  = storyboard?.instantiateViewController(withIdentifier: "NotifViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func pushQuestion4(_ sender: Any) {
        let story   = UIStoryboard.init(name: "Main", bundle: nil)
            let vc =  story.instantiateViewController(withIdentifier: "Question4")
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
