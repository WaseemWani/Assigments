//
//  TableViewCell.swift
//  RegistrationModule
//
//  Created by Waseem Wani on 20/10/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var infoCellTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        infoCellTextField.useUnderLine
//        infoCellTextField.useUnderLine
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        var frameRect: CGRect =  infoCellTextField.frame
//        frameRect.size.height = 50
//        infoCellTextField.frame = frameRect

        // Configure the view for the selected state
    }
}

extension UITextField {

    func useUnderLine() {

        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.systemGray2.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

