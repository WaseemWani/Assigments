//
//  CollectionViewCell.swift
//  Employees World
//
//  Created by Waseem Wani on 24/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, CustomizedView {
   
   // @IBOutlet weak var collectionViewcell: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loader.startAnimating()
    }
    
    func showCellSeletectionLabel() {
        selectionLabel.isHidden = false
       
    }
}

//extension CollectionViewCell {
//
//}
