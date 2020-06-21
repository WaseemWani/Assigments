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
    
    var urlString: String {
        return baseUrl + version + endpoint
    }
    
    var baseUrl: String {
        switch self {
        case .fetchEmployeesData:
             return "http://dummy.restapiexample.com"
        }
    }
    
    var version: String {
        switch self {
        case .fetchEmployeesData:
            return "/api/v1"
        }
    }
    
    var endpoint: String {
        switch self {
        case .fetchEmployeesData:
            return "/employees"
        }
    }
    
    var resultType : T.Type {
        switch self {
            
        case .fetchEmployeesData:
            return T.self
        }
    }
    
    var header: [String: String] {
        switch self {
        case .fetchEmployeesData:
            return [:]
        }
    }
    
    var parameters: Any? {
        switch self {
        default:
            return nil
        }
    }
    
    var requestMethod: RequestMethod {
        switch self {
        case .fetchEmployeesData:
            return .get
        }
    }
    
    var body : URLRequest {
        switch self {
        default:
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            return request
        }
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

