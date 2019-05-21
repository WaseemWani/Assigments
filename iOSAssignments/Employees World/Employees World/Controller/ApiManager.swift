//
//  ApiManager.swift
//  Employees World
//
//  Created by Waseem Wani on 29/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    //case noInternetConnection
    case customError(String)
    case other
    case noError
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        //case .noInternetConnection:
          //  return "No Internet connection"
        case .customError(let message):
            return message
            //"My Custom Message"
            
        case .other:
            return "Something went wrong"
        
        case .noError:
            return ("success")
        }
        
    }
}

// Api Manager to manage api calls
class ApiManager {
    
   static let sharedInstance = ApiManager()
    
    func fetchEmployeesData(urlString: String, completion: @escaping((Any?, Error?) -> ())) {

        guard let url = URL(string: urlString) else {
            print("unable to make a call");
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) {(data, response, error)  in
            var result: Any? =  nil
            
            if(error == nil){
                
                result = try? JSONDecoder().decode([EmployeesData].self, from: data!)
                completion(result, nil)
            } else {
                completion(nil, ServiceError.customError("Can't load data as request has not been fulfilled! Something went wrong"))
            }
        }
        task.resume()
}

    
//
//    func loadFrom(url: String, completion: @escaping (_ data : Any) -> ()) {
//
//        guard let url = URL(string: url) else {
//            print("unable to make a call")
//            return
//        }
//        DispatchQueue.global().async {
//            if let result = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    completion((data: result))
//                }
//            } else {
//                DispatchQueue.main.async {
//                    completion("Error")
//                }
//            }
//        }
//    }


func fetchEmployeesDataById(urlString: String, completion: @escaping((Any?, Error?) ->())) {
   
    guard let url = URL(string: urlString) else {
        print("unable to make a call")
        return
    }
     var request = URLRequest(url: url)
     request.httpMethod = "GET"
     let session = URLSession.shared
     let sessionTask  = session.dataTask(with: request) {(data, response, error) in
        if error ==  nil {
           let result = try? JSONDecoder().decode(EmployeesData.self, from: data!)
          completion(result, nil)
        } else {
            completion(nil, ServiceError.customError("something went wrong"))
        }
    }
    sessionTask.resume()
}
}




//    let url = URL(string: "http://dummy.restapiexample.com/api/v1/employee/\(selectedEmpId)")
//    URLSession.shared.dataTask(with: url!) { (data, response, error) in
//        do {
//            if error == nil {
//                let employeeDetails = try JSONDecoder().decode(EmployeesData.self, from: data!)
//
//                DispatchQueue.main.async {
//                    self.idLabel.text = employeeDetails.id
//                    self.nameLabel.text = employeeDetails.employeeName
//                    self.agelabel.text = employeeDetails.age
//                    self.salaryLabel.text = employeeDetails.salary
//                    //
//                }
//                print(employeeDetails)
//                print(self.employeeDetailsArray)
//            }
//        }
//
//        catch {
//            print("error while fetching data!!Please try again. ")
//        }
//
//        }.resume()
//  }
//}

    //    //let _ =  "http://dummy.restapiexample.com/employee"
//    let url = URL(string: "http://dummy.restapiexample.com/api/v1/employees")
//    let session = URLSession.shared
//        let task  = session.dataTask(with: url, { (data, response, error -> Void) in
//        //do {
//            if error == nil {
//                onSuccess(data)
//                let result = try JSONDecoder().decode([EmployeesData].self, from: data!)
//                //print(self.employeeArray)
//        } else
//            {
//                onFailure(error!)
//                print("error while fetching data!!Please try again. ")
//           }
//
//        })
//        task.resume()
//}
