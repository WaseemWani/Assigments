//
//  ViewController2.swift
//  Day8
//
//  Created by Waseem Wani on 05/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class SegmentedViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet var segmentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Welcome user"
        self.segmentLabel.text = "Employer Segment Selected"
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

    @IBAction func segmentedControl(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            segmentLabel.text = "Employer segment selected"
        }
       else  {
            segmentLabel.text =  "Employee segment selected "
        }
        
        //else {
          //  segmentLabel.text = "I am in 3rd Segment"
            //}
    }
}
