//
//  BottomCellforGender.swift
//  RegistrationModule
//
//  Created by Waseem Wani on 22/10/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//

import UIKit

class BottomCellforGender: UITableViewCell {

    @IBOutlet weak var IamLabel: UILabel!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addBorder(to: maleButton)
        addBorder(to: femaleButton)
    }
    
    func addBorder(to view: UIView) {
        
        view.layer.borderWidth = 1.3
        view.layer.borderColor = UIColor.lumiGreyColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func maleButtonTapped(_ sender: Any) {
        
        maleButton.backgroundColor = .appTextColor
        femaleButton.backgroundColor = .clear
    }
    
    @IBAction func femaleButtonTapped(_ sender: Any) {
        
        femaleButton.backgroundColor = .appTextColor
        maleButton.backgroundColor = .clear
    }
    
}
