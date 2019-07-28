//
//  CustomizedView.swift
//  LoginSample
//
//  Created by Waseem Wani on 28/07/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//

import Foundation
import UIKit

protocol CustomizedView {
    
    func customizeView(view: UIView,  crnrRadius: Float, bdrWidth: Float, brdrClr: UIColor, alphaValue: CGFloat)
    func roundView(_ view: UIView, _ borderWidth: Float, _ borderClr: UIColor)
    func addShadow(view: UIView, opacity: Float, colr: UIColor )
}

extension CustomizedView {
    
    func customizeView(view: UIView, crnrRadius: Float = 0,  bdrWidth: Float = 0, brdrClr: UIColor = UIColor.black, alphaValue: CGFloat = 1 ) {
        
        view.layer.cornerRadius = CGFloat(crnrRadius)
        view.layer.borderWidth  = CGFloat(bdrWidth)
        view.layer.borderColor  = brdrClr.cgColor
        view.alpha = alphaValue
    }
    
    func roundView(_ view: UIView, _ borderWidth: Float = 0, _ borderClr: UIColor = .white) {
        
        view.layer.cornerRadius = view.frame.width/2
        view.layer.borderWidth = CGFloat(borderWidth)
        view.layer.borderColor = borderClr.cgColor
        view.layer.masksToBounds = true
    }
    
    func addShadow(view: UIView, opacity: Float, colr: UIColor ) {
        
        view.layer.shadowOpacity = opacity
        view.layer.shadowColor = colr.cgColor
    }
    
}
