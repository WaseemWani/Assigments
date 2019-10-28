//
//  LATextFieldCell.swift
//  LumiApp
//
//  Created by Disha Jain on 20/08/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit
//import LanguageManager_iOS

internal struct LATextFieldCellConstants {
    static let kBorderWidth: CGFloat = 10.0
}

protocol LATextFieldCellDelegate: class {
    func LATextFieldCellTextFieldDidEndEditing(_ textField: UITextField, cell: LATextFieldCell)
}

class LATextFieldCell: LABaseTableViewCell {
    weak var delegate: LATextFieldCellDelegate?
    @IBOutlet weak var textField: LATextfieldNew!
    @IBOutlet weak var infoLabel: UILabel!
    //    var dobPickerView: LAPickerView?
    //    var expiryPickerView: LAPickerView?
    //    var categoryPickerView: LAPickerView?
    var showBorder: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textField.showUnderLine = true
        self.backgroundColor = .white
        self.textField.restrictTextPaste = false
        self.textField.setTextFieldMode(mode: LATextFieldMode.floatingMode)
        self.textField.backgroundColor = .white
        self.textField.autocorrectionType = .no
        self.textField.delegate = self
        let pickerFrame = CGRect(x: 0.0, y: 0.0, width: self.bounds.size.width, height: 216.0)
        let maxDateForBirthday = Calendar.current.date(byAdding: .year, value: -21, to: Date())
        //        dobPickerView = LAPickerView(frame: pickerFrame, currentDate: Date(), minDate: nil, maxDate: maxDateForBirthday)
        //        expiryPickerView = LAPickerView(frame: pickerFrame, currentDate: Date(), minDate: Date(), maxDate: nil)
        //        categoryPickerView = LAPickerView(frame: pickerFrame, categories: ["National_ID".localisedString, "Passport".localisedString], currentCategory: 0)
    }
    
    override func layoutSubviews() {
        if showBorder {
            self.addLeftBorderWithColor(color: UIColor.lumiTableBackgroundColor, width: LATextFieldCellConstants.kBorderWidth)
            self.addRightBorderWithColor(color: UIColor.lumiTableBackgroundColor, width: LATextFieldCellConstants.kBorderWidth)
        }
    }
    
    //    fileprivate func setUpPickerViewsWith(delegate: Any?) {
    //        if indexPath.row == LACustomerInfoRowType.LACustomerInfoRowTypeDOB.rawValue {
    ////            self.textField.inputView = self.dobPickerView
    ////            self.dobPickerView?.tag = indexPath.row
    //            if let pickerDelegate = delegate as? LAPickerViewDelegate {
    //                self.dobPickerView?.delegate = pickerDelegate
    //            }
    //        } else if indexPath.row == LACustomerInfoRowType.LACustomerInfoRowTypeIDExpiry.rawValue {
    //            self.textField.inputView = self.expiryPickerView
    //            self.expiryPickerView?.tag = indexPath.row
    //            if let pickerDelegate = delegate as? LAPickerViewDelegate {
    //                self.expiryPickerView?.delegate = pickerDelegate
    //            }
    //        } else if indexPath.row == LACustomerInfoRowType.LACustomerInfoRowTypeIDType.rawValue {
    //            self.textField.inputView = self.categoryPickerView
    //            self.categoryPickerView?.tag = indexPath.row
    //            if let pickerDelegate = delegate as? LAPickerViewDelegate {
    //                self.categoryPickerView?.delegate = pickerDelegate
    //            }
    //        } else if indexPath.row == LACustomerInfoRowType.LACustomerInfoRowTypeLicenseExpiry.rawValue {
    //            self.textField.inputView = self.expiryPickerView
    //            self.expiryPickerView?.tag = indexPath.row
    //            if let pickerDelegate = delegate as? LAPickerViewDelegate {
    //                self.expiryPickerView?.delegate = pickerDelegate
    //            }
    //        } else {
    //            self.textField.inputView = nil
    //        }
    //    }
    
    fileprivate func setUpRightImageView() {
        if let rightImg = self.formItemModel.rightImage, rightImg.isEmpty == false {
            self.textField.rightViewMode = .always
            self.textField.rightView = UIImageView(image: UIImage(named: rightImg))
        } else {
            self.textField.rightViewMode = .never
            self.textField.rightView = nil
        }
    }
    
    //    fileprivate func checkValidationAndUpdateState(_ itemModel: LADataFormModel) {
    //        if let validity = itemModel.isValid, validity == false {
    //            self.infoLabel.text = itemModel.validations?.errorMessage
    //            self.infoLabel.textColor = UIColor.lumiRedErrorColor
    //            self.textField.setUnderLineColor(isError: true)
    //        } else {
    //            self.infoLabel.text = ""
    //            self.infoLabel.textColor = UIColor.lumiRedErrorColor
    //            self.textField.setUnderLineColor(isError: false)
    //        }
    //    }
    
    override func bindData(itemModel: LADataFormModel, delegate: Any?, indexPath: IndexPath) {
        
        super.bindData(itemModel: itemModel, delegate: nil, indexPath: indexPath)
        
        self.textField.textColor = UIColor.appTextColor // use apt text color for text entered in textfield
        //        if LanguageManager.shared.isRightToLeft {
        //            self.textField.placeholder = self.formItemModel.arabicPlaceholder
        //            self.textField.textAlignment = .right
        //        }
        //            else {
        self.textField.placeholder = self.formItemModel.placeHolder
        self.textField.textAlignment = .left
        //        }
        
        self.textField.text = self.formItemModel.textValue?.trimmingCharacters(in: CharacterSet(charactersIn: " "))
                self.textField.inputAccessoryView = self.keyBoardAccessoryView
//                self.keyBoardAccessoryView.tag = indexPath.row
        keyBoardAccessoryView.tag = indexPath.row
        self.textField.tag = indexPath.row
        self.textField.keyboardType = getKeyBoardType()
                if let keyboardDelegate = delegate as? LAKeyboardAccessoryViewDelegate {
                    self.keyBoardAccessoryView.delegate = keyboardDelegate
                }
        self.textField.isUserInteractionEnabled = itemModel.isEditable ?? false
        //        setUpPickerViewsWith(delegate: delegate)
        if let dell = delegate as? LATextFieldCellDelegate {
            self.delegate = dell
        }
        setUpRightImageView()
        //        checkValidationAndUpdateState(itemModel)
    }
    
    fileprivate func getKeyBoardType() -> UIKeyboardType {
        if self.formItemModel.inputType == "N" {
            return .numberPad
        }
        if self.formItemModel.inputType == "M" {
            return .numberPad
        } else if self.formItemModel.inputType == "EM" {
            return .emailAddress
        }
        return .default
    }
}

