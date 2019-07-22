//
//  File.swift
//  Employees World
//
//  Created by Waseem Wani on 28/05/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorViewProtocol {
    func showErrorView(onView superView: UIView, _ errDescription: String, _ image: UIImage, retryBtnText: String)
    func hideErrorView()
    func refreshScreen()
}

extension ErrorViewProtocol where Self : UIViewController  {
    
    func showErrorView(onView superView: UIView, _ errDescription: String, _ image: UIImage, retryBtnText: String) {
        let view = EmpErrorView.view()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.errLabel.text = errDescription
        view.imageView.image = image
        view.retryButton.titleLabel?.text = retryBtnText
        view.retryButton.setTitle(retryBtnText, for: .normal)
        view.tag = AppConstants.empErrorSubviewTag
        superView.addSubview(view)
        view.delegate = self
    }
    
    func hideErrorView() {
        if let empErrorSubview = view.viewWithTag(AppConstants.empErrorSubviewTag) {
            empErrorSubview.removeFromSuperview()
        }
    }
}


protocol  NIBLoadUIView {
}

extension NIBLoadUIView {
    
    static func view() -> Self {
        let nibName = String(describing: self)
        let nib =   UINib(nibName: nibName, bundle: nil)
        let nibObj =   nib.instantiate(withOwner: self, options: nil)
        return nibObj.first as! Self
    }
}

class EmpErrorView: UIView, NIBLoadUIView {
    
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var errLabel: UILabel!
    var delegate: ErrorViewProtocol?
    
    override func awakeFromNib() {
        // write here
    }
    
    @IBAction func retryButtonTapped(_ sender: Any) {
        delegate?.refreshScreen()
    }
}
