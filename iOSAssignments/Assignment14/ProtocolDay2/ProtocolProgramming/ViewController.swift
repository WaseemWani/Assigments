//
//  ViewController.swift
//  ProtocolProgramming
//
//  Created by Waseem Wani on 29/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

protocol LoadMore {
    func loadMore() -> String
}

// extension of LoadMore protocol. We have put a constraint on it so that the instructions in this extensions will be implemented only by that ViewController which conforms to UIScrollViewDelegate
extension LoadMore where Self: UIScrollViewDelegate {
    func loadMore() -> String {
        return ("load more")
    }
}

class ViewController: UIViewController, UIScrollViewDelegate, LoadMore {
    @IBOutlet weak var myLabel: UILabel!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = loadMore()
        print(myLabel.text!)
        // Do any additional setup after loading the view, typically from a nib.
    }

}

