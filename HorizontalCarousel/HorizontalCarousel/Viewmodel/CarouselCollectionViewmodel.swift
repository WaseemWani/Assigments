//
//  CarouselCollectionViewmodel.swift
//  HorizontalCarousel
//
//  Created by Waseem Wani on 05/11/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import Foundation
import UIKit

private let kNumberOfCells = 1

class CarouselCollectionViewmodel: NSObject {
    
    func registerCells(for tableView: UITableView) {
        let nib = UINib.init(nibName: "CollectionViewContainerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CollectionViewContainerTableViewCell")
        
    }
}

//// tabel view delegate and datarource methods
extension CarouselCollectionViewmodel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kNumberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewContainerTableViewCell", for: indexPath) as? CollectionViewContainerTableViewCell {
            return cell
        } else {
           return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}
