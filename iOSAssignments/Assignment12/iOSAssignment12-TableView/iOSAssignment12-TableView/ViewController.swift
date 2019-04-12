//
//  Created by Waseem Wani 17/03/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    struct Record {
        let profilePic: UIImage
        let name: String
        let age: Int
        let address: String
        let detail: String
    }
    var tableData = [Record]()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var closeButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        let nib = UINib.init(nibName: "recordViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "recordCell")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.viewTapped(gestureRecogniser:)))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    @IBAction func onClickMore() {
       tableView.reloadData()
    }
    
    
    @objc func viewTapped(gestureRecogniser: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func uploadImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let selectPic = UIAlertController(title: "Upload Photo", message: "Select the source", preferredStyle: .actionSheet)
        
        selectPic.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            //self.present(selectPic, animated: true, completion: nil)
        }))
        
        selectPic.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(selectPic, animated: true, completion:  nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        image.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClick() {
        
        textFieldValidation()
    }
    
    
    func textFieldValidation() {
        
        let valueOfNameField = nameTextField.text
        let valueOfAgeField = ageTextField.text
        let valueOfAddressField = addressTextField.text
        let valueOfDetailField = detailTextField.text

        if valueOfNameField!.isEmpty {
            
            let alert = UIAlertController(title: "Alert", message: "Name field is empty! Enter name", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
            
        }
            
        else if valueOfAddressField!.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Address field is empty! Enter address", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        else if valueOfAgeField!.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Age field is empty! Enter age", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else if valueOfDetailField!.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Detail field is empty! Enter the detail", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        } else {
            tableData.append(Record(profilePic: image.image!, name: nameTextField.text!, age: Int(ageTextField.text!)!, address: addressTextField.text!, detail: detailTextField.text!))
            //print(tableData)
            subView.isHidden = false
           tableView.reloadData()
            self.view.bringSubviewToFront(subView)
        }

    }
    
    
    
    
    @IBAction func onClickClose() {
        subView.isHidden = true
       // self.view.bringSubviewToFront(subView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return tableData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell") as! recordViewCell

        cell.nameLabel.text = tableData[indexPath.row].name
        cell.ageLabel.text = String(tableData[indexPath.row].age)
        cell.addressLabel.text = tableData[indexPath.row].address
        cell.detailLabel.text = tableData[indexPath.row].detail
        cell.userImageView.image = tableData[indexPath.row].profilePic
        if indexPath.row == indexPath.row - 1 {
            print(tableData)
     }
        return cell
    }
}

