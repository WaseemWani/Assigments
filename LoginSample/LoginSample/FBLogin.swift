//
//  FBLogin.swift
//  LoginSample
//
//  Created by Waseem Wani on 25/07/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//

import UIKit
import Foundation
import FBSDKLoginKit
import FacebookLogin
protocol Loggable {
    
    func login()
    var token: Any { get set }
    var userDetails: [String: Any] {get set}
    func logout()
}



class FBLogin: Loggable {
    
    // this will store the user details
    var userDetails: [String : Any] = [:]
    
    // this will store the access token
    var token: Any = 0
    
    // this function performs login functionality
    func login() {
        print("login")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
        if let accessToken = AccessToken.current {
            token = accessToken
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
                    print(permission.map({$0.name}))
                    self.userDetails["name"] = permission.map({$0.name})
                    self.token = accessToken
                    print("logged in successfully")
                    print("\n accessToken: \(self.token)")
                    print(" permission: \(permission)")
                    print(" declined permissions: \(declinedPermissions)")
                    break
                }
            }
        }
    }
    
    
    // this function performs logout functionality
    func logout() {
        
        let manager = LoginManager()
        manager.logOut()
        print("logged out from facebook")
//
//        let profileVC = ProfileVC()
//        profileVC.popVC()
    }
}

