//
//  ENUtility.swift
//  GENDB
//
//  Created by Disha Jain on 22/06/19.
//  Copyright © 2019 Disha Jain. All rights reserved.
//

import Foundation
import UIKit
import MapKit

enum LAFleetListCategory: Int {
    case Premium = 20
    case Economy = 19
    case Compact = 23
    case Suv = 21
    case People = 22
    case AllCars = 1000
    
    var getColors: UIColor? {
        switch self {
        case .Premium:
            return .lumiDeepLavender
        case .Economy:
            return .lumiDuskBlue
        case .Compact:
            return .lumiButterScotch
        case .Suv:
            return .lumiFadedBlue
        case .People:
            return .lumiPinkishOrange
        default:
            return nil
        }
    }
    
    var getIcon: UIImage? {
        switch self {
        case .Premium, .Suv, .People:
            return UIImage(imageLiteralResourceName: "premium_car_logo")
        case .Economy, .Compact:
            return UIImage(imageLiteralResourceName: "economy_car_logo")
        default:
            return nil
        }
    }
    
    var getImage: UIImage? {
        switch self {
        case .AllCars:
            return UIImage(named: "Car_Class_All")
        case .Premium:
            return UIImage(named: "Car_Class_Premium")
        case .Economy:
            return UIImage(named: "Car_Class_Economy")
        case .Compact:
            return UIImage(named: "Car_Class_Economy")
        case .Suv:
            return UIImage(named: "Car_Class_SUV")
        case .People:
            return UIImage(named: "Car_Class_PeopleMover")
        default:
            return nil
        }
    }
}
/// This struct defines the constans used in the project
internal struct LAConstants {
    internal static let kMaxDigitsForPrepaidMobile = 10
    internal static let imageViewWidth: CGFloat = 44.0
    internal static let leadingPadding: CGFloat = 16.0
    internal static let kMaxDigitsForNationalID: CGFloat = 16.0

}

/// Utility class for the app
class LAUtility: NSObject {
    /// This method is used to show an alert view on the screen
    ///
    /// - Parameters:
    ///   - withTitle: alert title
    ///   - withMessage: alert message
    ///   - onViewController: view controller on which to show
    ///   - actions: actions of buttons in alert
    static func showErrorAlert(withTitle: String, withMessage: String, actions: (() -> Void?)?) {
        DispatchQueue.main.async {
            
            let alertController = UIAlertController(title: withTitle, message: withMessage, preferredStyle: UIAlertController.Style.alert)
            
            let dismissAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ -> Void in
                if let acc = actions {
                    acc()
                }
            }
            
            alertController.addAction(dismissAction)
            getTopMostViewController()?.present(alertController, animated: true, completion: nil)
            alertController.view.accessibilityIdentifier = "custom_alert"
            alertController.view.accessibilityValue = "\(withMessage)"
        }
    }
    
    /// This function is used to format the emirate ID card number
    ///
    /// - Parameter idCardString: id card number
    /// - Returns: formatted string of card number
    static func modifyEmirateCardString(idCardString: String) -> String {
        let trimmedString = idCardString.components(separatedBy: "-").joined()
        let arrOfCharacters = Array(trimmedString)
        var modifiedString = ""
        
        if arrOfCharacters.isEmpty {
            for i in 0...arrOfCharacters.count - 1 {
                modifiedString.append(arrOfCharacters[i])
                if i == 2 || i == 6 || i == 13 {
                    modifiedString.append("-")
                }
            }
        }
        return modifiedString
    }
    
    static func sizeForString(string: String?, font: UIFont?, width: CGFloat?) -> CGSize {
        guard let fontt = font, let str = string else {
            return .zero
        }
        
        let attributedStr = NSAttributedString(string: str, attributes: [NSAttributedString.Key.font: fontt])
        return sizeForAttributedString(attributeString: attributedStr, width: width)
    }
    
    static func sizeForAttributedString(attributeString: NSAttributedString?, width: CGFloat?) -> CGSize {
        guard let attString = attributeString else {
            return .zero
        }
        
        guard let w = width else {
            return .zero
        }
        
        var size = attString.boundingRect(with: CGSize(width: w, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size
        size.width = CGFloat(ceilf(Float(size.width)))
        size.height = CGFloat(ceilf(Float(size.height)))
        return size
    }
    
    static func getDynamicFontBasedOnScreenWidth(withFont font: UIFont) -> UIFont {
        // Font ratio needs to be maintained in ratio (Font in Theme / BaseWidth)
        let newFontSize = (font.pointSize * (self.getScreenSize().width)) / 375.0
        if let newFont = UIFont(name: font.fontName, size: newFontSize) {
            return newFont
        }
        return UIFont.systemFont(ofSize: newFontSize)
    }
    
    static func getScreenSize() -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        return screenSize
    }
    
    static  func getTopMostViewController() -> UIViewController? {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    static func showToast(withMessage message: String) {
//        LAToast.sharedInstance.showToastMessage(message: message)
    }
    
    static func hideToast() {
//        LAToast.sharedInstance.dismissToast()
    }
    
    static func showToastWithDefaultMessage(string: String) {
        showToast(withMessage: "Default Message")
    }
        
    static func getDays(from: Date, to: Date) -> Int {
        let calendar = Calendar.current
        // Replace the hour (time) of both dates with 00:00
        let fromDate = calendar.startOfDay(for: from)
        let toDate = calendar.startOfDay(for: to)
        let components = calendar.dateComponents([.day], from: fromDate, to: toDate)
        
        if let days = components.day {
            return days
        }
        
        return 0
    }
    /// Func to Load LocaL OnBoard JSON
    ///
    /// - Parameter fileName: file Name
    /// - Returns: return Model
    static func loadLocalJsonFile<T: Decodable>(filename fileName: String, completion:@escaping (Result<T, Error>) -> Void) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                completion(.success(jsonData))
            } catch {
                print("error:\(error)")
                completion(.failure(error))
            }
        }
    }
    
    static func setFont(toText: String, with font: UIFont, and color: UIColor, inText completeText: String) -> NSMutableAttributedString {
        let range = (completeText as NSString).range(of: toText)
        let attributedString = NSMutableAttributedString(string: completeText)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        
        return attributedString
    }
    
    /// Function to check for valid string
    ///
    /// - Parameter string: string
    /// - Returns: true/false
    static func isValidString(string: String?) -> Bool {
        if (string == "null") || (string == "<null>") || (string == "(null)") || (string == "") || (string == nil) {
            return false
        }
        return true
    }
    
    /// Function to check for valid url
    ///
    /// - Parameter string: string
    /// - Returns: true/false
    static func validateUrl (urlString: String) -> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
    }
    
    /// Function to use retrieve data from User Default
    ///
    /// - Parameter key: Key from which we have to get data
    /// - Returns: data retrieved from user default
