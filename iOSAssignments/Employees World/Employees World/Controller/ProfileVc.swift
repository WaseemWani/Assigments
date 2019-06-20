//
//  ProfileVc.swift
//  Employees World
//
//  Created by Waseem Wani on 30/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ProfileVc: UIViewController {

    //@IBOutlet weak
    //var loginBtn: CustomButton!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signupView: UIStackView!

    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPswdTextField: UITextField!
    @IBOutlet weak var viewTitleLabel: UILabel!
    
    //signup view textfield outlets
    @IBOutlet weak var fnameTextField: UITextField!
    @IBOutlet weak var lnameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var pswdTextfield: UITextField!
    @IBOutlet weak var confirmpswdtextfields: UITextField!
    
    //var loginData : LoggedinUserData!
    var signUpresponse: ApiResponse!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loginBtn.customizeBtn()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginViewBtnTapped(_ sender: Any) {
        loginView.isHidden = false
        signupView.isHidden =  true
    }


    
    @IBAction func signupViewBtnTapped(_ sender: Any) {
        loginView.isHidden = true
        signupView.isHidden = false
        viewTitleLabel.text = "Sign up"
    }
    
    
     @IBAction func signupBtnTapped(_ sender: Any) {
        
//        let signpURL = "https://qa.curiousworld.com/api/v3/SignUp"
            let parameters =  [
                "firstName" : fnameTextField.text ?? "",
                "lastName"  : lnameTextfield.text ?? "",
                "mail"      : emailTextfield.text ?? "",
                "password"  : pswdTextfield.text ?? ""
            ]
            
            NetwokManager.fetchData(urlRequest: RequestType<ApiResponse>.signUp(parameters)) { (result) in
                
                switch result {
                case .sucess(let signupResponse):
                    self.hideErrorView()
                    let signupResponse = signupResponse
                    //self.signUpresponse = signupResponse
                    
                    self.showAlert(withMsg: signupResponse.userStatus.message ?? "")
                    
//                    let alert  = UIAlertController(title: "Alert", message: signupResponse.userStatus.message, preferredStyle: .alert)
//                                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    
//                     self.present(alert, animated: true, completion: nil)
//                                { action in
//                                    if signupResponse.userStatus.statusCode == 1 {
//                                        self.navigationController?.popViewController(animated: false)
//                                    }

//                                self.present(alert, animated: true, completion: nil)
        
        
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "ProfileView") as! ProfileView
                    //controller.statusLabel.text = "signed up successfully"
                    self.navigationController?.pushViewController(controller, animated: false)
                    break
                    
                case .error(let error):
                    DispatchQueue.main.async {
                        self.hideErrorView()
                        self.showErrorView(onView: self.view, error.localizedDescription)
                    }
                    break
        }
    }
}

    @IBAction func resetPassword(_ sender: Any) {

//    func resetPassword() {
        let loginMailId = loginEmailTextField.text ?? ""
        let parameters = ["mail" :  loginMailId]
        NetwokManager.fetchData(urlRequest: RequestType<ApiResponse>.forgetPassword(parameters)) { (result) in
            switch  result {
            case .sucess(let response):
                let forgetPswdResponse = response
                self.hideErrorView()
                self.showAlert(withMsg: forgetPswdResponse.userStatus.message ?? "")

            case .error(let error):
                DispatchQueue.main.async {
                    self.hideErrorView()
                    self.showErrorView(onView: self.view, error.localizedDescription)
                }
                break
            }
        }
    }
    
    
    @IBAction func validateLoginEmail(_ sender: Any) {
        let email = loginEmailTextField.text ?? ""
        let parameters = ["mail" : email]
        NetwokManager.fetchData(urlRequest: RequestType<ApiResponse>.emailValidation(parameters)) { (result) in
            switch result {
            case .sucess(let response):
                let emailValidationStatus = response
                self.hideErrorView()
            
            case .error(let error):
                self.hideErrorView()
                self.showErrorView(onView: self.view, error.localizedDescription)
            }
        }
    }

    

@IBAction func loginBtntapped(_ sender: Any) {
    
    
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
    
    NetwokManager.fetchData(urlRequest: RequestType<LoggedinUserData>.login(parameters)) { (result) in

        switch result {
        case .sucess(let loginData):
            self.hideErrorView()
            //self.loginData = loginData
            let postLoginResponse = loginData
            self.showAlert(withMsg: postLoginResponse.userStatus.message ?? "")
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ProfileView") as! ProfileView
            //controller.statusLabel.text = "logged up successfully"
            self.navigationController?.pushViewController(controller, animated: true)
            break
            
        case .error(let error):
            DispatchQueue.main.async {
                self.hideErrorView()
                self.showErrorView(onView: self.view, error.localizedDescription)
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
    
    func showAlert(withMsg alertMsg: String) {
        let alert  = UIAlertController(title: "Alert", message: alertMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}





extension ProfileVc: ErrorViewProtocol {
    func refreshScreen() {
        //print("screen refreshed")
    }
}
