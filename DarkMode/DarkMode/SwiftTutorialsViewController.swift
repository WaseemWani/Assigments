//
//  SwiftTutorialsViewController.swift
//  DarkModeDemo
//
//  Created by Waseem Wani on 10/02/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

struct TableDataSource {
    var title: String
    var description: String
}

class SwiftTutorialsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [TableDataSource]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Swift Tutorials"
        prepareDataSource()
        configureTableView()
        themeProvider.register(observer: self)
    }
    
    @objc func settingsTapped() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib.init(nibName: "SwiftTutorialsTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SwiftTutorialsTableCell")
    }
    
    private func prepareDataSource() {
        dataSource = [TableDataSource(title: "Collection Types", description: "Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values."),
                      TableDataSource(title: "Structures and Classes", description: "Structures and classes are general-purpose, flexible constructs that become the building blocks of your program’s code."),
                      TableDataSource(title: "Protocols", description: "A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality."),
                      TableDataSource(title: "Enumerations", description: "An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code."),
                      TableDataSource(title: "Functions", description: "Functions are self-contained chunks of code that perform a specific task. "),
                      TableDataSource(title: "Control Flow", description: "Swift provides a variety of control flow statements. These include while loops to perform a task multiple times; if, guard, and switch statements.")]
    }
}

extension SwiftTutorialsViewController: UITableViewDelegate {
}

extension SwiftTutorialsViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwiftTutorialsTableCell") as? SwiftTutorialsTableCell
        cell?.configureCell(with: dataSource[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension SwiftTutorialsViewController: Themeable {
    func apply(theme: Theme) {
        self.view.backgroundColor = theme.backgroundColor
        self.navigationController?.navigationBar.barTintColor = theme.backgroundColor
        let textAttributes = [NSAttributedString.Key.foregroundColor: theme.textColor]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        tableView.backgroundColor = theme.backgroundColor
    }
}
