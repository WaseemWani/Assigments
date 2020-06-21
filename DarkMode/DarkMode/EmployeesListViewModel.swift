//
//  EmployeesListViewModel.swift
//  DarkMode
//
//  Created by Waseem Wani on 19/05/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//
import UIKit
import Foundation

protocol EmployeesListViewModelDelegate {
    func showHideTableView(show: Bool)
    func showHideLoader(show: Bool)
    func updateTableView()
    func showToast(with msg: String)
}

class EmployeesListViewModel: NSObject {
    
    var empData =  EmployeeDataModel()
    var dbdata = [EmployeeData]()
    var isFetchedFromDB = false
    var delegate: EmployeesListViewModelDelegate?
    
    func registerCells(for tableView: UITableView) {
        let nib = UINib.init(nibName: "EmployeeDetailsTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EmployeeDetailsTableCell")
    }
    
    func fetchEmployeesData() {
        delegate?.showHideTableView(show: false)
        delegate?.showHideLoader(show: true)
        if  UserDefaults.standard.bool(forKey: "isDataSavedToDB") == true {
            fetchDataFromDB()
        } else {
            APIManager.fetchData(urlRequest: RequestType<EmployeeDataModel>.fetchEmployeesData) { (result) in
                switch result {
                case .sucess(let data):
                    DispatchQueue.main.async {
                        self.delegate?.showHideLoader(show: false)
                        self.delegate?.showHideTableView(show: true)
                        self.empData = data
                        debugPrint(self.empData)
                        self.delegate?.updateTableView()
                        self.saveDataToDB()
                    }
                    break
                case .error(let error):
                    DispatchQueue.main.async {
                        self.delegate?.showToast(with: error.localizedDescription)
                    }
                    break
                }
            }
        }
    }
    
    fileprivate func saveDataToDB() {
        guard let employeeData = self.empData.data else { return }
        for employee in employeeData {
            DBManager.sharedInstance.saveData(modelType: CoreDataModelType<EmployeeData>.employeesData) { (result) in
                result.employeeName = employee.employeeName
                result.id = employee.id
                result.salary = employee.salary
                result.age = employee.age
            }
        }
        UserDefaults.standard.set(true, forKey: "isDataSavedToDB")
    }
    
    fileprivate func fetchDataFromDB() {
        let fetchedResultsController =  DBManager.sharedInstance.retrieveData(modelType: CoreDataModelType<EmployeeData>.employeesData)
        try? fetchedResultsController?.performFetch()
        dbdata = fetchedResultsController?.fetchedObjects ?? []
        isFetchedFromDB = true
        delegate?.showHideLoader(show: false)
        delegate?.showHideTableView(show: true)
        delegate?.updateTableView()
    }

}

extension EmployeesListViewModel: UITableViewDelegate {
    
}

extension EmployeesListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFetchedFromDB ? dbdata.count : empData.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeDetailsTableCell") as? EmployeeDetailsTableCell
        if isFetchedFromDB {
            cell?.configCell(with: dbdata[indexPath.row])
        } else {
            cell?.configureCell(with: empData.data?[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
}

