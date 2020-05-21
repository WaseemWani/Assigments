//
//  BlurVibrancyViewController.swift
//  DarkMode
//
//  Created by Waseem Wani on 10/03/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import UIKit

class BlurVibrancyViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBlurAndVibrancy()
    }
    
    func createBlurAndVibrancy() {
        if #available(iOS 13.0, *) {
            let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            let blurView = configureBlurView(blurEffect)
            blurView.frame = backgroundImageView.frame
            view.addSubview(blurView)

            let vibrancyView = configureVibrancyView(blurEffect)
            vibrancyView.frame = backgroundImageView.frame
            blurView.contentView.addSubview(vibrancyView)

            let vibrantLabel = configureVibrantLabel()
            vibrantLabel.frame = CGRect(x: 30, y: 30, width: self.backgroundImageView.frame.width, height: 30)
            vibrancyView.contentView.addSubview(vibrantLabel)
        } else {
            // Fallback on earlier versions
        }
        
    }

        let blurView = UIVisualEffectView()
        func configureBlurView(_ blurEffect: UIBlurEffect) -> UIVisualEffectView {
            blurView.effect = blurEffect
            return blurView
        }

        let vibrancyView = UIVisualEffectView()
        func configureVibrancyView(_ blurEffect: UIBlurEffect) -> UIVisualEffectView {
            if #available(iOS 13.0, *) {
                let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: .secondaryLabel)
                vibrancyView.effect = vibrancyEffect
            } else {
                // Fallback on earlier versions
            }
            return vibrancyView
        }
        
        let vibrantLabel = UILabel()
        func configureVibrantLabel() -> UILabel {
            vibrantLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: self.traitCollection)
            vibrantLabel.text = "Vibrant Label"
            if #available(iOS 13.0, *) {
                vibrantLabel.textColor = .label
            } else {
                vibrantLabel.textColor = .gray
            }
            return vibrantLabel
        }
}
