//
//  LoggedinUserDetails.swift
//  Employees World
//
//  Created by Waseem Wani on 14/06/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation

// model for getting user details getting logged in
struct LoginResponse: Codable {
    let userStatus: UserStatus
    var userData: UserData?
    
    enum CodingKeys: String, CodingKey {
        case userStatus = "status"
        case userData = "data"
    }
    
     // custom parsing
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userStatus = try values.decode(UserStatus.self, forKey: .userStatus)
        userData =  try? values.decode(UserData.self, forKey: .userData)
        
        if userData == nil {
            //userData = UserData(firstName: nil, lastName: nil, subscriptionStatus: nil, userID: nil)
        }
    }
}

struct UserStatus: Codable {
    let message: String?
    let statusCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case statusCode = "code"
    }
}

struct UserData: Codable {
    let firstName: String?
    let lastName: String?
    
    let subscriptionStatus: String?
    let userID: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName, subscriptionStatus, userID = "uid"
    }
}

struct ApiResponse: Codable {
    let userStatus: UserStatus
    
    enum CodingKeys: String, CodingKey {
        case userStatus = "status"
    }
}
