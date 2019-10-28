//
//  LADataFormModel.swift
//  LumiApp
//
//  Created by Disha on 20/08/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

enum LACustomerInfoRowType: Int {
    case LACustomerInfoRowTypeFirstName = 0
    case LACustomerInfoRowTypeLastName = 1
    case LACustomerInfoRowTypeEmail = 2
    case LACustomerInfoRowTypeMobile = 3
    case LACustomerInfoRowTypeDOB = 4
    case LACustomerInfoRowTypeIDType = 5
    case LACustomerInfoRowTypeIDNumber = 6
    case LACustomerInfoRowTypeIDExpiry = 7
    case LACustomerInfoRowTypeLicenseID = 8
    case LACustomerInfoRowTypeLicenseExpiry = 9
}

enum LAFeedbackCustomerInfoRowType: Int {
    case LAFeedbackInfoRowTypeFirstName = 0
    case LAFeedbackInfoRowTypeLastName = 1
    case LAFeedbackInfoRowTypeBranch = 2
}


class LACustomerInfoObjectsModel: Codable {
    var data: [LADataFormModel]?
}

class LADataFormModel: NSObject, Codable {
    var isRequired: Bool? = true
    var placeHolder: String? = ""
    var textValue: String? = ""
    var actionUrl: String? = ""
    var isEditable: Bool? = true
    var identifier: String? = ""
    var inputType: String? = ""
    var isValid: Bool? = true
    var url: String? = ""
    var validations: LAFormValidation?
    var rightImage: String?
    var textFieldType: String?
    var arabicPlaceholder: String?
    
    override init() {
        textValue = ""
    }
    
    /// This function validates the user detail model properties
    ///
    /// - Returns: true/false
    func validate() -> Bool? {
        if let textVal = self.textValue, let minVal = self.validations?.min {
            if textVal.count < minVal {
                isValid = false
                return isValid
            }
        } else {
            isValid = false
            return isValid
        }

        if let isMandatory = self.isRequired, let textVal = self.textValue {
            if isMandatory && textVal.isEmpty {
                isValid = false
                return isValid
            }
        } else {
            isValid = false
            return isValid
        }

        if let inputTypeVal = self.inputType, let textVal = self.textValue {
            if inputTypeVal == "EM" && !textVal.isEmpty {
                isValid = textVal.isValidEmail()
                return isValid
            }
//            if inputType == "M" && !textVal.isEmpty && textVal.isAllDigits() && textVal.count == LAConstants.kMaxDigitsForPrepaidMobile {
//                isValid = true
//                return isValid
//            }
//            if inputType == "DatePicker" && !textVal.isEmpty && textFieldType == "dateOfBirth" && validateAgeLimit(birthDayString: textVal) {
//                isValid = true
//                return isValid
//            }
        } else {
            isValid = false
            return isValid
        }
        return isValid
    }
    
//    func validateAgeLimit(birthDayString: String) -> Bool {
////        guard let birthDay = LATimeUtility.getDateFormatterForDOB().date(from: birthDayString) else {
////            LAUtility.showToast(withMessage: "Please select Date of birth")
////            return false
////        }
//        let todayDate = Date()
//        guard let dateDiff = Calendar.current.date(byAdding: .year, value: 21, to: birthDay) else {
//            LAUtility.showToast(withMessage: "Could not calculate date difference")
//            return false
//        }
//
//        if dateDiff <= todayDate {
//            return true
//        } else {
//            LAUtility.showToast(withMessage: "Date should be above 21")
//            return false
//        }
//    }
}

//IF required, have a separate class for validation object
class LAFormValidation: NSObject, Codable {
    var errorMessage: String? = ""
    var validationRegex: String? = ""
    var min: Int? = 0
    var max: Int? = 0
}