extension LATextFieldCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.formItemModel.isValid = true
        self.infoLabel.text = ""
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let trimmedString = textField.text?.trimmed() else {
            return
        }
        self.formItemModel.textValue = trimmedString
        self.delegate?.LATextFieldCellTextFieldDidEndEditing(textField, cell: self)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.textField.font = UIFont.boldSystemFont(ofSize: 13)
        if self.formItemModel.textFieldType == "dateOfBirth" {
            // automatic forward slash addition handling
            if (textField.text?.count == 2) || (textField.text?.count == 5) {
                //Handle backspace being pressed
                if !(string == "") {
                    // appending the / automtically between day, month and year
                    textField.text = (textField.text)! + "/"
                }
            }
            // checking the condition that characters shouldn't not exceed 9
            return !(textField.text!.count > 9 && (string.count ) > range.length)
        }
        //                else {
        //                    return true
        //                }
        //
        guard let textString = textField.text else { return true }
        guard let range = Range(range, in: textString) else { return true }
        if let text = textField.text?.replacingCharacters(in: range, with: string), let textFormItem = self.formItemModel {
            if textFormItem.validations?.max == 0 { return true }
            if text.count > textFormItem.validations?.max ?? 0 { return false }
        }
        return true
    }
}

//extension String {
//    func isInt() -> Bool {
//
//        if let _ = Int(self) {
//            return true
//        }
//        return false
//    }
//
//    /* validate date of birth
//     if textField.text!.isInt() {
//     if textField.text?.count == 2 {
//     if Int(textField.text) >= 31 {
//     // showToast Message that date can't be greater than 31
//     } else if textField.text?.count == 4
//     } */
//}
