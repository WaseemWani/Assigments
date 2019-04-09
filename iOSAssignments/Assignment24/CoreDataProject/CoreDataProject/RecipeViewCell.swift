//
//  RecipeViewCell.swift
//  CoreDataProject
//
//  Created by Waseem Wani on 07/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class RecipeViewCell: UITableViewCell {

    @IBOutlet weak var recNameLabel: UILabel!
    @IBOutlet weak var recCategorylabel: UILabel!
    @IBOutlet weak var recMadeByLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
