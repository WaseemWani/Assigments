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
        imageView.addBorder()
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

// extension on UIlabel to do some customization
extension UILabel: Customize {
    func addBorder() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.green.cgColor
    }
}

extension UIImageView: Customize
    {
    func addBorder() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
    }
 }
    

