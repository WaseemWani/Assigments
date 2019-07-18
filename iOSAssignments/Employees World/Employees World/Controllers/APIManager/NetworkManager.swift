//
//  ApiManager.swift
//  Employees World
//
//  Created by Waseem Wani on 29/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case customError(String)
    case dataNotFound
    case jsonParsingError
    // case netWorkError(String)
    
    //    static func parseError(error: Error) -> ServiceError  {
    //        return .customError(error.localizedDescription)
    //    }
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .customError(let message):
            return message
            
        case .dataNotFound:
            return "Unable to get data"
            
        case .jsonParsingError:
            return "Unable to parse the data"
        }
    }
}

// Api Manager to manage api calls
class NetwokManager {
    
    enum Result<T:Codable> {
        case sucess(T)
        case error(Error)
    }
    
    //static let sharedInstance = ApiManager()
    
    class func fetchData<T: Codable>(urlRequest: RequestType<T>, completion: @escaping((Result<T>) -> ())) {
        
        guard let url = URL(string: urlRequest.urlString) else {
            print("Unable to make a call");
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = urlRequest.requestMethod.rawValue
        //var header = [String:String]()
        for (key, value) in urlRequest.header {
            //header[key] = value
            request.addValue(value, forHTTPHeaderField: key)
        }
        if urlRequest.requestMethod == .get {
            
        } else if urlRequest.requestMethod == .post {
            
            if let body = urlRequest.parameters as? Data {
                request.httpBody = body
            } else {
                guard let httpBody = try? JSONSerialization.data(withJSONObject: urlRequest.parameters as Any, options: .prettyPrinted) else { return }
                     request.httpBody = httpBody
            }
        }
        
        var session = URLSession(configuration: .default)
        session = URLSession.shared
        
        let task = session.dataTask(with: request) {(data, response, responseError)  in
            guard let responseData = data else {
                
                let res: Result<T> = .error(responseError!)
                print(response as Any)
                //.error(ServiceError.customError("something went wrong")) ////responseError
                completion(res)
                return
            }
//            print(String(data: responseData, encoding: .utf8))
            if let result = try? JSONDecoder().decode(urlRequest.resultType, from: responseData){
                let res : Result<T> = .sucess(result)
                DispatchQueue.main.async {
                    completion(res)
                }
            } else {
                //let res: Result<T> = .error(ServiceError.jsonParsingError)
                completion(.error(ServiceError.jsonParsingError))
            }
        }
        task.resume()
    }
}


//else {

/*if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
 completion(object, nil)
 } else {
 let error = (object as? JSON).flatMap(ServiceError.init) ?? ServiceError.other
 completion(nil, error)
 }
 /*
 if error ==  nil {
 result = try? JSONDecoder().decode(EmployeesData.self, from: data!)
 completion(result, nil)
 } else {
 completion(nil, ServiceError.customError("something went wrong"))
 }
 }*/
 //}*/

//class func fetchEmployeesDataById(urlRequest: RequestType, completion: @escaping((Any?, Error?) ->())) {
//
//    guard let url = URL(string: urlString) else {
//        print("unable to make a call")
//        return
//    }
//     var request = URLRequest(url: url)
//     request.httpMethod = "GET"
//     let session = URLSession.shared
//     let sessionTask  = session.dataTask(with: request) {(data, response, error) in
//        if error ==  nil {
//           let result = try? JSONDecoder().decode(EmployeesData.self, from: data!)
//          completion(result, nil)
//        } else {
//            completion(nil, ServiceError.customError("something went wrong"))
//        }
//    }
//    sessionTask.resume()
//}
//}
//}

