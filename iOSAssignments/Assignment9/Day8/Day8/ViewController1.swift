//
//  SwitchViewController.swift
//  Day8
//
//  Created by Waseem Wani on 05/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var birthDateTextField: UITextField!
    @IBOutlet var placeOfBirthtextfield: UITextField!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var dateOfBirthPicker: UIDatePicker!
    @IBOutlet var placeOfBirthPicker: UIPickerView!
    @IBOutlet var pickerHolder: UIView!
    @IBOutlet var placeOfBirthPickerHolder: UIView!
    @IBOutlet var donePlaceOfBirthButton: UIButton!
    @IBOutlet var submitButton: UIButton!
    
    let profilePicker = UIImagePickerController()
    
    var cities = ["Delhi", "Noida","Lukcnow","Allahabad","Jaipur","Aligarh","Banaras","Bangalore","Hyderabad"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeOfBirthPicker.delegate = self
        placeOfBirthPicker.dataSource = self
        //profilePicker.delegate = self
        profilePicker.delegate =  self
    
        profilePic.layer.cornerRadius = profilePic.frame.size.height / 2.0
        profilePic.layer.masksToBounds = true
    }
    
    // function to push 2nd view Controller on this view Controller
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilePic.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Function for opening photo library on click
    @IBAction func uploadPicture(_ sender: Any) {
        profilePicker.allowsEditing = false
        profilePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(profilePicker, animated:  true, completion:  nil)
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
            //passwordTextField.becomeFirstResponder()
        }
        return true
    }

func textFieldDidBeginEditing(_ textField: UITextField) {

       if textField == birthDateTextField {
            //textField.keyboardAppearance
             pickerHolder.isHidden = false
             textField.resignFirstResponder()
            //dateOfBirthPicker.isHidden = false
        }

        if textField == placeOfBirthtextfield {
            placeOfBirthPickerHolder.isHidden = false
            textField.resignFirstResponder()
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
        
        if (usernameTextField.text?.isEmpty == true || emailTextField.text?.isEmpty == true || placeOfBirthtextfield.text?.isEmpty == true || birthDateTextField.text?.isEmpty == true) {
            submitButton.isEnabled = true
        }
    }
     
    @IBAction func pushSecondViewController() {
            let signUpViewObj = UIStoryboard(name: "Main", bundle: nil)
            let view1 = signUpViewObj.instantiateViewController(withIdentifier: "ViewController2")
            self.navigationController?.pushViewController(view1, animated: true)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        // get a reference to the second view controller
//        let secondViewController = segue.destination as! ViewController2
//
//        // set a variable in the second view controller with the String to pass
//        secondViewController.imageRecieved = profilePic.image
//
//    }
