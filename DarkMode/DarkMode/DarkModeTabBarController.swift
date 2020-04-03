//
//  DarkModeTabBarController.swift
//  DarkMode
//
//  Created by Waseem Wani on 17/02/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

class DarkModeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeProvider.register(observer: self)
    }
}

extension DarkModeTabBarController: Themeable {
    func apply(theme: Theme){
        self.view.backgroundColor = theme.backgroundColor
        tabBar.barTintColor = theme.backgroundColor
    }
}
