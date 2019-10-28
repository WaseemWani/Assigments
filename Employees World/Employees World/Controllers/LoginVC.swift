//
//  ProfileVc.swift
//  Employees World
//
//  Created by Waseem Wani on 30/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var forgotPswdBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var resetPswdView: UIView!
    
    @IBOutlet weak var resetPswdBtn: UIButton!
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPswdTextField: UITextField!
    @IBOutlet weak var viewTitleLabel: UILabel!
    
    @IBOutlet weak var resetMailTextField: UITextField!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var resetPswdViewLoader: UIActivityIndicatorView!
    //var signUpresponse: ApiResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "loggedIn") == true {
            addProfileVc()
        }
        //            else {
        //        loader.isHidden = true
        //        resetPswdViewLoader.isHidden = true
        //        customizeView(view: loginBtn, crnrRadius: 4, bdrWidth: 2, brdrClr: .black)
        //        customizeView(view: signupBtn, crnrRadius: 15, bdrWidth: 1.3, brdrClr: .black)
        //        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewTitleLabel.text = "Login"
        if UserDefaults.standard.bool(forKey: "loggedIn") == false {
            loader.isHidden = true
            resetPswdViewLoader.isHidden = true
            customizeView(view: loginBtn, crnrRadius: 4, bdrWidth: 2, brdrColor: .black)
            customizeView(view: signupBtn, crnrRadius: 15, bdrWidth: 1.3, brdrColor: .black)
        }
    }
    
    @IBAction func loginViewBtnTapped(_ sender: Any) {
        viewTitleLabel.text = "login"
    }
    
    @IBAction func signupViewBtnTapped(_ sender: Any) {
        addChildController()
    }
    
    @IBAction func showForgetPasswordView(_ sender: Any) {
        loginView.isHidden = true
        resetPswdView.isHidden = false
        customizeView(view: resetPswdBtn, crnrRadius: 4, bdrWidth: 2, brdrColor: .black)
    }
    
    @IBAction func loginBtntapped(_ sender: Any) {
        
        // call API when login button is tapped
        callLoginAPI()
    }
    
    func callLoginAPI() {
        loader.isHidden = false
        loader.startAnimating()
        
        let loginParams = [
            "mail" : self.loginEmailTextField.text!,
            "password" : self.loginPswdTextField.text!,
            "client_secret" : "abcde12345",
            "client_id" : "ec7c3bde-9f51-4113-9ecf-6ca6fd03b66b",
            "scope" : "ios",
            "grant_type" : "password",
            "deviceId" : "12345"
        ]
        let parameters = getPostDataAttributes(params: loginParams)
        NetwokManager.fetchData(urlRequest: RequestType<LoginResponse>.login(parameters)) { (result) in
            
            switch result {
            case .sucess(let loginData):
                self.hideErrorView()
                let postLoginResponse = loginData
                self.loader.stopAnimating()
                self.loader.isHidden = true
                if postLoginResponse.userStatus.statusCode == 1 {
                    self.saveLoginDetails(userDetails: postLoginResponse.userData!)
                    self.showToast(withMsg: postLoginResponse.userStatus.message ?? "Logged in successfully. Welcome to employees world.")
                    self.addProfileVc()
                } else {
                    self.showToast(withMsg: postLoginResponse.userStatus.message ?? "Unable to login!")
                }
                break
                
            case .error(let error):
                DispatchQueue.main.async {
                    self.hideErrorView()
                    self.loader.stopAnimating()
                    self.loader.isHidden = true
                    self.showErrorView(onView: self.view, error.localizedDescription,  #imageLiteral(resourceName: "error"), retryBtnText: "retry")
                }
                break
            }
        }
    }
    
    func getPostDataAttributes(params:[String:String]) -> Data {
        var data = Data()
        for(key, value) in params {
            let string = "--CuriousWorld\r\n".data(using: .utf8)
            data.append(string!)
            data.append(String.init(format: "Content-Disposition: form-data; name=%@\r\n\r\n", key).data(using: .utf8)!)
            data.append(String.init(format: "%@\r\n", value).data(using: .utf8)!)
            data.append(String.init(format: "--CuriousWorld--\r\n").data(using: .utf8)!)
        }
        return data
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        resetPswdViewLoader.isHidden = false
        resetPswdViewLoader.startAnimating()
        
        let loginMailId = resetMailTextField.text ?? ""
        let parameters = ["mail" :  loginMailId]
        NetwokManager.fetchData(urlRequest: RequestType<ApiResponse>.forgetPassword(parameters)) { (result) in
            switch  result {
            case .sucess(let response):
                let forgetPswdResponse = response
                self.hideErrorView()
                self.resetPswdViewLoader.stopAnimating()
                self.resetPswdViewLoader.isHidden = true
                if forgetPswdResponse.userStatus.statusCode == 1 {
                    self.showToast(withMsg: forgetPswdResponse.userStatus.message ?? "")
                    self.addChildController()
                    self.resetPswdView.isHidden = true
                    self.loginView.isHidden = false
                } else {
                    self.showToast(withMsg: forgetPswdResponse.userStatus.message ?? "Unable to perform the task!")
                }
            case .error(let error):
                DispatchQueue.main.async {
                    self.hideErrorView()
                    self.resetPswdViewLoader.stopAnimating()
                    self.resetPswdViewLoader.isHidden = true
                    self.showErrorView(onView: self.view, error.localizedDescription, #imageLiteral(resourceName: "error"), retryBtnText: "Retry")
                }
                break
            }
        }
    }
    
    func addProfileVc() {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    //    func showToast(withMsg alertMsg: String) {
    //
    //        let alert = UIAlertController(title: nil , message: alertMsg, preferredStyle: .alert)
    //        self.present(alert, animated: true, completion: nil)
    //        alert.view.layer.cornerRadius = 10
    //        //controller.present(alert, animated: true)
    //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
    //            alert.dismiss(animated: true)
    //        }
    //    }
    // func showAlert() {
    //            let alert  = UIAlertController(title: "", message: alertMsg, preferredStyle: .alert)
    //        alert.addAction(UIAlertAction(title: "", style: .default, handler: nil))
    //        self.present(alert, animated: true, completion: nil)
    //}
    
    func addChildController() {
        let vc  =  storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    // this function saves the user details like name, userId into userdefaults
    func saveLoginDetails(userDetails: UserData) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "loggedIn")
        defaults.set(userDetails.firstName, forKey: "fName")
        defaults.set(userDetails.lastName, forKey: "lName")
        defaults.set(userDetails.userID, forKey: "UID")
        defaults.set(userDetails.subscriptionStatus, forKey: "status")
    }
}

extension LoginVC: ErrorViewProtocol {
    func refreshScreen() {
        hideErrorView()
    }
}

extension LoginVC: Toast {
}

extension LoginVC : CustomizedView {
}
