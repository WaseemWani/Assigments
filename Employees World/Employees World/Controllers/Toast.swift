//
//  Toast.swift
//  Employees World
//
//  Created by Waseem Wani on 20/07/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation
import UIKit

protocol Toast {
    func showToast(withMsg alertMsg: String)
}

extension Toast where Self: UIViewController {
    func showToast(withMsg alertMsg: String) {
        let alert = UIAlertController(title: nil , message: alertMsg, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.view.layer.cornerRadius = 8
        //controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alert.dismiss(animated: true)
        }
    }
}
