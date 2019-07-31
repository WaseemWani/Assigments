//
//  ViewController.swift
//  LoginSample
//
//  Created by Waseem Wani on 23/07/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//
// 385128929327-d4sof06niqp4kohk1f06o9cb7mtpccro.apps.googleusercontent.com

import UIKit

//import FacebookCore
//import FacebookLogin
//import FBSDKLoginKit
//import FBSDKCoreKit
//import TwitterKit
//import GoogleSignIn
//import AuthenticationServices


//swift 5 -- non-frozen enum.
enum LoginPlatform {
    case Facebook
    case Twitter
    case Google
    //    case loginWithApple
    
    //    var loginType : String {
    //
    //        switch self {
    //        case .Facebook:
    //            return ""
    //        case .Twitter:
    //            return ""
    //        case .Google:
    //            return ""
    //        @unknown default:
    //            return ""
    //            //    "Other than TWTR, Google, FB. Not known when this code was compiled"
    //        }
    //    }
}


class LoginVC: UIViewController {
    
    @IBOutlet weak var fbLoginBtn: UIButton!
    @IBOutlet weak var twitterLoginBtn: UIButton!
    @IBOutlet weak var googleLoginBtn: UIButton!
    @IBOutlet weak var appleLoginBtn: UIButton!
    
    var loginObj: Loggable!
    
    //    let loginObj: Loggable? = nil
    //    let fblogin: Loggable = FBLogin()
    //    let twtrLogin = TWTRLogin()
    ////    let glogin = GoogleLogin()
    
    //    var protocolType: [Loggable] {
    //        return [fblogin, twtrLogin]
    //    }
    
    func login(with platform: LoginPlatform) {
        
        switch platform {
        case .Facebook:
            loginObj = FBLogin()
            loginObj.login()
            break
        case .Twitter:
            loginObj = TWTRLogin()
            loginObj.login()
            break
        case .Google:
            loginObj = GoogleLogin()
            loginObj.login()
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView(view: fbLoginBtn, crnrRadius: 8, bdrWidth: 0, brdrClr: .white, alphaValue: 1)
        customizeView(view: twitterLoginBtn, crnrRadius: 8, bdrWidth: 0, brdrClr: .white, alphaValue: 1)
        customizeView(view: googleLoginBtn, crnrRadius: 8, bdrWidth: 0, brdrClr: .white, alphaValue: 1)
    }
    
    func setupAppleBtn() {
        // let appleBtn = ASAuthorizationAppleIDButton()
    }
    
    func addProfileVc() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        vc.loggedInObj = loginObj
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func appleLoginBtnTapped(_ sender: UIButton) {
        //        sender.backgroundColor = .darkGray
        //        sender.setTitle("LoggedOut", for: .normal)
        //        //      sender
    }
    
    @IBAction func fbLoginBtnTapped(_ sender: Any) {
        
        //        for object in protocolType {
        //            if object is FBLogin {
        //                object.login()
        //            }
        //        }
        login(with: .Facebook)
        //        let fbLogin: Loggable = FBLogin()
        //        fbLogin.login()
        addProfileVc()
        
        //fbLogin.getToken()
        //FBLogin.sharedInstance.login()
        //        if let token = AccessToken.current {
        //            addProfileVc()
        //            print(token)
        //        } else {
        //            let manager = LoginManager()
        //            manager.logIn(permissions: [.publicProfile], viewController: self) { (loginResult) in
        //                switch loginResult {
        //                case .failed(let error):
        //                    print("failed to login\(error)")
        //                    break
        //                case .cancelled:
        //                    print("cancelled logging in with facebook")
        //                case .success(let permission,  let declinedPermissions, let accessToken):
        //                    self.addProfileVc()
        ////                    let res =
        //                        print(permission.map({$0.name}))
        ////                    switch res {
        ////                    }
        //                    for elm in permission {
        //                       print(elm.name)
        //                    }
        //                    print("logged in successfully")
        //                    print("\n accessToken: \(accessToken)")
        //                    print(" permission: \(permission)")
        //                    print(" declined permissions: \(declinedPermissions)")
        //                    break
        //                }
        //            }
    }
    
    @IBAction func twitterLoginBtnTapped(_ sender: Any) {
        
        //        for object in protocolType {
        //            if object is TWTRLogin {
        //                object.login()
        //            }
        //        }
        //        let twtrLogin = TWTRLogin()
        //        twtrLogin.login()
        login(with: .Twitter)
        addProfileVc()
        
        //        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
        //            //            TWTRSession
        //            if let sess = session {
        //                print("signed in as \(sess.userName)")
        //                self.addProfileVc()
        //            } else {
        //                print("error: \(error!.localizedDescription)")
        //                print(error!)
        //            }
        //        })
    }
    
    @IBAction func googleLoginBtnTapped(_ sender: Any) {
        
        //        for object in protocolType {
        //            if object is GoogleLogin {
        //                object.login()
        //            }
        //        }
        login(with: .Google)
        //        let googleLogin = GoogleLogin()
        //        googleLogin.login()
        
        addProfileVc()
    }
}

extension LoginVC: CustomizedView {
}

//extension LoginVC: GIDSignInDelegate, GIDSignInUIDelegate {
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print(error.localizedDescription)
//            //print(error)
//        } else {
//            let userId = user.userID
//            let name = user.profile.givenName
//            let email = user.profile.email
//            let idToken = user.authentication.idToken
//            print(name!,email!, userId!, idToken!)
//            addProfileVc()
//        }
//    }
//}
