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
    
    // this will store the userdetails
    var userDetails: [String : Any] = [:]
    
//    this will store the access token
    var token: Any = 0
    
    // this fucntion performs login functionality
    func login() {
        
        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
            if let sess = session {
                self.token = sess.authToken
                self.userDetails["name"] = sess.userName
                self.userDetails["userID"] = sess.userID
                self.userDetails["authToken"] = sess.authToken
                print(self.token)
                print("signed in as \(sess.userName)")
            } else {
                print("error: \(error!.localizedDescription)")
                print(error!)
            }
        })
        
    }
    
    // this fucntion performs logout fucntionality
    func logout() {
        
        let sessionStore = TWTRTwitter.sharedInstance().sessionStore
        if let userID = sessionStore.session()?.userID {
            sessionStore.logOutUserID(userID)
        }
//        let profileVC = ProfileVC()
//        profileVC.popVC()
    }
}
