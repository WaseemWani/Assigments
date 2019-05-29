//
//  ViewController4.swift
//  waseem
//
//  Created by Waseem Wani on 04/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController5: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "view 5"
        
        let redView = UIViewController()
        redView.view.backgroundColor = UIColor.red
        redView.tabBarItem.title = "red"
        redView.navigationItem.backBarButtonItem?.title = "back"
        //redView.navigationItem.title = "Red"
        
        
        let greenView = UIViewController()
        greenView.view.backgroundColor = UIColor.green
        greenView.tabBarItem.title = "green"
        //greenView.navigationItem.title = "Green"
        
        let blueview = UIViewController()
        blueview.view.backgroundColor = UIColor.blue
        blueview.tabBarItem.title = "blue"
        
        self.viewControllers = [redView, greenView, blueview]

       
        //  Question4 Customization of navigation item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "back to view 4", style: .plain, target: self, action: #selector(self.backButton))
        // Do any additional setup after loading the view.
    }
    
    @objc func backButton() {
        let ViewController = self.navigationController?.viewControllers
        self.navigationController?.popToViewController(ViewController![3], animated: true)//(animated: true)
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

//: Question 4. Explore about Segue and create a short note on its use.

//: A segue defines a transition between two view controllers in your app’s storyboard file. The starting point of a segue is the button, table row, or gesture recognizer that initiates the segue. The end point of a segue is the view controller you want to display. A segue always presents a new view controller, but you can also use an unwind segue to dismiss a view controller.

//: Question 5. Explore diff between Xib's And ViewController and create a short note on its difference.

//: Storyboard​: Storyboards are introduced in iOS 5. When we use storyboards, our deployment target should be 5.0 or higher. With the help of storyboards we can create all the screens of an application and interconnect the screen under one interface MainStoryboard.storyboard. With storyboards we can use segues for pushing/presenting view controllers, thereby reducing the code needed for pushing/presenting.

//: xib​: Xib stands for xml interface builder. Xibs are the older way to perform iOS interface design. With xib any arbitrary/custom view can be designed, which a developer can attach to a view controller as needed. If we apply object oriented approach for our UIs, then it make sense to use xib and break view controller's view down into separate modules.
