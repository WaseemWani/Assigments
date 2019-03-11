//
//  SwitchViewController.swift
//  Day8
//
//  Created by Waseem Wani on 05/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var birthDateTextField: UITextField!
    @IBOutlet var placeOfBirthtextfield: UITextField!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var dateOfBirthPicker: UIDatePicker!
    @IBOutlet var placeOfBirthPicker: UIPickerView!
    @IBOutlet var pickerHolder: UIView!
    @IBOutlet var placeOfBirthPickerHolder: UIView!
    @IBOutlet var donePlaceOfBirthButton: UIButton!
    @IBOutlet var submitButton: UIButton!
    //theTextfield.inputView = thePicker
    var cities = ["Delhi", "Noida","Lukcnow","Allahabad","Jaipur","Aligarh","Banaras","Bangalore","Hyderabad"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeOfBirthPicker.delegate = self
        placeOfBirthPicker.dataSource = self
    }
    
    
    // function to push 2nd view Controller on this view Controller
    @IBAction func pushSecondViewController() {
        let signUpViewObj = UIStoryboard(name: "Main", bundle: nil)
        let view1 = signUpViewObj.instantiateViewController(withIdentifier: "ViewController2")
        self.navigationController?.pushViewController(view1, animated: true)
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTextField {
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        }
            
        else if textField == emailTextField {
            textField.resignFirstResponder()
            phoneNumberTextField.becomeFirstResponder()
        }
            
        else if textField == phoneNumberTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        
        else if textField == passwordTextField  {
            textField.resignFirstResponder()
           
        }
        
//        else if textField == placeOfBirthtextfield {
//            textField.resignFirstResponder()
//            //birthDateTextField.becomeFirstResponder()
//        }
        
//        else if textField == birthDateTextField {
//            textField.resignFirstResponder()
//        }
      
        return true
    }


func textFieldDidBeginEditing(_ textField: UITextField) {

       if textField == birthDateTextField {
              textField.resignFirstResponder()
            pickerHolder.isHidden = false
            //dateOfBirthPicker.isHidden = false
        }

        if textField == placeOfBirthtextfield {
            placeOfBirthPickerHolder.isHidden = false
            //placeOfBirthPicker.isHidden = true
        }

}
    
   @IBAction func doneButtonPress () {
    
    placeOfBirthPickerHolder.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneBtnClick(_ sender: Any) {
        let datePicked = dateOfBirthPicker.date
        let dateFormatType = DateFormatter()
        dateFormatType.dateStyle = .medium
        
        birthDateTextField.text = dateFormatType.string(from: datePicked)
        pickerHolder.isHidden = true
        birthDateTextField.resignFirstResponder()
        //dateOfBirthPicker.isHidden = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placeOfBirthtextfield.text = cities[row]
    }
    
    @IBAction func check(_ sender: Any) {
        
        if (usernameTextField.text?.isEmpty == true || emailTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || placeOfBirthtextfield.text?.isEmpty == true || birthDateTextField.text?.isEmpty == true) {
            submitButton.isEnabled = true
        }
    }
}

