//
//  ViewController.swift
//  RegistrationModule
//
//  Created by Waseem Wani on 20/10/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

//    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var stepIndicatorView: LAStepIndicatorView!
    
    
    @IBOutlet weak var containerView: UIView!
    let tableDataArray = ["First Name", "Last Name", "Email", "Date of Birth (dd/mm/yyyy)"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        registerTableCell()
        
        let vc = storyboard?.instantiateViewController(identifier: "LACustomerInfoViewController") as! LACustomerInfoViewController
//        vc.view.frame =  containerView.frame
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
        
//        containerView.addSubview(vc?.view)
//        self.navigationController?.pushViewController(vc!, animated: true)
//        tableView.delegate = self
//        tableView.dataSource = self
        
//        self.navigationItem.backBarButtonItem?.title = "Back"
//        self.navigationItem.rightBarButtonItem?.title = "Skip"
//        self.navigationItem.title = "REGISTER"
        
    }
    
//    func registerTableCell() {
//        let nib = UINib.init(nibName: "InfoTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "InfoTableViewCell")
//    }
}

//extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        tableDataArray.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50.0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell") as! InfoTableViewCell
//
//        var frameRect: CGRect =  cell.infoCellTextField.frame
//        frameRect.size.height = 50
//        cell.infoCellTextField.frame = frameRect
//
//        cell.infoCellTextField.placeholder = tableDataArray[indexPath.row]
//        cell.infoCellTextField.textColor = .lightGray
//        return cell
//    }
//
////    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
////
////        let headerView = UIView()
////        headerView.frame = CGRect(x: 26, y: 180, width: 318, height: 50)
////
////        let textLabel = UILabel()
////        textLabel.frame = headerView.bounds
////        textLabel.text = "Create a new account tell us more about yourself to setup your account"
////        headerView.addSubview(textLabel)
////        return headerView
////    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        return "Create a new account tell us more about yourself to setup your account"
//    }
//
////    func numberOfSections(in tableView: UITableView) -> Int {
////        return 1
////    }
//
////    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
////
////    }
//
//}
