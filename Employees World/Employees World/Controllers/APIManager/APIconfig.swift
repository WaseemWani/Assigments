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
    case googleImages(String, String, String, Int, Int)
    
    
    var urlString: String {
        return baseUrl + version + endpoints
    }
    
    var baseUrl: String {
        switch self {
        case .fetchEmployeesData, .fetchEmpDetailsById:
            return "http://dummy.restapiexample.com"
        case .login, .signUp, .forgetPassword, .emailValidation:
            return "https://qa.curiousworld.com"
        case .googleImages:
            return "https://www.googleapis.com"
        }
    }
    
    
    var version: String {
        switch self {
        case .fetchEmployeesData, .fetchEmpDetailsById:
            return "/api/v1"
        case .login, .signUp, .forgetPassword, .emailValidation:
            return "/api/v3"
        case .googleImages:
            return "/customsearch/v1"
            //        default:
            //           return ""
        }
    }
    
    // "https://www.googleapis.com/customsearch/v1?q=\(query)&key=\(key)&cx=\(cx)&searchType=image&start=\(start)&num=\(num)"
    //https://www.googleapis.com/customsearch/v1?q=mango&cx=012901128431505213492:-4_sixrb7wu%3Aj4u2pcebgfi&searchType=image&key=AIzaSyCDdfoCp4WoMH5MrpUVG6J-hRsywmUaX0Y&start=1&num=2
    
    // let cx = "018004629090563794309:4-knw3rlcoo"
    // let key = "AIzaSyDIUO4kqd6rHZEbNg5-phC6z6-jmHD0jLI"
    // "https://www.googleapis.com/customsearch/v1?q=mango&key=AIzaSyDIUO4kqd6rHZEbNg5-phC6z6-jmHD0jLI&cx=018004629090563794309:4-knw3rlcoo&searchType=image&start=1&num=2"
    //    https://www.googleapis.com/customsearch/v1?q=mango&key=AIzaSyDIUO4kqd6rHZEbNg5-phC6z6-jmHD0jLI&cx=018004629090563794309:4-knw3rlcoo&searchType=image&start=1&num=8
    
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
        case .googleImages(let query, let key, let cx, let start, let count):
            return "?q=\(query)&key=\(key)&cx=\(cx)&searchType=image&start=\(start)&num=\(count)"
            
            // AIzaSyBGm-_pQdNcuSKG7sLNJcZtEgEMRlI5XnI
            // AIzaSyCDdfoCp4WoMH5MrpUVG6J-hRsywmUaX0Y
            // 012901128431505213492:-4_sixrb7wu
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
        case .fetchEmployeesData, .fetchEmpDetailsById, .googleImages:
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
        case .fetchEmployeesData, .fetchEmpDetailsById, .googleImages:
            return .get
        case .login, .signUp, .forgetPassword, .emailValidation:
            return .post
            //        default:
            //            return .get
        }
    }
    
    var body : URLRequest {
        switch self {
        case .login, .signUp, .forgetPassword:
            let request = createRequest(withUrl: urlString)
            return request
        default:
            //            print("no body for this case")
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            return request
        }
        
        //        var bodyattach: Data {
        //            switch self {
        //            case .login:
        //                //call function here and get params in data from
        //                return
        //                <#code#>
        //            default:
        //                <#code#>
        //            }
        //        }
    }
    
    func createRequest(withUrl url: String) -> URLRequest {
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        if let body = parameters as? Data {
            request.httpBody = body
            return request
        } else {
            let httpBody = try? JSONSerialization.data(withJSONObject: parameters as Any, options: .prettyPrinted)
            request.httpBody = httpBody
            return request
        }
    }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
}

