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
    //    @IBOutlet weak var mapView: MKMapView!
    //    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var empProfileImage: UIImageView!
    //Labels being used to show employee details on the screen
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var agelabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    var images = [UIImage]()
    var selectedEmpId = ""
    var employeeDetailsArray = [EmployeesData]()
    var ImagesVC = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        callEmpDetailsAPI()
        addMapView()
        print(UserDefaults.standard.bool(forKey: "isloggedIn"))
        customizeView(view: empProfile)
        customizeView(view: detailsSubView, crnrRadius: 0, bdrWidth: 0, brdrClr: .lightGray, alphaValue: 1)
        //customizeView(view: bottomView, crnrRadius: 12, bdrWidth: 1, brdrClr: .black)
        //detailsSubView.layer.cornerRadius = 10
        //detailsSubView.layer.borderWidth = 2
        //detailsSubView.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        //bottomView.clipsToBounds = true
        //bottomView.layer.masksToBounds = true
        //        let nib =  UINib.init(nibName: "CollectionViewCell", bundle: nil)
        //        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        //let url = "http://dummy.restapiexample.com/api/v1/employee/\(selectedEmpId)"
    }
    
    func getDocumentsDirectory() -> String {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
         return String(describing:  path[0])
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
                DispatchQueue.main.async {
                    self.hideErrorView()
                    self.showErrorView(onView: self.view, error.localizedDescription, #imageLiteral(resourceName: "error"), retryBtnText: "retry")
                }
            }
        }
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.green
    }
    
    
    @IBAction func galleryButtonTapped(_ sender: Any) {
        let vc  =  storyboard?.instantiateViewController(withIdentifier: "GalleryVC") as! GalleryVC
        vc.isSubGalleryVC = true
        vc.isMainGalleryVc = false
        vc.empId = Int32(idLabel.text ?? "0") ?? 0
        addChildVC(vc)
    }
    
    @IBAction func mapButtonTapped(_ sender: Any) {
         addMapView()
     }
    
    func addMapView() {
        let vc  = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vc.isMapVC = false
        vc.willDropAnnotations = false
        addChildVC(vc)
        let empId = Int32(idLabel.text ?? "0") ?? 0
        let fetchdeResultsController = DBManager.sharedInstance.retrieveData(modelType: CoreDataModelType<EmpLocation>.emplocationById(empId))
        try? fetchdeResultsController?.performFetch()
        let fetchedLocation = fetchdeResultsController?.fetchedObjects
        for empLoc in fetchedLocation! {
            let annotationPoint = MKPointAnnotation()
            annotationPoint.coordinate = CLLocationCoordinate2D(latitude: empLoc.latitude, longitude: empLoc.longitude)
            annotationPoint.title = empLoc.address1
            annotationPoint.subtitle = empLoc.address2
            vc.map.addAnnotation(annotationPoint)
        }
    }

    
    func getSelectedEmpId(_ id: String){
        selectedEmpId = id
        print(id)
    }
    
    @IBAction func addAnnotationBtnTapped(_ sender: Any) {
        let vc  = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vc.willDropAnnotations = true
        vc.empId = Int(idLabel.text ?? "0") ?? 0
        vc.isMapVC = false
        addChildVC(vc)
        showAlert(withMsg: "Adding Annotations enabled")
    }
    
    func addChildVC(_ vc: UIViewController) {
        addChild(vc)
        bottomView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func showAlert(withMsg alertMsg: String) {
        let alert = UIAlertController(title: nil , message: alertMsg, preferredStyle: .actionSheet)
        self.present(alert, animated: true, completion: nil)
        alert.view.layer.cornerRadius = 8
        //controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alert.dismiss(animated: true)
        }
    }
    
    @IBAction func addImagesBtnTapped(_ sender: Any) {
        
        //addChildVC(ImagesVC)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let selectPic = UIAlertController(title: "Upload Photo", message: "Select the source", preferredStyle: .actionSheet)
        
        selectPic.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            //self.present(selectPic, animated: true, completion: nil)
        }))
        
        
        selectPic.addAction(UIAlertAction(title: "Google Images", style: .default, handler: {(action: UIAlertAction) in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc =  storyboard.instantiateViewController(withIdentifier: "GalleryVC") as! GalleryVC
            vc.isMainGalleryVc = false
            vc.isSubGalleryVC = false
            vc.empId = Int32(self.idLabel.text ?? "0") ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        
        selectPic.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
                imagePickerController.sourceType = .camera
                imagePickerController.allowsEditing  = true
                self.present(imagePickerController, animated: true)
            } else {
                let alert  = UIAlertController(title: "Message", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }))
        
        selectPic.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(selectPic, animated: true, completion:  nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //pick url of the selected image(s)
        guard let pickedImage = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return}
//            UUID().uuidString
           // info[UIImagePickerController.InfoKey.imageURL] //as! String
        //print("imagee Url", pickedImage)
        //let path = getDocumentsDirectory()
        //print(path + pickedImage)
        DBManager.sharedInstance.saveData(modelType: CoreDataModelType<Gallery>.selectedImages) {
            (result) in
            result.empId = Int32(self.idLabel.text ?? "0") ?? 0
            result.imageURL =  pickedImage.lastPathComponent            //appendingPathComponent(pickedImage) //as? String
//            appendPathComponent(pickedImage)
            //pickedImage //String(describing: pickedImage)
            result.thumbnailURL = pickedImage.lastPathComponent //String(describing: pickedImage)
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "GalleryVC") as! GalleryVC
        vc.isMainGalleryVc = false
        vc.isSubGalleryVC = true
        vc.empId = Int32(self.idLabel.text ?? "0") ?? 0
        addChildVC(vc)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }    
}

