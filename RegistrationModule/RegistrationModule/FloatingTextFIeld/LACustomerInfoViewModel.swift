//
//  LAViewModel.swift
//  LumiApp
//
//  Created by Disha on 20/08/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

struct LACustomerInfoViewConstants {
    static var leadingLabelConstant: CGFloat = 16.0
    static var keyboardAccessoryViewHeight: CGFloat = 44.0
    static var bottomButtonHeight: CGFloat = 60.0
    static var cardPadding: CGFloat = 10.0
}
class LACustomerInfoViewModel: NSObject {
    private var dataSource = [LADataFormModel]()
    weak var vc: LACustomerInfoViewController! = nil
    //    var reviewBookingParams: Parameters? = nil
    let appconfigR: Any?
    init(defaultData appConfigData: Any? ) {
        appconfigR = appConfigData
    }
    
    func registerCellsForTableView(_ tableView: UITableView) {
        tableView.registerReusableCell(LATextFieldCell.self)
        tableView.registerReusableHeaderFooterView(LALabelHeaderView.self)
    }
    
    func loadDataForCustomerForm() {
        //        self.vc.showFullScreenLoader()
        LAUtility.loadLocalJsonFile(filename: "CustomerInfo", completion: { [weak self](result: Result<LACustomerInfoObjectsModel, Error>) in
            switch result {
            case .success(let modal):
                if let data = modal.data {
                    self?.processData(data: data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            //            self?.vc.hideFullScreenLoader()
        })
    }
    
    fileprivate func processData (data: [LADataFormModel]) {
        self.dataSource = data
        self.vc.tableView.reloadData()
    }
    
    
    //     func prepareDataSource() {
    //        dataSource = [LADataFormModel]()
    //        let textModel1 = LADataFormModel()
    //        textModel1.placeHolder = "First Name"  //"Name*".localisedString
    //        textModel1.arabicPlaceholder = "FName" //Name*".localisedString
    //        textModel1.identifier = "text"
    //        textModel1.inputType = "AN"
    //        textModel1.isRequired = true
    //        textModel1.isEditable = true
    //        textModel1.validations = LAFormValidation()
    //        textModel1.validations?.errorMessage = "Invalid name"//"invalid_name".localisedString
    //        textModel1.validations?.max = 0
    //        dataSource.append(textModel1)
    //
    //        let textModel2 = LADataFormModel()
    //        textModel2.placeHolder = "Last Name" //Mobile*"
    //        textModel2.arabicPlaceholder = "lName" //Mobile*".localisedString
    //        textModel2.identifier = "text"
    //        textModel2.inputType = "M"
    //        textModel2.isRequired = true
    //        textModel2.isEditable = true
    //        textModel2.validations = LAFormValidation()
    //        textModel2.validations?.max = 10
    //        textModel2.validations?.min = 10
    //        textModel2.validations?.errorMessage = "invalid last name" //invalid_mobile".localisedString
    //        dataSource.append(textModel2)
    //
    //        let textModel3 = LADataFormModel()
    //        textModel3.placeHolder = "Email" //Branch Name".localisedString
    //        textModel3.arabicPlaceholder = "email" //Branch Name".localisedString
    //        textModel3.identifier = "text"
    //        textModel3.inputType = "AN"
    //        textModel3.isRequired = false
    //        textModel3.isEditable = true
    //        textModel3.identifier = "text"
    //        textModel3.validations = LAFormValidation()
    //        dataSource.append(textModel3)
    //    }
    
    func getNumberOfRowsForViewControllerWithIndex(_ selectedIndex: NSInteger) -> NSInteger {
        return (dataSource.count) + 1  // add one more for adding gender cell.
    }
    
    func getNumberOfSectionsForViewController() -> NSInteger {
        return 1
    }
    
    func getTableViewCellForRowAndVC(_ tableView: UITableView, _ indexPath: IndexPath, vc: LACustomerInfoViewController ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as LATextFieldCell
        cell.keyBoardAccessoryView = getKeyBoardAccessoryView(indexPath: indexPath)
        cell.showBorder = false
        if !(indexPath.row == 4) {
            cell.bindData(itemModel: dataSource[indexPath.row], delegate: self, indexPath: indexPath)
            return cell
        } else {
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerViewTitleView(indexPathSection: section, tableView: tableView)
    }
    
    /// Function to create tableHeaderView
    ///
    /// - Parameters:
    ///   - indexPathSection: table indexPath
    ///   - tableView: tableView Object
    /// - Returns: Valid UITableViewHeader Object
    fileprivate func headerViewTitleView(indexPathSection: Int, tableView: UITableView) -> UITableViewHeaderFooterView {
        if let headerView: LALabelHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            LALabelHeaderView.identifier) as? LALabelHeaderView {
            headerView.contentView.backgroundColor = .white
            headerView.configureExtrasHeaderViewWith(titleString: "Customer_info_subHeader".localisedString, titleTextColor: .brownishGreyTwo, isSepratorRequired: false)
            //            headerView.titleLabelLeadingSpace.constant = LACustomerInfoViewConstants.leadingLabelConstant
            return headerView
        }
        return UITableViewHeaderFooterView()
    }
    
    /// This method sets up the keybaord accessory view
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: keyboard accessory view object
    fileprivate func getKeyBoardAccessoryView(indexPath: IndexPath) -> LAKeyboardAccessoryView? {
        let keyboardAccessoryView = LAKeyboardAccessoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: LACustomerInfoViewConstants.keyboardAccessoryViewHeight), mode: .LAAllButtons)
        
        if indexPath.row == LACustomerInfoRowType.LACustomerInfoRowTypeFirstName.rawValue {
            keyboardAccessoryView.disablePrevious()
        } else if indexPath.row == 3 /*indexPath.row == LACustomerInfoRowType.LACustomerInfoRowTypeLicenseExpiry.rawValue*/
          {
            keyboardAccessoryView.disableNext()
        } else {
            keyboardAccessoryView.enableAll()
        }
        return keyboardAccessoryView
    }
    
    /// This function validates the form
    ///
    /// - Returns: Whether the form is filled up correctly or not
        func validateForm() -> Bool {
            var isValid = true
            for dataSourceObject in self.dataSource {
                _ = dataSourceObject.validate()
                if let validitt = dataSourceObject.isValid {
                    if !(validitt) {
                        isValid = validitt
                    }
                }
            }
            return isValid
        }
    
    fileprivate func shouldActivateNextButton() -> Bool {
        for dataSourceObject in self.dataSource {
            if dataSourceObject.isRequired == true && (dataSourceObject.textValue?.isEmpty == true || dataSourceObject.textValue == nil) {
                return false
            }
        }
        return true
    }
    
        fileprivate func updateNextButtonState() {
            if shouldActivateNextButton() {
                self.vc.registerButton.backgroundColor = UIColor.lumiGreenThemeColor
                self.vc.registerButton.isEnabled = true
            } else {
                self.vc.registerButton.backgroundColor = UIColor.lumiDeactivatedButtonColor
                self.vc.registerButton.isEnabled = false
            }
        }
    
    //    func pushVerifyViewController() {
    //        let params = LACustomerInformationRequestBody.getCustomerInformationParamters(for: self.dataSource)
    //        if var reviewParams = self.reviewBookingParams {
    //            reviewParams["Customer"] = params
    //            //API hit here
    //            makeAPIRequestToCreateReservationWith(paramters: reviewParams)
    //        }
    //    }
    
    //    fileprivate func makeAPIRequestToCreateReservationWith(paramters: Parameters) {
    //        LAReservationAPIClient.createReservation(parameters: paramters) { [weak self](response) in
    //            //            self?.hideLoader()
    //            switch response {
    //            case .success(let response):
    //                print("In success")
    //            case .failure(let error):
    //                debugPrint(error.localizedDescription)
    //            }
    //            self?.processCreateReservationResponse(data: nil)
    //        }
}

//    fileprivate func processCreateReservationResponse(data: LACreateReservationDataModel? ) {
//        if let otpViewController = LAMobileVerificationModalViewController.instantiate(fromAppStoryboard: .BookNow) {
//            otpViewController.delegate = vc
//            otpViewController.transitioningDelegate = self.vc.transitioning
//            otpViewController.modalPresentationStyle = .custom
//            self.vc.present(otpViewController, animated: true, completion: nil)
//        }
//    }
//}

extension LACustomerInfoViewModel: LAKeyboardAccessoryViewDelegate {
    func doneButtonTapped() {
        vc.view.endEditing(true)
    }
    func didTapPreviousForIndex(index: NSInteger) {
        didTapPreviousNextButtonKeyboard(index: index - 1)
        
    }
    func didTapNextForIndex(index: NSInteger) {
        didTapPreviousNextButtonKeyboard(index: index + 1)
    }
    func didTapPreviousNextButtonKeyboard(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = vc.tableView.cellForRow(at: indexPath) as? LATextFieldCell {
            cell.textField.becomeFirstResponder()
            return
        }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.vc.tableView.scrollToRow(at: indexPath, at: .none, animated: false)
        }, completion: { [weak self] _ in
            if let cell = self?.vc.tableView.cellForRow(at: indexPath as IndexPath) as? LATextFieldCell {
                cell.textField.becomeFirstResponder()
            }
        })
    }
}

