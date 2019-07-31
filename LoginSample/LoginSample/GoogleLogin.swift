//
//  GoogleLogin.swift
//  LoginSample
//
//  Created by Waseem Wani on 26/07/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//

import Foundation
import GoogleSignIn

class GoogleLogin: UIViewController, Loggable {
    
    // this will store the user details
    var userDetails: [String : Any] = [:]
    
    // this will store the acces token
    var token: Any = 0
    
    func login() {
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        GIDSignIn.sharedInstance().signIn()
    }
    
    //  this function performs logout functionality
    func logout() {
        GIDSignIn.sharedInstance().signOut()
//        let profileVC = ProfileVC()
//        profileVC.popVC()
        //pop view controller after signing out
    }
}

extension GoogleLogin: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            //print(error)
        } else {
            //            var userDetails = [String : Any]()
//            token = user.authentication.accessToken
            
            self.userDetails["name"] = user.profile.givenName
            self.userDetails["email"] = user.profile.email
            self.userDetails["familyName"] = user.profile.familyName
            
            let name = user.profile.name
            let userId = user.userID
            let email = user.profile.email
            let idToken = user.authentication.idToken
            print(name!,email!, userId!, idToken!)
        }
    }
}