extension EmpDetailsVC: ErrorViewProtocol {
    func refreshScreen() {
        callEmpDetailsAPI()
    }
}

extension EmpDetailsVC:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if images.count == 0 {
            return 10
        } else {
            return images.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if images.count > 0 {
            customizeView(view: cell, crnrRadius: 5, bdrWidth: 0, brdrClr: .white)
            cell.imageView.image = images[indexPath.row]
            return cell
        } else {
            //customizeView(view: cell)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width/3)-13.5
        // let cellHeight = (collectionView.frame.height-30)
        return CGSize.init(width: cellWidth, height: cellWidth)
    }
    
}

// delegates of imagePickerController are implemented in this extension of the EmpDetailsVC class
extension EmpDetailsVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func tapGestureAction (_ sender: UITapGestureRecognizer) {
        print("Image view tapped")
        //        let imagePickerController = UIImagePickerController()
        //        imagePickerController.delegate = self
        //
        //        let selectPic = UIAlertController(title: "Upload Photo", message: "Select the source", preferredStyle: .actionSheet)
        //
        //        selectPic.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
        //            imagePickerController.sourceType = .photoLibrary
        //            self.present(imagePickerController, animated: true, completion: nil)
        //            //self.present(selectPic, animated: true, completion: nil)
        //        }))
        //
        //
        //        selectPic.addAction(UIAlertAction(title: "Google Images", style: .default, handler: {(action: UIAlertAction) in
        //
        //        }))
        //
        //        selectPic.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
        //            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
        //                         imagePickerController.sourceType = .camera
        //                         imagePickerController.allowsEditing  = true
        //                         self.present(imagePickerController, animated: true)
        //                } else {
        //                       let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
        //                      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //                     self.present(alert, animated: true, completion: nil)
        //                }
        //               }))
        //
        //        selectPic.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //        self.present(selectPic, animated: true, completion:  nil)
        //    }
        
        
        //    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //
        //        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //        empProfile.image = pickedImage
        //        picker.dismiss(animated: true, completion: nil)
        //    }
        //
        //    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //        picker.dismiss(animated: true, completion: nil)
        //    }
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
}
