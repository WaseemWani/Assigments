//
//  DatabaseVC.swift
//  Employees World
//
//  Created by Waseem Wani on 31/05/19.
//  Copyright © 2019 TTN. All rights reserved.
//
import UIKit
import Foundation
import CoreData


func saveEmpData(empData: [EmployeesData]) {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    if let context = appDelegate?.persistentContainer.viewContext {
    let entity = NSEntityDescription.insertNewObject(forEntityName: "Employees", into: context) as? Employees
       
        for emp in empData {
            entity?.name = emp.employeeName
            entity?.age = emp.age
            entity?.id =  emp.id  //as Int
            entity?.salary = emp.salary
        }
    
    appDelegate?.saveContext()
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //       // print()
                print("url:\(url)")

}
}

