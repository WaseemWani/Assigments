//
//  Theme.swift
//  DarkModeDemo
//
//  Created by Waseem Wani on 10/02/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import Foundation
import UIKit

struct Theme: Equatable {
    static let light = Theme(type: .light, colors: .light)
    static let dark = Theme(type: .dark, colors: .dark)
    @available(iOS 13.0, *)
    static let adaptive = Theme(type: .adaptive, colors: .adaptive)

    enum ThemeType {
        case light
        case dark
        @available(iOS 13.0, *)
        case adaptive
    }
    
    let type: ThemeType
    

    let backgroundColor: UIColor
    let textColor: UIColor
    let descriptionTextColor: UIColor

    let separatorColor: UIColor
    let tableViewBackground: UIColor

    let navbarTintColor: UIColor
    let navbarStyle: UIBarStyle
    let buttonBackGroundColor: UIColor
    let switchTintColor: UIColor

    init(type: ThemeType, colors: ColorPalette) {
        self.type = type
        self.backgroundColor = colors.background
        self.textColor = colors.foreground
        self.descriptionTextColor = colors.secondary
        self.separatorColor = colors.secondary
        self.tableViewBackground = colors.secondaryBackground
        self.navbarTintColor = colors.tint
        self.navbarStyle = type == .dark ? .black : .default
        self.switchTintColor = colors.tint
        self.buttonBackGroundColor = colors.buttonBackGroundColor
    }

    public static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.type == rhs.type
    }
    
}
