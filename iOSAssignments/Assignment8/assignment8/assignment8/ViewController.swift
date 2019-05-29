//
//  ViewController.swift
//  assignment8
//
//  Created by Waseem Wani on 10/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController:  UITabBarController {
    //@IBOutlet   var imageView: UIImageView!
  //let tabBarController = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let redView = UIViewController()
        redView.view.backgroundColor = UIColor.red
        redView.tabBarItem.title = "red"
        
        let greenView = UIViewController()
        greenView.view.backgroundColor = UIColor.blue
        greenView.tabBarItem.title = "green"
        
        let blueview = UIViewController()
        blueview.view.backgroundColor = UIColor.blue
        blueview.tabBarItem.title = "blue"
        
        self.viewControllers = [redView, greenView, blueview]

        //        self.imageView.layer.cornerRadius =  self.imageView.frame.size.width / 2
//
//        self.imageView.clipsToBounds = true
//        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.imageView.layer.cornerRadius =  self.imageView.frame.size.width / 2
//
//        self.imageView.clipsToBounds = true
//    }
}

/* Question 2
 Frame defines the x,y coordinates and height and witdth of a view with respect to the safe area
while as bound defines the same attributes with respect to the view itself
 strong property: by strong property we mean that an object holding a strong reference to another object has retain count of 1 and as a result it remains alive in memory and is not deallocated.
 weak property: by weak property we mean that an object holding a weak reference to another object has a retain count of 0, as result it is deallocated when not needed.
 
 clipToBounds is a property of views, taking a boolean value, setting it true means that the frame beyond the boundary of a view is clipped to the bounds of the view. if it is set false , it means that if frame extends beyond the bounds of the view, it will not be clipped
 
 maskToBounds: 
 
*/
