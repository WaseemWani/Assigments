//
//  LALabelHeaderView.swift
//  LumiApp
//
//  Created by Amit Kumar on 10/10/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class LALabelHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomSepratorView: UIView!
    @IBOutlet weak var titleLabelLeadingSpace: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    var titleFont: UIFont {
//      return .getDynamicFont(font: .book, size: kFontSize12)
//    }
    
    func configureExtrasHeaderViewWith(titleString: String?, titleTextColor: UIColor?, isSepratorRequired: Bool?) {
        if let separatorRequired = isSepratorRequired {
            self.bottomSepratorView.isHidden = !separatorRequired
        } else {
            self.bottomSepratorView.isHidden = false
        }
//        self.titleLabel.configure(text: titleString, textColor: titleTextColor, font: titleFont)
    }

    func updateTitleLeadingSpace(leadingConstant: CGFloat) {
        self.titleLabelLeadingSpace.constant = leadingConstant
    }

    static var identifier: String {
           return String(describing: self)
    }
    
}
