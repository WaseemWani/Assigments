//
//  Themeable.swift
//  DarkModeDemo
//
//  Created by Waseem Wani on 10/02/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import Foundation
import UIKit

protocol Themeable: class {
    func apply(theme: Theme)
}

extension Themeable where Self: UITraitEnvironment {
    var themeProvider: ThemeProvider {
        if #available(iOS 13.0, *) {
            return DefaultThemeProvider.shared
        } else {
            return LegacyThemeProvider.shared
        }
    }
}
