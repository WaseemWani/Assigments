//
//  EmployeesData.swift
//  Employees World
//
//  Created by Waseem Wani on 27/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation

struct EmployeesData: Codable {
    var id: String?
    var employeeName: String?
    var salary: String?
    var age: String?
    //var profile: String?
// {"id":"13649","employee_name":"PPstit22","employee_salary":"12322","employee_age":"24","profile_image":""},
}

extension EmployeesData {
    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
        //case profile = "profile_image"
    }
    
//    init(from decoder: Decoder) {
//           let x = try? decoder.container(keyedBy: CodingKeys.self)
//                        x?.nestedContainer(keyedBy: <#T##CodingKey.Protocol#>, forKey: EmployeesData.CodingKeys.age)
//    }
}

//"id":"719","employee_name":"test","employee_salary":"123","employee_age":"23","profile_image":""
