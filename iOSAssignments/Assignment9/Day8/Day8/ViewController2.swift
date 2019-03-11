//
//  ViewController2.swift
//  Day8
//
//  Created by Waseem Wani on 05/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var goToNxtpageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.imageView.layer.cornerRadius = self.imageView.frame.width / 2.0
         self.imageView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
   
    @IBAction func goToNxtpage() {
     let storyObj =  UIStoryboard(name: "Main", bundle: nil)
        let welcomeView = storyObj.instantiateViewController(withIdentifier: "segmentedView")
        self.navigationController?.pushViewController(welcomeView, animated: true)
    }
    
    
//    @IBAction func addImage(_ sender: Any) {
//
//        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
//            self.camera()
//        }))
//
//        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
//            self.photoLibrary()
//        }))
//
//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        self.present(actionSheet, animated: true, completion: nil)
//    }
//
//
//    func camera() {
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            let myPickerController = UIImagePickerController()
//            myPickerController.delegate = self
//            myPickerController.sourceType = .camera
//            self.present(myPickerController, animated: true, completion: nil)
//        }
//    }
//
//    func photoLibrary() {
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
//            let myPickerController = UIImagePickerController()
//            myPickerController.delegate = self
//            myPickerController.sourceType = .photoLibrary
//            self.present(myPickerController, animated: true, completion: nil)
//        }
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
//
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            profilePictureView.image = image
//
//
//        }else{
//            print("Something went wrong")
//        }
//        self.dismiss(animated: true, completion: nil)
//    }
//
//}
//
//
//
//


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
