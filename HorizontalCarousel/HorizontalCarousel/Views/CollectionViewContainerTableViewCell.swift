//
//  CollectionViewContainerTableViewCell.swift
//  HorizontalCarousel
//
//  Created by Waseem Wani on 03/11/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

private let kNumberOfCells = 10

class CollectionViewContainerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardContainerCollectionView: UICollectionView!
    var dataSource = [CarouselCollectionCellDataSource]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        registerCollectionCell()
        prepareCollectionCell()
    }
    
    func setupCell() {
        cardContainerCollectionView.delegate = self
        cardContainerCollectionView.dataSource = self
        cardContainerCollectionView.showsHorizontalScrollIndicator = false
        cardContainerCollectionView.backgroundColor = .green
        let layout = ZoomAndSnapFlowLayout()
        cardContainerCollectionView.collectionViewLayout = layout
        
    }
    
    func registerCollectionCell() {
        let nib = UINib.init(nibName: "CardDetailsCollectionViewCell", bundle: nil)
        cardContainerCollectionView.register(nib, forCellWithReuseIdentifier: "CardDetailsCollectionViewCell")
    }
    
    private func prepareCollectionCell() {
        dataSource = [CarouselCollectionCellDataSource(cardNumber: "12917391273912391", cardValidity: "09/23"), CarouselCollectionCellDataSource(cardNumber: "1232163823741312", cardValidity: "11/21"), CarouselCollectionCellDataSource(cardNumber: "12917391273912391", cardValidity: "09/23"), CarouselCollectionCellDataSource(cardNumber: "1232163823741312", cardValidity: "11/21")]
    }
}


extension CollectionViewContainerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardDetailsCollectionViewCell", for: indexPath) as? CardDetailsCollectionViewCell {
            cell.configureCell(with: dataSource[indexPath.item])
            
            // add dashed border to cell, if it is last one
            if indexPath.item == dataSource.count - 1 {
                cell.containerView.addDashedBorder(dashColor: .black, dashThickness: 1, dashLength: 3, dashesSpace: 2)
                cell.containerView.backgroundColor = .clear
            } else {
                cell.containerView.addDashedBorder(dashColor: .clear, dashThickness: 0, dashLength: 0, dashesSpace: 0)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
