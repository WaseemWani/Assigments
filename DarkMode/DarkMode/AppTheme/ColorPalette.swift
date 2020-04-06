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
    @DynamicColor var secondaryBackground: UIColor
    @DynamicColor var primary: UIColor
    @DynamicColor var secondary: UIColor
    @DynamicColor var complementary: UIColor
    @DynamicColor var tint: UIColor
    let buttonBackGroundColor: UIColor

    static let light: ColorPalette = .init(
        foreground: .black,
        background: .white,
        secondaryBackground: .init(light: .groupTableViewBackground, dark: .groupTableViewBackground) ,
        primary: .init(light: UIColor(hue: 0.635, saturation: 0.101, brightness: 0.2, alpha: 1), dark: UIColor(hue: 0.635, saturation: 0.101, brightness: 0.2, alpha: 1)),
        secondary: .init(light: UIColor(white: 0.4, alpha: 1.0), dark: UIColor(white: 0.4, alpha: 1.0)),
        complementary: .init(light: UIColor(white: 0.35, alpha: 1.0), dark: UIColor(white: 0.35, alpha: 1.0)),
        tint: .init(light: UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1), dark: UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1)),
        buttonBackGroundColor: .red
    )

    static let dark: ColorPalette = .init(
        foreground: .white,
        background: .black,
        secondaryBackground: .init(light: UIColor(white: 0.15, alpha: 1.0), dark: UIColor(white: 0.15, alpha: 1.0)),
        primary: .init(light: UIColor(hue:0.121, saturation:0.144, brightness:0.793, alpha:1), dark: UIColor(hue:0.121, saturation:0.144, brightness:0.793, alpha:1)),
        secondary: .init(light: UIColor(white: 0.6, alpha: 1.0), dark: UIColor(white: 0.6, alpha: 1.0)),
        complementary: .init(light: UIColor(white: 0.81, alpha: 1.0), dark: UIColor(white: 0.81, alpha: 1.0)),
        tint: .init(light: UIColor(hue:0.129, saturation:0.702, brightness:0.992, alpha:1), dark: UIColor(hue:0.129, saturation:0.702, brightness:0.992, alpha:1)),
        buttonBackGroundColor: .red
    )

    @available(iOS 13.0, *)
    static let adaptive: ColorPalette = .init(
        foreground: .label,
        background: .systemBackground,
        secondaryBackground: .init(light: .groupTableViewBackground, dark: UIColor(white: 0.15, alpha: 1.0)),
        primary: .init(light: UIColor(hue: 0.635, saturation: 0.101, brightness: 0.2, alpha: 1), dark: UIColor(white: 0.6, alpha: 1.0)),
        secondary: .init(light: UIColor(white: 0.4, alpha: 1.0), dark: UIColor(white: 0.35, alpha: 1.0)),
        complementary: .init(light: UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1), dark: UIColor(hue:0.129, saturation:0.702, brightness:0.992, alpha:1)),
        tint: .init(light: UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1), dark: UIColor(hue:0.129, saturation:0.702, brightness:0.992, alpha:1)),
        buttonBackGroundColor: .systemRed
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
            @unknown default:
                fatalError()
            }
        } else {
            return light
        }
    }
}
