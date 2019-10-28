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
    func customizeView( view: UIView, crnrRadius: CGFloat, bdrWidth: CGFloat, brdrColor: UIColor)
    func roundView(_ view: UIView)
}


extension CustomizedView {
    
    func customizeView(view: UIView,  crnrRadius: CGFloat = 0, bdrWidth: CGFloat = 0, brdrColor: UIColor = UIColor.black ) {
        view.layer.cornerRadius = crnrRadius
        view.layer.borderWidth  = bdrWidth
        view.layer.borderColor  =  brdrColor.cgColor //UIColor.black.cgColor

    }

    func roundView(_ view: UIView) {
        view.layer.cornerRadius = view.frame.width/2
        view.layer.masksToBounds = false
    }
}

@IBDesignable
class  CustomButton: UIButton {
    
//    func customizeBtn() {
    @IBInspectable  var cornerRadius : Double = 0
    @IBInspectable var borderWidth : Double = 0
    @IBInspectable var borderColor: UIColor = UIColor.init()
}

