//
//  EmployeesData.swift
//  Employees World
//
//  Created by Waseem Wani on 27/04/20.
//  Copyright © 2020 TTN. All rights reserved.
//

import Foundation

struct EmployeeDataModel: Codable {
    var success: String?
    var data: [EmployeesData]?
}

struct EmployeesData: Codable {
    var id: String?
    var employeeName: String?
    var salary: String?
    var age: String?
}

extension EmployeesData {
    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
    }
}

struct CommonDataModel {
    var employeeName: String
    var id: String
    var salary: String
    var age: String
}
