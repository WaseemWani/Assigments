//
//  ImageViewController.swift
//  DarkMode
//
//  Created by Waseem Wani on 10/03/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeProvider.register(observer: self)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
//            overrideUserInterfaceStyle = .dark
            imageView?.overrideUserInterfaceStyle = .dark
//            imageView.overrideUserInterfaceStyle = .light
        }
    }
}

extension ImageViewController: Themeable {
    func apply(theme: Theme) {
        self.view.backgroundColor = theme.backgroundColor
        titleLabel.textColor = theme.textColor
    }
}
