//
//  HomeViewController.swift
//  DarkMode
//
//  Created by Waseem Wani on 10/03/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attributedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if #available(iOS 13.0, *) {
//            overrideUserInterfaceStyle = .light
//        }
        
        themeProvider.register(observer: self)
        configureAttributedLabel()
    }
    
    @IBAction func learnMoreButtonTapped(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "BlurVibrancyViewController") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func configureAttributedLabel() {
        let attributedString = NSMutableAttributedString(string: "Attributed Text")
//        if #available(iOS 13.0, *) {
            let firstAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.underlineStyle: 2.0,
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)
                //NSAttributedString.Key.underlineColor: UIColor.black,
            ]
            attributedString.addAttributes(firstAttributes, range: NSRange(location: 0, length: "Attributed Text".count))
            attributedLabel.attributedText = attributedString
//        } else {
//            // Fallback on earlier versions
//        }
    }
}

extension HomeViewController: Themeable {
    func apply(theme: Theme) {
//        self.descriptionLabel.textColor = UIColor(named: "dynamicTextColor")
//        self.titleLabel.textColor = UIColor()
        self.navigationController?.navigationBar.barTintColor = theme.backgroundColor
        self.view.backgroundColor = theme.backgroundColor
    }
}