//    static func getDataFromUserDefaultsWith(_ key: String) -> Any? {
//        let data = userDefault.value(forKey: key)
//        return data
//    }
    
    /// Function used to set data in User Default
    ///
    /// - Parameters:
    ///   - data: data which has to be stored
    ///   - key: Key at which data is to be stored
//    static func setDataToUserDefaultsWith(data: Any, _ key: String) {
//        userDefault.set(data, forKey: key)
//    }
//
//    static func getAbsolutePriceMinMax(filterPriceMap: [Int? : LAPriceBoundsModel]) -> LAPriceBoundsModel {
//        let minArray = filterPriceMap.map { _, value -> Int in
//            return value.lowerBound
//        }
//        let maxArray = filterPriceMap.map { _, value -> Int in
//            return value.upperBound
//        }
//        let min = minArray.min()
//        let max = maxArray.max()
//
//        return LAPriceBoundsModel(lowerBound: min ?? 0, upperBound: max ?? 0)
//    }
    
    static func getIntValueFromFloat(value: CGFloat) -> Int {
        return Int(roundf(Float(value)))
    }
    
    /// This function is used to get specs detail of a vehicle group on the basis of it's value key.
    /// - Parameter data: Model of specs
//    static func getSpecsDetailFrom(data: LAVehicleSpecsModel?) -> String {
//        if let valueParameter = data?.value, let nameParameter = data?.specName {
//            if Int(valueParameter) != nil {
//                return (valueParameter + " " + nameParameter)
//            } else if ((data?.value?.caseInsensitiveCompare("Yes".localisedString)) == ComparisonResult.orderedSame) {
//                return nameParameter
//            } else {
//                return valueParameter
//            }
//        }
//        return ""
//    }
    
//    static func openDialerWith(number: String) {
//        if let url = URL(string: "tel://+91\(number)"), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            LAToast.sharedInstance.showToastMessage(message: "Dialer_Not_Supported".localisedString)
//        }
//    }
}

// MARK: Manage App State
//func getAppState() -> String {
//    return userDefault.object(forKey: appState) as? String ?? ""
//}

// MARK: Manage App State
//func getAppLanguage() -> String {
//    return userDefault.object(forKey: appLanguage) as? String ?? ""
//}

/// Function to save app state
///
/// - Parameter appState: app state to be save
//func saveAppState(state: String) {
//    userDefault.set(state, forKey: appState)
//    userDefault.synchronize()
//}

/// Function to save app language
///
/// - Parameter appState: app language to be save
//func saveAppLanguage(selectedLanguage: String) {
//    BrazeManager.sharedInstance.logCustomEvent(.LanguageTracking, withProperties: [BrazeStringConstants.CurrentLanguage: appLanguage])
//    userDefault.set(selectedLanguage, forKey: appLanguage)
//    userDefault.synchronize()
//}

