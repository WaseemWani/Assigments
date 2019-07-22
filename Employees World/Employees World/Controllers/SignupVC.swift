//
//  ProfileView.swift
//  Employees World
//
//  Created by Waseem Wani on 17/06/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation
import UIKit

class SignupVC: UIViewController {
    
    
    @IBOutlet weak var fnameTxtField: UITextField!
    @IBOutlet weak var lnameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var pswdTxtField: UITextField!
    @IBOutlet weak var confirmPswdTxtField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginViewBtn: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.isHidden = true
        customizeView(view: signUpBtn, crnrRadius: 4, bdrWidth: 2, brdrClr: .black)
    }
    
    @IBAction func signupBtnTapped(_ sender: Any) {
        loader.isHidden = false
        loader.startAnimating()
        
        let parameters =  [
            "firstName" : fnameTxtField.text ?? "",
            "lastName"  : lnameTxtField.text ?? "",
            "mail"      : emailTxtField.text ?? "",
            "password"  : pswdTxtField.text ?? ""
        ]
        
        NetwokManager.fetchData(urlRequest: RequestType<ApiResponse>.signUp(parameters)) { (result) in
            
            switch result {
            case .sucess(let signupResponse):
                self.hideErrorView()
                let signupResponse = signupResponse
                self.loader.stopAnimating()
                self.loader.isHidden = true
                
                if signupResponse.userStatus.statusCode == 1 {
                    self.showErrorView(onView: self.view, signupResponse.userStatus.message ?? "you have signed up successfully", #imageLiteral(resourceName: "splash"), retryBtnText: "login")
                } else {
                    self.showToast(withMsg: signupResponse.userStatus.message ?? "")
                }
                
            case .error(let error):
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.loader.isHidden = true
                    self.hideErrorView()
                    self.showErrorView(onView: self.view, error.localizedDescription,  #imageLiteral(resourceName: "error"), retryBtnText: "retry")
                }
                break
            }
        }
    }

    @IBAction func loginViewBtnTapped(_ sender: Any) {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
//    func showToast(withMsg alertMsg: String) {
//        let alert  = UIAlertController(title: nil, message: alertMsg, preferredStyle: .alert)
//        self.present(alert, animated: true, completion: nil)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
//            alert.dismiss(animated: true, completion: nil)
//        })
//    }
}

extension SignupVC : ErrorViewProtocol {
    func refreshScreen() {
        hideErrorView()
        //print("screen refershed")
    }
}

extension SignupVC: CustomizedView {
}

extension SignupVC: Toast {
}
