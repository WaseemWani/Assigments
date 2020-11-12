//
//  CardDetailsCollectionViewCell.swift
//  HorizontalCarousel
//
//  Created by Waseem Wani on 03/11/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

class CardDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cardValidityLabel: UILabel!
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with data: CarouselCollectionCellDataSource) {
        self.cardNumberLabel.text = data.cardNumber
        self.cardValidityLabel.text = data.cardValidity
    }
}
