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
    //        x?.nestedContainer(keyedBy: CodingKeys.self, forKey: EmployeesData.CodingKeys.age)
    //    }
}
