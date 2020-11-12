//
//  ViewController.swift
//  HorizontalCarousel
//
//  Created by Waseem Wani on 02/11/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

class CarouselCollectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dashedView: UIView!
    
    var viewmodel: CarouselCollectionViewmodel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewmodel()
        setupTableView()
    }

    private func configureViewmodel() {
        viewmodel = CarouselCollectionViewmodel()
        viewmodel?.registerCells(for: tableView)
    }
    
    private func setupTableView() {
        tableView.delegate = viewmodel
        tableView.dataSource = viewmodel
    }
}

