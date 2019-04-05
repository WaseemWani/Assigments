//
//  Q3ErrorViewController.swift
//  Protocol1
//
//  Created by Waseem Wani on 04/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

enum ErrorView: Error {
    case somefieldsEmtpy
    case other
    
    var errorDescription: String {
        return("some fields are empty")
    }
    //
}

protocol  ErrorViewProtocol: AnyObject {
    func showErrorMsg() -> String
}

extension ErrorViewProtocol where Self: UIViewController  {
    
    func showErrorMsg() -> String {
        
        let er: ErrorView  = ErrorView.somefieldsEmtpy
        
            //switch er {
            //ErrorView.somefieldsEmtpy
                return er.errorDescription
            //default:
              //  return ""
        }
        
        
    }
//}

//class Q3ErrorViewController: UIViewController {
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


