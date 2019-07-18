//
//  LoggedinUserDetails.swift
//  Employees World
//
//  Created by Waseem Wani on 14/06/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation

struct LoggedinUserData: Codable {
    let userStatus: UserStatus
    let userData: UserData
    
    enum CodingKeys: String, CodingKey {
        case userStatus = "status"
        case userData = "data"
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
        case firstName = "firstName"
        case lastName = "lastName"
        case subscriptionStatus = "subscriptionStatus"
        case userID = "uid"
    }
}

struct ApiResponse: Codable {
    let userStatus: UserStatus
    
    enum CodingKeys: String, CodingKey {
        case userStatus = "status"
    }
}
