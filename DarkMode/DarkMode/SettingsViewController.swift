//
//  SettingsViewController.swift
//  DarkModeDemo
//
//  Created by Waseem Wani on 12/02/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var switchActionDescriptionLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        themeProvider.register(observer: self)
    }
    
    private func initialSetup() {
        self.title = "SETTINGS"
        switchActionDescriptionLabel.text = "Dark Theme"
    }
    
    @IBAction func switchTheme(_ sender: Any) {
        themeProvider.toggleTheme()
    }
}

extension SettingsViewController: Themeable {
    func apply(theme: Theme) {
        self.navigationController?.navigationBar.barTintColor = theme.backgroundColor
        let textAttributes = [NSAttributedString.Key.foregroundColor: theme.textColor]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.view.backgroundColor = theme.backgroundColor
        switchActionDescriptionLabel.textColor = theme.textColor
        themeSwitch.onTintColor = theme.switchTintColor
        themeSwitch.isOn = theme == .dark
    }
}
