//
//  UIColorExtension.swift
//  LumiApp
//
//  Created by Amit Kumar on 04/09/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation
import UIKit

func RGB(red: Int, green: Int, blue: Int) -> UIColor {
    return UIColor(red: red, green: green, blue: blue)
}

func CenteredOrigin(_ x: CGFloat, _ y: CGFloat) -> CGFloat {
    return floor((x - y) / 2.0)
}

func GRAY(white: CGFloat) -> UIColor {
    return UIColor(white: white, alpha: 1)
}

@nonobjc extension UIColor {
    convenience
    init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff)
    }
    
    static var lumiBlack12: UIColor {
        return UIColor(white: 0.0, alpha: 0.12)
    }

    static var lumiOffWhite: UIColor {
        return UIColor(red: 249, green: 255, blue: 237)
    }
    
    static var lumiWarmGrey: UIColor {
        return UIColor(red: 153, green: 153, blue: 153)
    }
    
    static var lumiBrownishGrey: UIColor {
        return UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.0)
    }
    
    static var lumiGreyishBrown: UIColor {
        return UIColor(red: 60, green: 60, blue: 60)
    }
    
    static var lumiCharcoalGrey: UIColor {
        return UIColor(red: 75, green: 75, blue: 82)
    }
    
    static var lumiSideTableBackgroundColor: UIColor {
        return UIColor(red: 242, green: 244, blue: 246)
    }
    
    static var lumiGreenThemeColor: UIColor {
        return UIColor(red: 147, green: 213, blue: 0)
    }
    
    static var lumiPinkishGrey: UIColor {
        return UIColor(red: 209, green: 209, blue: 209)
    }
    
    static var lumiToolBarGreyColor: UIColor {
        return UIColor(red: 200, green: 200, blue: 200)
    }
    
    static var lumiBlueThemeColor: UIColor {
        return UIColor(red: 0, green: 48, blue: 87)
    }
    
    static var lumiSliderLightGreyThemeColor: UIColor {
        return UIColor(red: 240, green: 240, blue: 240)
    }
    
    static var lumiPurpleColor: UIColor {
           return UIColor(red: 121, green: 80, blue: 160)
    }
      
    static var lumiBlackThemeColor: UIColor {
        return UIColor(red: 34, green: 34, blue: 34)
    }
    
    static var lumiSilverColor: UIColor {
        return UIColor(red: 229, green: 231, blue: 232)
    }
    
    static var brownishGreyTwo: UIColor {
        return UIColor(red: 102, green: 102, blue: 102)
    }
    
    static var lumiTableBackgroundColor: UIColor {
        return UIColor(red: 245, green: 245, blue: 245)
    }
    
    static var lumiGreyColor: UIColor {
        return UIColor(red: 218, green: 218, blue: 218)
    }
    
    static var lumiPinkinshGrey: UIColor {
        return UIColor(red: 206, green: 206, blue: 206)
    }
    
    static var lumiDarkGreyColor: UIColor {
        return UIColor(red: 128, green: 128, blue: 128)
    }
    static var lumiBorderColor: UIColor {
        return UIColor(red: 226, green: 226, blue: 226)
    }
    static var lumiBrownishGreyColor: UIColor {
        return UIColor(red: 103, green: 103, blue: 103)
    }
    static var appBlueColor: UIColor {
        return UIColor(red: 4, green: 169, blue: 244)
    }
    
    static var lightBlueGrey: UIColor {
        return UIColor(red: 161, green: 196, blue: 224)
    }
    
    static var lumiLightGreenBackgroundColor: UIColor {
        return UIColor(red: 249, green: 255, blue: 237)
    }
    
    static var appDarkBlueColor: UIColor {
        return UIColor(red: 2, green: 119, blue: 189)
    }
    
    static var appRedColor: UIColor {
        return UIColor(red: 237, green: 28, blue: 36)
    }
    
    static var appGreenColor: UIColor {
        return UIColor(red: 139, green: 195, blue: 74)
    }
    
    static var appDarkOrangeColor: UIColor {
        return UIColor(red: 251, green: 88, blue: 37)
    }
    
    static var lumiDeepLavender: UIColor {
        return UIColor(red: 140, green: 94, blue: 183)
    }
    
    static var lumiDuskBlue: UIColor {
        return UIColor(red: 46, green: 73, blue: 163)
    }
    
    static var lumiRedColor: UIColor {
        return UIColor(red: 176, green: 0, blue: 32)
    }
 
    static var lumiButterScotch: UIColor {
        return UIColor(red: 253, green: 195, blue: 58)
    }
    
    static var lumiFadedBlue: UIColor {
        return UIColor(red: 94, green: 156, blue: 183)
    }
    
    static var lumiPinkishOrange: UIColor {
        return UIColor(red: 253, green: 103, blue: 58)
    }
    
    static var appOffWhiteColor: UIColor {
        return GRAY(white: 0.95)
    }
    static var appMainBGColor: UIColor {
        return GRAY(white: 0.92)
    }
    static var appDisabledGrayColor: UIColor {
        return GRAY(white: 0.85)
    }
    static var appSeparatorColor: UIColor {
        return GRAY(white: 0.84)
    }
    
    static var appGreenTextColor: UIColor {
        return UIColor(red: 0, green: 154, blue: 0)
    }
    static var appDarkTextColor: UIColor {
        return GRAY(white: 0.2)
    }
    static var appDarkGrayColor: UIColor {
        return GRAY(white: 0.4)
    }
    static var appGrayTextColor: UIColor {
        return GRAY(white: 0.5)
    }
    static var appLightGrayColor: UIColor {
        return GRAY(white: 0.6)
    }
    static var appExtraLightGrayColor: UIColor {
        return GRAY(white: 0.8)
    }
    
    static var appTextFieldFontColor: UIColor {
        return  UIColor(red: 34, green: 34, blue: 34) //GRAY(white: 0.1)
    }
    
    static var appTextFieldPlaceholderColor: UIColor {
        return UIColor(red: 178, green: 178, blue: 178) // GRAY(white: 0.6)
    }
    static var appDarkGrayHexColor: UIColor {
        return UIColor(hex: 0x333333)
    }
    static var appGrayHexColor: UIColor {
        return UIColor(hex: 0x666666)
    }
    
    static var lumiTextViewGray: UIColor {
      return UIColor(white: 178.0 / 255.0, alpha: 1.0)
    }
    
    static var lumiRedErrorColor: UIColor {
           return UIColor(red: 176, green: 0, blue: 32)
       }
    static var lumiDeactivatedButtonColor: UIColor {
           return UIColor(red: 204, green: 204, blue: 204)
       }
    static var appTextColor: UIColor {
        return UIColor(red: 0, green: 48, blue: 87)  // 00 48 87
    }
    
    static var viewGreyColor: UIColor {
        return UIColor(red: 250, green: 250, blue: 250)
    }

}
//250 250 250
