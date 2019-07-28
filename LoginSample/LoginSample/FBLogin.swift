//
//  FBLogin.swift
//  LoginSample
//
//  Created by Waseem Wani on 25/07/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//
import UIKit
import Foundation
//import FBSDKCoreKit
import FBSDKLoginKit

protocol Loggable {
    func login()
    func getToken()
    func getUserDetails()
    func logout()
}


class FBLogin: Loggable {
    
    
//    func addProfileVc() {
//
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
//        //self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    
    func login() {
        print("login")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
          if let token = AccessToken.current {
//            let loginVC = LoginVC()
//            loginVC.addProfileVc()
            print(token)
        } else {
            let manager = LoginManager()
            manager.logIn(permissions: [.publicProfile, .email], viewController: vc) { (loginResult) in
                switch loginResult {
                    
                case .failed(let error):
                    print("failed to login: \(error)")
                    break
                case .cancelled:
                    print("cancelled logging in with facebook")
                case .success(let permission,  let declinedPermissions, let accessToken):
                    //vc.addProfileVc()
                                        print(permission.map({$0.name}))
                    //                    for elm in permission {
                    //                        print(elm.name)
                    //                    }
                    print("logged in successfully")
                    print("\n accessToken: \(accessToken)")
                    print(" permission: \(permission)")
                    print(" declined permissions: \(declinedPermissions)")
                    break
                }
            }
        }
    }
    
    func getToken() {
        print("get token here")
    }
    
    func getUserDetails() {
        print("get user details")
    }
    
    func logout() {
        
        let manager = LoginManager()
        manager.logOut()
        
        let profileVC = ProfileVC()
        profileVC.popVC()
    }
}

