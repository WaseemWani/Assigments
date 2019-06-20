//
//  EmpDetailsVC.swift
//  Employees World
//
//  Created by Waseem Wani on 22/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit
import MapKit

//protocol  Roundable {
//    func roundView(_ view:UIView)
//}

class EmpDetailsVC: UIViewController, GetEmployeeID, CustomizedView {
    
    @IBOutlet weak var detailsSubView: UIView!
    @IBOutlet weak var empProfile: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var empProfileImage: UIImageView!
    //Labels being used to show employee details on the screen
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var agelabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var selectedEmpId = ""
    var employeeDetailsArray = [EmployeesData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callEmpDetailsAPI()
        
        collectionView.delegate =  self
        collectionView.dataSource = self
        customizeView(collectionView)
        customizeView(empProfile)
        detailsSubView.layer.cornerRadius = 10
        detailsSubView.layer.borderWidth = 2
        detailsSubView.layer.borderColor = #colorLiteral(red: 0, green: 0.5254901961, blue: 0.6784313725, alpha: 1)
        
        let nib =  UINib.init(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        
        //let url = "http://dummy.restapiexample.com/api/v1/employee/\(selectedEmpId)"
    }
    
    func callEmpDetailsAPI() {
        print("making api call in empDetailsVC")
        NetwokManager.fetchData(urlRequest: RequestType<EmployeesData>.fetchEmpDetailsById(selectedEmpId)) {(result) in
            
            switch result {
            case .sucess(let empDetails):
                print(empDetails)
                self.hideErrorView()
                //self.employeeDetailsArray = empDetails
                self.nameLabel.text = empDetails.employeeName
                self.idLabel.text = empDetails.id
                self.agelabel.text = empDetails.age
                self.salaryLabel.text = empDetails.salary
                
            case .error(let error):
//                let alert  = UIAlertController(title: "Warning", message: error.localizedDescription, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                //self.present(alert, animated: true, completion: nil)
                DispatchQueue.main.async {
                    self.hideErrorView()
                    self.showErrorView(onView: self.view, error.localizedDescription)
                }
            }
   }
        
   // self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.green
        collectionView.layer.borderColor = UIColor.init(red: 0, green: 194, blue: 199, alpha: 0).cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func galleryButtonTapped(_ sender: Any) {
        collectionView.isHidden = false
        mapView.isHidden = true
    }
    
    @IBAction func mapButtonTapped(_ sender: Any) {
        mapView.isHidden = false
        collectionView.isHidden = true
    }
    
    func getSelectedEmpId(_ id: String){
        selectedEmpId = id
        print(id)
    }



    // function shwoing details of an emplyee
//func showEmployeeData() {
//    for item in employeeDetailsArray {
//        idLabel.text = item.id
//        nameLabel.text = item.employeeName
//        agelabel.text = item.age
//        salaryLabel.text = item.salary
//    }
//    }
//}
}

extension EmpDetailsVC: ErrorViewProtocol {
    
    func refreshScreen() {
        callEmpDetailsAPI()
    }
}

extension EmpDetailsVC:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  20
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        
        
        customizeView(cell)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width/3)-13.5
        //        let cellHeight = (collectionView.frame.height-30)
        return CGSize.init(width: cellWidth, height: cellWidth)
    }
    
    

   
}

// delegates of imagePickerController are implemented in this extension of the EmpDetailsVC class
extension EmpDetailsVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func tapGestureAction (_ sender: UITapGestureRecognizer) {
        print("Image view tapped")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let selectPic = UIAlertController(title: "Upload Photo", message: "Select the source", preferredStyle: .actionSheet)
        
        selectPic.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            //self.present(selectPic, animated: true, completion: nil)
        }))
        
        
        selectPic.addAction(UIAlertAction(title: "Google Images", style: .default, handler: {(action: UIAlertAction) in
            
        }))
        
        selectPic.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
                         imagePickerController.sourceType = .camera
                         imagePickerController.allowsEditing  = true
                         self.present(imagePickerController, animated: true)
                } else {
                       let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                     self.present(alert, animated: true, completion: nil)
                }
               }))
        
        selectPic.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(selectPic, animated: true, completion:  nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        empProfile.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


//                if let err = responseError {
//                print(err.localizedDescription)
//                let alert  = UIAlertController(title: "Warning", message: err.localizedDescription, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//
//            } else {
//                let employeeDetails = data as! EmployeesData
//                print(employeeDetails)
//                DispatchQueue.main.async {
//                    self.nameLabel.text = employeeDetails.employeeName
//                    self.idLabel.text = employeeDetails.id
//                    self.agelabel.text = employeeDetails.age
//                    self.salaryLabel.text = employeeDetails.salary
//                }


//        nameLabel.layer.cornerRadius = 10
//        nameLabel.layer.borderWidth = 0.5
//        nameLabel.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
//
//        agelabel.layer.cornerRadius = 10
//        agelabel.layer.borderWidth = 0.5
//        agelabel.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
//
//        salaryLabel.layer.cornerRadius = 10
//        salaryLabel.layer.borderWidth = 0.5
//        salaryLabel.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
//
//        idLabel.layer.cornerRadius = 10
//        idLabel.layer.borderWidth = 0.5
//        idLabel.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
//

//    @IBAction func segmentControlTapped(_ sender: Any) {
//
//        if segmentedControl.selectedSegmentIndex == 0 {
//           mapView.isHidden = true
//            collectionView.isHidden = false
//
//            // segmentLabel.text = "gallery segment selected"
//
//        } else  {
//            mapView.isHidden = false
//            collectionView.isHidden = true
//            //segmentLabel.text =  " segment selected "
//        }
//
//    }
