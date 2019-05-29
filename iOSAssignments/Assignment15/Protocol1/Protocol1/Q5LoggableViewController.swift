//
//  Q5LoggableViewController.swift
//  Protocol1
//
//  Created by Waseem Wani on 04/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit


protocol Loggable{
    
    func userLogin(/*state: Bool,*/name: String, id: String, pwd: String)
    //func userLogOut(userName : String)
}

extension Loggable {
    
    func userLogin(/*state: Bool,*/ name: String, id: String, pwd: String) {
        //switch state {
        //case true:
//            UserDefaults.standard.removeObject(forKey: "umane")
//            UserDefaults.standard.removeObject(forKey: "uid")
//            UserDefaults.standard.removeObject(forKey: "uid")
       // case false:
            UserDefaults.standard.set(name, forKey: "uname")
            UserDefaults.standard.set(id, forKey: "uid")
            UserDefaults.standard.set(pwd, forKey: "pwd")
        }
    }


//class Q5LoggableViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