/// Var to check if current device is iPhone or iPad
//var isIphone: Bool {
//    if UIDevice.isDeviceIphone {
//        return true
//    } else {
//        return false
//    }
//}

/// Function to open map with cordinates and location NAme
/// - Parameter branch: branch Data
//func openMapForDirection(branch: LABranchListModel?) {
//    
//    guard let laBranch = branch, let latStr = laBranch.latitude, let longStr = laBranch.longitude, let lat = Double(latStr), let long = Double(longStr) else {
//        LAUtility.showToast(withMessage: "branch_na".localisedString)
//        return
//    }
//    
//    let strr = String(format: "comgooglemaps://?daddr=%f,%f&directionsmode=driving", lat, long)
//    if let inAPPURL = URL(string: strr) {
//        if !UIApplication.shared.canOpenURL(inAPPURL) {
//            //OPEN gmaps in safari
//            guard let currentLocation = LACoreLocationManager.sharedInstance.currentLocation else {
//                LAUtility.showToast(withMessage: "directions_na".localisedString)
//                return
//            }
//            let urlStr = String(format: "https://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&directionsmode=driving", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, lat, long)
//            guard let url = URL(string: urlStr) else {
//                return
//            }
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            } else {
//                LAUtility.showToast(withMessage: "gmaps_na".localisedString)
//            }
//        } else {
//            //OPen in GMAPS APP
//            UIApplication.shared.open(inAPPURL, options: [:], completionHandler: nil)
//        }
//    }
//}

//func check(selectedDay day: String, branchOpenTime openingTime: String?, branchCloseTime closingTime: String?, userSelectedTime selectedTime: String) -> Bool {
//    let commonTimeFormat = LATimeUtility.timeFormatter
//    let currentFormattedTime = commonTimeFormat.date(from: selectedTime)
//
//    let startTime = commonTimeFormat.date(from: openingTime ?? "")
//    let endTime = commonTimeFormat.date(from: closingTime ?? "")
//
//    guard let sTime = startTime, let eTime = endTime, let cTime = currentFormattedTime else {
//        return false
//    }
//    if cTime.isBetween(date: sTime, andDate: eTime) {
//        return true
//    } else {
//        return false
//    }
//}

//func checkForTimeRangeWithBranchForSelected(day selectedWeekDay: String?, _ isInRange: inout Bool, _ time: String, selectedBranch: LABranchListModel?) {
//    switch selectedWeekDay {
//    case "Monday":
//        isInRange = check(selectedDay: "Monday", branchOpenTime: selectedBranch?.openingHours?.monday?.startTime, branchCloseTime: selectedBranch?.openingHours?.monday?.endTime, userSelectedTime: time)
//    case "Tuesday":
//        isInRange = check(selectedDay: "Tuesday", branchOpenTime: selectedBranch?.openingHours?.tuesday?.startTime, branchCloseTime: selectedBranch?.openingHours?.tuesday?.endTime, userSelectedTime: time)
//    case "Wednesday":
//        isInRange = check(selectedDay: "Wednesday", branchOpenTime: selectedBranch?.openingHours?.wednesday?.startTime, branchCloseTime: selectedBranch?.openingHours?.wednesday?.endTime, userSelectedTime: time)
//
//    case "Thursday":
//        isInRange = check(selectedDay: "Thursday", branchOpenTime: selectedBranch?.openingHours?.thursday?.startTime, branchCloseTime: selectedBranch?.openingHours?.thursday?.endTime, userSelectedTime: time)
//
//    case "Friday":
//        isInRange = check(selectedDay: "Friday", branchOpenTime: selectedBranch?.openingHours?.friday?.startTime, branchCloseTime: selectedBranch?.openingHours?.friday?.endTime, userSelectedTime: time)
//
//    case "Saturday":
//        isInRange = check(selectedDay: "Saturday", branchOpenTime: selectedBranch?.openingHours?.saturday?.startTime, branchCloseTime: selectedBranch?.openingHours?.saturday?.endTime, userSelectedTime: time)
//
//    case "Sunday":
//        isInRange = check(selectedDay: "Sunday", branchOpenTime: selectedBranch?.openingHours?.sunday?.startTime, branchCloseTime: selectedBranch?.openingHours?.sunday?.endTime, userSelectedTime: time)
//    default:
//        break;
//    }
//}

//func mapSelectedDayAndStoreDay(selectedDay: String?, store: LABranchListModel?) -> LAStartEndTimeModel? {
//    switch selectedDay {
//    case "Monday":
//        return store?.openingHours?.monday
//    case "Tuesday":
//        return store?.openingHours?.tuesday
//    case "Wednesday":
//        return store?.openingHours?.wednesday
//    case "Thursday":
//        return store?.openingHours?.thursday
//    case "Friday":
//        return store?.openingHours?.friday
//    case "Saturday":
//        return store?.openingHours?.saturday
//    case "Sunday":
//        return store?.openingHours?.sunday
//    default:
//        return nil
//    }
//}
