//
//  UIViewControllerExtension.swift
//  DarkMode
//
//  Created by Waseem Wani on 01/06/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// this function is used to show an error toast on screen
    /// - Parameter alertMsg: String. The message to be displayed on screen.
     func showToast(withMsg alertMsg: String) {
        let alert = UIAlertController(title: nil , message: alertMsg, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.view.layer.cornerRadius = 8
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alert.dismiss(animated: true)
        }
    }
}
