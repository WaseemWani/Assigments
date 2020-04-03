//
//  ColorPallete.swift
//  DarkModeDemo
//
//  Created by Waseem Wani on 10/02/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import Foundation
import UIKit

struct ColorPalette {
    let foreground: UIColor
    let background: UIColor
    let secondaryBackground: UIColor
    let primary: UIColor
    let secondary: UIColor
    let complementary: UIColor
    let tint: UIColor
    let buttonBackGroundColor: UIColor
    @DynamicColor var myColor: UIColor

    static let light: ColorPalette = .init(
        foreground: .black,
        background: .white,
        secondaryBackground: .groupTableViewBackground,
        primary: UIColor(hue: 0.635, saturation: 0.101, brightness: 0.2, alpha: 1),
        secondary: UIColor(white: 0.4, alpha: 1.0),
        complementary: UIColor(white: 0.35, alpha: 1.0),
        tint: UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1),
        buttonBackGroundColor: .red, myColor: .init(light: .black, dark: .green) //UIColor(red: 255, green: 59, blue: 48, alpha: 1)
        
    )

    static let dark: ColorPalette = .init(
        foreground:.white,
        background: .black, //UIColor(white: 0.1, alpha: 1.0),
        secondaryBackground: UIColor(white: 0.15, alpha: 1.0),
        primary: UIColor(hue:0.121, saturation:0.144, brightness:0.793, alpha:1),
        secondary: UIColor(white: 0.6, alpha: 1.0),
        complementary: UIColor(white: 0.81, alpha: 1.0),
        tint: UIColor(hue:0.129, saturation:0.702, brightness:0.992, alpha:1),
        buttonBackGroundColor: .red, myColor: .init(light: .black, dark: .black) //UIColor(red: 255, green: 50, blue: 40, alpha: 1)
    )

    @available(iOS 13.0, *)
    static let adaptive: ColorPalette = .init(
        foreground: UIColor.label,
        background: .systemBackground,
        secondaryBackground: UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .light ? .groupTableViewBackground : UIColor(white: 0.15, alpha: 1.0)
        }),
        primary: UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .light ? UIColor(hue: 0.635, saturation: 0.101, brightness: 0.2, alpha: 1) : UIColor(hue:0.121, saturation:0.144, brightness:0.793, alpha:1)
        }),
        secondary: UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .light ? UIColor(white: 0.4, alpha: 1.0) : UIColor(white: 0.6, alpha: 1.0)
        }),
        complementary: UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .light ? UIColor(white: 0.35, alpha: 1.0) : UIColor(white: 0.81, alpha: 1.0)
        }),
        tint: UIColor(dynamicProvider: { traitCollection in
            return traitCollection.userInterfaceStyle == .light ? UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1) : UIColor(hue:0.129, saturation:0.702, brightness:0.992, alpha:1)
        }),
        buttonBackGroundColor: .systemRed,
        myColor: .init(light: .black, dark: .white)
    )
}

@propertyWrapper struct DynamicColor {
    var light: UIColor
    var dark:  UIColor
    
    init(light: UIColor, dark: UIColor) {
        self.light = light
        self.dark = dark
    }
    
    var wrappedValue: UIColor {
        if #available(iOS 13, *) {
            switch UITraitCollection.current.userInterfaceStyle {
            case .dark:
                return dark
            case .light,.unspecified:
                return light
            }
        } else {
            return UIColor.clear
        }
    }
}
