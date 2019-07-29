//
//  TWTRLogin.swift
//  LoginSample
//
//  Created by Waseem Wani on 26/07/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//

import Foundation
import TwitterKit

class TWTRLogin: Loggable {
    
    // this fucntion performs login functionality
    func login() {
        
        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
            if let sess = session {
                print("signed in as \(sess.userName)")
//                self.addProfileVc()
            } else {
                print("error: \(error!.localizedDescription)")
                print(error!)
            }
        })

    }
    
    func getToken() {
        print("get token here")
    }
    
    func getUserDetails() {
        print("get user details")
    }
    
    // this fucntion performs logout fucntionality
    func logout() {
        
        let sessionStore = TWTRTwitter.sharedInstance().sessionStore
        if let userID = sessionStore.session()?.userID {
            sessionStore.logOutUserID(userID)
        }
        
        let profileVC = ProfileVC()
        profileVC.popVC()
    }
}
