//
//  APIconfig.swift
//  Employees World
//
//  Created by Waseem Wani on 24/05/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation

enum RequestType<T> {
    case fetchEmployeesData
    case fetchEmpDetailsById(String)
    case signUp([String: String])
    case login(Data)
    case forgetPassword([String:String])
    case emailValidation([String: String])

    
    var urlString: String {
        return baseUrl + version + endpoints
    }
    var baseUrl: String {
        switch self {
        case .fetchEmployeesData, .fetchEmpDetailsById:
            return "http://dummy.restapiexample.com"
        case .login, .signUp, .forgetPassword, .emailValidation:
            return "https://qa.curiousworld.com"
    var version: String {
        switch self {
        case .fetchEmployeesData, .fetchEmpDetailsById:
            return "/api/v1"
        case .login, .signUp, .forgetPassword, .emailValidation:
            return "/api/v3"
//        default:
//           return ""
        }
    }
    var endpoints: String {
        switch self {
        case .fetchEmployeesData:
            return "/employees"
        case .fetchEmpDetailsById(let empID):
            return "/employee/\(empID)"
        case .signUp:
            return "/SignUp"
        case .login:
            return "/Login?_format=json"
        case .forgetPassword:
            return "/ForgetPassword?_format=json"
        case .emailValidation:
            return "/Validate/Email?_format=json"
        }
    }
    
    var resultType : T.Type {
        switch self {
            
        case .fetchEmployeesData:
            return T.self
        default:
            return T.self
        }
    }
    
    var header: [String: String] {
        switch self {
        case .fetchEmployeesData, .fetchEmpDetailsById:
            return [:]
        case .signUp, .forgetPassword, .emailValidation:
            var dict = [String:String]()
            dict["Content-Type"] = "application/json"
            return dict
        case .login:
            var dict = [String: String]()
            dict["Content-Type"] = "multipart/form-data; boundary=CuriousWorld"
            return dict
            //default:
        }
    }
    
    //request.addValue("multipart/form-data; boundary=CuriousWorld", forHTTPHeaderField: "Content-Type")
    
    //request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    
    var parameters: Any? {
        switch self {
        case .login(let params):
            return params
        
        case  .signUp(let params):
            return params
        case .forgetPassword(let params):
            return params
        default:
            return nil
        }
    }
    
    
    var requestMethod: RequestMethod {
        switch self {
        case .fetchEmployeesData, .fetchEmpDetailsById:
            return .get
        case .login, .signUp, .forgetPassword, .emailValidation:
            return .post
        
//        default:
//            return .get
        }
    }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
}
