//
//  EmployeesListViewController.swift
//  DarkModeDemo
//
//  Created by Waseem Wani on 10/02/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

class EmployeesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var empData =  EmployeeDataModel()
    var dbdata = [EmployeeData]()
    var isFetchedFromDB = false
    var viewModel: EmployeesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeProvider.register(observer: self)
        self.navigationItem.title = "Employees"
        configureViewModel()
        configureTableView()
        viewModel?.fetchEmployeesData()
    }
    
    private func configureViewModel() {
        viewModel = EmployeesListViewModel()
        viewModel?.delegate = self
    }
    
    private func configureTableView() {
        viewModel?.registerCells(for: tableView)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
}

extension EmployeesListViewController: Themeable {
    func apply(theme: Theme) {
        self.view.backgroundColor = theme.backgroundColor
        self.navigationController?.navigationBar.barTintColor = theme.backgroundColor
        let textAttributes = [NSAttributedString.Key.foregroundColor: theme.textColor]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        tableView.backgroundColor = theme.backgroundColor
        activityIndicator.color = theme.descriptionTextColor
    }
}

extension EmployeesListViewController: EmployeesListViewModelDelegate {
    func showHideTableView(show: Bool) {
        if show == true {
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
        }
    }
    
    func showHideLoader(show: Bool) {
        if show == true {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else{
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    func updateTableView() {
        tableView.reloadData() 
    }
    
    func showToast(with msg: String) {
        self.showToast(withMsg: "error in fetching data. \(msg)")
    }
}
