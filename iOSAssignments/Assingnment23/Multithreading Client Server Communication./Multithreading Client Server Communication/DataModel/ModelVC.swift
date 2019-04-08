//
//  ModelVC.swift
//  Multithreading Client Server Communication
//
//  Created by Waseem Wani on 08/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit


struct DataModel: Decodable{
    let format: String
    let width: Int
    let height: Int
    let filename: String
    let id: Int
    let author: String
    let author_url: String
    let post_url: String
}

class ModelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: model will recieve data from

 }
