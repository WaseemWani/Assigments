//
//  UIViewExtension.swift
//  HorizontalCarousel
//
//  Created by Waseem Wani on 06/11/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addDashedBorder(dashColor: UIColor = .black, dashThickness: CGFloat = 1.0, dashLength: Int, dashesSpace: Int) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = dashColor.cgColor
        shapeLayer.lineDashPattern = [dashLength, dashesSpace] as [NSNumber]
        shapeLayer.lineWidth = dashThickness
        shapeLayer.frame = self.bounds
        shapeLayer.fillColor = nil
        shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(shapeLayer)
    }
}
