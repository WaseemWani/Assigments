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
    
    /// This function creates a blur effect view with vibrancy over it and addes a label in vibrancy view to display vibrant text over blur view
    func createBlurAndVibrancy() {
        var blurEffect = UIBlurEffect()
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        } else {
            blurEffect = UIBlurEffect(style: .light)
        }
        let blurView = configureBlurView(blurEffect)
        blurView.frame = backgroundImageView.frame
        view.addSubview(blurView)
        
        let vibrancyView = configureVibrancyView(blurEffect)
        vibrancyView.frame = backgroundImageView.frame
        blurView.contentView.addSubview(vibrancyView)
        
        let vibrantLabel = configureVibrantLabel()
        vibrantLabel.frame = CGRect(x: 30, y: 30, width: self.backgroundImageView.frame.width, height: 30)
        vibrancyView.contentView.addSubview(vibrantLabel)
        
    }
    
    /// This function creates blurview
    let blurView = UIVisualEffectView()
    func configureBlurView(_ blurEffect: UIBlurEffect) -> UIVisualEffectView {
        blurView.effect = blurEffect
        return blurView
    }
    
    /// This funciton creates a vibrant view
    let vibrancyView = UIVisualEffectView()
    func configureVibrancyView(_ blurEffect: UIBlurEffect) -> UIVisualEffectView {
        if #available(iOS 13.0, *) {
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: .secondaryLabel)
            vibrancyView.effect = vibrancyEffect
        } else {
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            vibrancyView.effect = vibrancyEffect
        }
        return vibrancyView
    }
    
    
    /// This function creates label to display vibrant text on blur view
    let vibrantLabel = UILabel()
    func configureVibrantLabel() -> UILabel {
        vibrantLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: self.traitCollection)
        vibrantLabel.text = "Vibrant Label"
        if #available(iOS 13.0, *) {
            vibrantLabel.textColor = .label
        } else {
            vibrantLabel.textColor = .black
        }
        return vibrantLabel
    }
}
