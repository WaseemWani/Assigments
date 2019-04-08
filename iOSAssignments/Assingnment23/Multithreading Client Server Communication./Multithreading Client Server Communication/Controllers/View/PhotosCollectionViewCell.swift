//
//  PhotosCollectionViewCell.swift
//  Multithreading Client Server Communication
//
//  Created by Waseem Wani on 08/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func recieveImage(image: UIImage) {
        
        innerView.isHidden = false
        imageView.isHidden = false
        outerView.isHidden = true
        imageView.image = image
        //authorNameLabel.text = "loading..."
    }
    
    func showAuthorName(authorName: String) {
        
        self.authorNameLabel.text = authorName
    }
}
