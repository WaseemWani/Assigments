//
//  StringExtension.swift
//  LumiApp
//
//  Created by Amit Kumar on 04/09/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation

extension String {
    
    /// Localised String
    var localisedString: String {
        return NSLocalizedString(self, comment: "")
    }
    /// This function checks if the string entered is a valid email address
    ///
    /// - Returns: true if email string is valid
    func isValidEmail() -> Bool {
        if let positionOfAtSymbol = self.range(of: "@") {
            let usernameString = self[self.startIndex..<positionOfAtSymbol.lowerBound]
            let acceptableSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_.-")
            if (usernameString as NSString?)?.rangeOfCharacter(from: acceptableSet.inverted).location != NSNotFound {
                return false
            }
            
            let domainString = self[self.index(positionOfAtSymbol.lowerBound, offsetBy: 1)..<self.endIndex]
            let arrOfdot = domainString.components(separatedBy: ".")
            if arrOfdot.count > 2 {
                return false
            }
            if (domainString as NSString?)?.range(of: ".").location == NSNotFound || (domainString as NSString?)?.range(of: "..").location != NSNotFound || (domainString as NSString?)?.range(of: "@").location != NSNotFound {
                return false
            }
            return true
        } else {
            return false
        }
    }
    
    /// This function is used to validate password having special character or not
    ///
    /// - Returns: true/false
    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%&*]).{8}$"
        return !(NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self))
    }
    
    /// This function is used to validate if the text entered is all digits or not
    ///
    /// - Returns: true/false
    func isAllDigits() -> Bool {
        let nonNumbers = CharacterSet(charactersIn: "1234567890").inverted
        let r = (self as NSString).rangeOfCharacter(from: nonNumbers)
        return r.location == NSNotFound
    }
    
    /// This function returns the trimmed string
    ///
    /// - Returns: trimmed string
    func trimmed() -> String {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
    
    /// This function returns text between two specified string
    ///
    /// - Parameters:
    ///   - from: First string
    ///   - to: Second string
    /// - Returns: String between first and second string
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                substring(with: substringFrom..<substringTo)
            }
        }
    }
}
