//
//  customView.swift
//  Employees World
//
//  Created by Waseem Wani on 23/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

//import Foundation
import UIKit

protocol CustomizedView {
    func customizeView(_ view: UIView   /*, _ crnrRadius: Float, _ bdrWidth: Float */)
    func roundView(_ view: UIView)
}


extension CustomizedView {
    
    func customizeView(_ view: UIView /*, _ crnrRadius: Float = 0, _ bdrWidth: Float = 0*/) {
        view.layer.cornerRadius = 10
        view.layer.borderWidth  = 1
        view.layer.borderColor  = UIColor.black.cgColor

    }

    func roundView(_ view: UIView) {
        view.layer.cornerRadius = view.frame.width/2
        view.layer.masksToBounds = false
    }
}

//@IBDesignable
class  CustomButton: UIButton {
    
//    func customizeBtn() {
    @IBInspectable  var cornerRadius : Double = 0
    @IBInspectable var borderWidth : Double = 0
    @IBInspectable var borderColor: UIColor = UIColor.init()
}

