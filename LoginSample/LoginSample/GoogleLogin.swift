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
    
    
    func login() {
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        GIDSignIn.sharedInstance().signIn()
    }
    
    func getToken() {
        print("")
    }
    
    func getUserDetails() {
        print("")
    }
    
    func logout() {
        GIDSignIn.sharedInstance().signOut()
        let profileVC = ProfileVC()
        profileVC.popVC()
        //pop view controller after signing out
    }

}

extension GoogleLogin: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            //print(error)
        } else {
            let userId = user.userID
            let name = user.profile.givenName
            let email = user.profile.email
            let idToken = user.authentication.idToken
            print(name!,email!, userId!, idToken!)
            // addProfileVc()
        }
    }
}

