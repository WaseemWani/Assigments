//
//  ApiManager.swift
//  Employees World
//
//  Created by Waseem Wani on 29/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation

// Generic API Manager to manage api calls
class APIManager {
    
    enum Result<T:Codable> {
        case sucess(T)
        case error(Error)
    }
    
    class func fetchData<T: Codable>(urlRequest: RequestType<T>, completion: @escaping((Result<T>) -> ())) {
        
        guard let url = URL(string: urlRequest.urlString) else {
            debugPrint("Unable to make a call");
            return
        }
        debugPrint(url)
        var request = urlRequest.body
        request.httpMethod = urlRequest.requestMethod.rawValue
        for (key, value) in urlRequest.header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) {(data, response, responseError)  in
            guard let responseData = data else {
                
                let res: Result<T> = .error(responseError!)
                debugPrint(response as Any)
                completion(res)
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(urlRequest.resultType.self, from: responseData)
                let res : Result<T> = .sucess(result)
                DispatchQueue.main.async {
                    completion(res)
                }
            } catch let error {
                let error: Result<T> = .error(error)
                completion(error)
            }
        }
        task.resume()
    }
}
