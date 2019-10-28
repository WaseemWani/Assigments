//
//  UIViewExtension.swift
//  LumiApp
//
//  Created by Amit Kumar on 04/09/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// this method loads the nib
    ///
    /// - Returns: loads the nib
    class func fromNib<T: UIView>() -> T? {
        if let bundle = Bundle.main.loadNibNamed(String(describing: T.self), owner: T.self, options: nil)?.first {
            return bundle as? T
        }
        return nil
    }
    
    /// Function to add corner radius
    ///
    /// - Parameters:
    ///   - corners: corners
    ///   - radius: radius
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// Function to set view constraint
    ///
    /// - Parameter container: view
    func fixInView(_ container: UIView!) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container,
                           attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container,
                           attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container,
                           attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container,
                           attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.bounds.size.width - width, y: 0, width: width, height: self.bounds.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.bounds.size.height - width, width: self.bounds.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.bounds.size.height)
        self.layer.addSublayer(border)
    }
    
    func fillParentView(_ edgeInsets: UIEdgeInsets = UIEdgeInsets.zero) {
        guard let parentView = superview else { return }
        removeAllConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.topAnchor, constant: edgeInsets.top),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -edgeInsets.bottom),
            leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: edgeInsets.left),
            rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -edgeInsets.right)
            ])
    }
    
    func alignLeft(_ edgeInsets: UIEdgeInsets = UIEdgeInsets.zero) {
        guard let parentView = superview else { return }
        removeAllConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        var left = leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: edgeInsets.left)
        var right = rightAnchor.constraint(lessThanOrEqualTo: parentView.rightAnchor, constant: -edgeInsets.right)
//        if !UIApplication.isLTR {
//            left = leftAnchor.constraint(greaterThanOrEqualTo: parentView.leftAnchor, constant: edgeInsets.left)
//            right = rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -edgeInsets.right)
//        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.topAnchor, constant: edgeInsets.top),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -edgeInsets.bottom),
            left,
            right
            ])
        layoutIfNeeded()
    }
    
    func alignRight(_ edgeInsets: UIEdgeInsets = UIEdgeInsets.zero) {
        guard let parentView = superview else { return }
        removeAllConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        var left = leftAnchor.constraint(greaterThanOrEqualTo: parentView.leftAnchor, constant: edgeInsets.left)
        var right = rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -edgeInsets.right)
//        if !UIApplication.isLTR {
//            left = leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: edgeInsets.left)
//            right = rightAnchor.constraint(lessThanOrEqualTo: parentView.rightAnchor, constant: -edgeInsets.right)
//        }
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.topAnchor, constant: edgeInsets.top),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -edgeInsets.bottom),
            left,
            right])
        layoutIfNeeded()
    }
    
    func alignCenter() {
        guard let parentView = superview else { return }
        removeAllConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.topAnchor),
            bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            rightAnchor.constraint(lessThanOrEqualTo: parentView.rightAnchor),
            leftAnchor.constraint(greaterThanOrEqualTo: parentView.leftAnchor),
            centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            centerYAnchor.constraint(equalTo: parentView.centerYAnchor)
            ])
    }
    
    func removeAllConstraints() {
        guard let parentView = superview else { return }
        let appliedConstraints = parentView.constraints.filter { $0.firstItem as? UIView == self || $0.secondItem as? UIView == self }
        removeConstraints(appliedConstraints)
        parentView.removeConstraints(appliedConstraints)
    }
    
    func dashedBorder() {
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.bounds = self.bounds
        yourViewBorder.strokeColor = UIColor.black.cgColor
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.lineJoin = CAShapeLayerLineJoin.bevel
        yourViewBorder.frame = self.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(yourViewBorder)
    }
    // MARK: Add Shadow to view
    /// To add shadow to any specific view ,
    ///
    /// - Parameters:
    ///   - edges: BorderEdge: user can send topIn, topOut, left, bottom, right option
    ///   - radius: height for shadow
    ///   - color: shadow start color
//    func addShadow(to edges: [BorderEdge], radius: CGFloat = 12.0, color: CGColor = UIColor.lumiDarkGreyColor.cgColor) {
//        self.removeGradientLayer()
//        let fromColor = color
//        let toColor = UIColor.white.cgColor
//        let viewFrame = self.bounds
//        for edge in edges {
//            let gradientLayer = CAGradientLayer()
//            gradientLayer.colors = [fromColor, toColor]
//            gradientLayer.opacity = 0.2
//
//            switch edge {
//            case .topIn:
//                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
//                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
//                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius)
//            case .topOut:
//                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
//                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
//                gradientLayer.frame = CGRect(x: 0.0, y: 0, width: viewFrame.width, height: 0 - radius)
//            case .bottom:
//                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
//                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
//                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
//            case .bottomOut:
//                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
//                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
//                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height, width: viewFrame.width, height: radius)
//            case .left:
//                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius, height: viewFrame.height)
//            case .right:
//                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
//                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
//                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius, height: viewFrame.height)
//
//            case .none:
//                gradientLayer.colors = nil
//                gradientLayer.opacity = 0.0
//            }
//            self.layer.addSublayer(gradientLayer)
//        }
//    }
    
    /// This function is used to remove gradient layer from the view
    func removeGradientLayer() {
        let gradientsArray = self.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
        guard let gradients = gradientsArray else {
            return
        }
        for gradient in gradients {
            gradient.removeFromSuperlayer()
        }
    }
    
    /// Function to find parent View controller
    ///
    /// - Returns: UIViewController Object
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    func setBorder(borderColor: UIColor, borderWidth: CGFloat) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}