extension LACustomerInfoViewModel: LATextFieldCellDelegate {
    func LATextFieldCellTextFieldDidEndEditing(_ textField: UITextField, cell: LATextFieldCell) {
        updateNextButtonState()
    }
}

//extension LACustomerInfoViewModel: LAPickerViewDelegate {

//    func pickerView(_ pickerView: LAPickerView, didSelectDate date: Date) {
//        if pickerView.tag == LACustomerInfoRowType.LACustomerInfoRowTypeDOB.rawValue {
//            guard let dobRow = self.vc.tableView.cellForRow(at: IndexPath(row: pickerView.tag, section: 0)) as? LATextFieldCell else {
//                return
//            }
//            let dob = LATimeUtility.getDateFormatterForDOB().string(from: date)
//            let dobObject = self.dataSource[pickerView.tag]
//            dobRow.textField.text = dob
//            dobObject.textValue = dob
//        } else {
//            guard let rowNum = self.vc.tableView.cellForRow(at: IndexPath(row: pickerView.tag, section: 0)) as? LATextFieldCell else {
//                return
//            }
//            let expiryDate = LATimeUtility.getDateFormatterForDOB().string(from: date)
//            let idExpiryObject = self.dataSource[pickerView.tag]
//            rowNum.textField.text = expiryDate
//            idExpiryObject.textValue = expiryDate
//        }
//    }

//    func pickerView(_ pickerView: LAPickerView, didSelectCategoryAtIndex rowNumber: Int, selectedValue: String?) {
//        let indexPathRow = pickerView.tag
//        let dataObject = self.dataSource[indexPathRow]
//        guard let cell = self.vc.tableView.cellForRow(at: IndexPath(row: indexPathRow, section: 0)) as? LATextFieldCell else {
//            return
//        }
//        dataObject.textValue = selectedValue
//        cell.textField.text = selectedValue
//
//        //Set up validation for selected ID type number
//        let idValueObject = self.dataSource[indexPathRow + 1]
//        if selectedValue == "National_ID".localisedString {
//            idValueObject.validations?.max = LAConstants.kMaxDigitsForPrepaidMobile
//        } else {
//            idValueObject.validations?.max = 0
//        }
//    }
//}
