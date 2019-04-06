//
//  ViewController.swift
//  cocoaPods
//
//  Created by Waseem Wani on 22/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit
import Alamofire
import Reachability

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
    //print(isInternetAvailable())       // Do any additional setup after loading the view, typically from a nib.
        
}

    func makeRequest() {
        request("https://httpbin.org/get").responseJSON { response in
            if let JSON = response.result.value {
                var jsonResult = JSON as! [String:AnyObject]
                let url = jsonResult["url"] as! String
                let origin = jsonResult["origin"]as! String
                print(JSON)
                
                print("demonstration of alamofire")
                //print("JSON \(jsonResult)")
                print("request url: \(url)")
                print(origin)
            }
        }
}
}
