//
//  EmpListVC.swift
//  Employees World
//
//  Created by Waseem Wani on 22/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

protocol  GetEmployeeID {
    func getSelectedEmpId(_ id: String)
}

class EmpListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var employeeArray = [EmployeesData]()
    var searchedEmployee = [EmployeesData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserDefaults.standard.bool(forKey: "isloggedIn"))
        
        let nib = UINib.init(nibName: "EmpTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EmpTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.lightGray
        callAPI()
        addSearchBar()
    }
    
    func callAPI() {
        print("protocol conformed on emplistVC")
        NetwokManager.fetchData(urlRequest: RequestType<[EmployeesData]>.fetchEmployeesData) { (result) in
            
            switch result {
            case .sucess(let empList):
                self.hideErrorView()
                self.employeeArray = empList
                //self.searchedEmployee = empList
                //saveEmpData(empData: self.employeeArray)
                self.tableView.reloadData()
                break
            case .error(let error):
                DispatchQueue.main.async {
                    self.hideErrorView()
                    self.showErrorView(onView: self.tableView, error.localizedDescription,  #imageLiteral(resourceName: "error"), retryBtnText: "retry")
                }
                break
            }
        }
    }
}

extension EmpListVC : ErrorViewProtocol {
    func refreshScreen() {
        callAPI()
    }
}

// extension of class Emplist. Here necessary delegates, to populate tableview with data, are implemented

extension EmpListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchedEmployee.count == 0 {
            return employeeArray.count
        } else {
            return searchedEmployee.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpTableViewCell") as? EmpTableViewCell
        if searchedEmployee.count == 0 {
            cell?.nameLabel.text = employeeArray[indexPath.row].employeeName
            cell?.idLabel.text = employeeArray[indexPath.row].id
            return cell!
        } else {
            cell?.nameLabel.text = searchedEmployee[indexPath.row].employeeName
            cell?.idLabel.text =  searchedEmployee[indexPath.row].id
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! EmpTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        let id = currentCell.idLabel.text
        var delegate: GetEmployeeID!
        
        let vc =  storyboard?.instantiateViewController(withIdentifier: "EmpDetailsVC") as! EmpDetailsVC
        
        delegate.self  = vc
        delegate.getSelectedEmpId(id!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// extension on EmpListVC to implement searchBar and handle searching
extension EmpListVC : UISearchBarDelegate {
    
    func addSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.placeholder = "Search employee by name"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { searchedEmployee.removeAll()
        searchedEmployee = employeeArray.filter({($0.employeeName!.localizedCaseInsensitiveContains(searchText))})
        print(searchedEmployee.count)
        //searchedEmployee.map({print($0.employeeName)})
        tableView.reloadData()
        //employeeArray = []
    }
}


//        for employee in employeeArray {
//            if (employee.employeeName?.range(of: searchText, options: .caseInsensitive) != nil || employee.id?.range(of: searchText, options:  .caseInsensitive) != nil) {
//searchedEmployee.append(employee)
//if searchText != "" {
//            let matchText = NSPredicate(format: "SELF MATCHES %@", searchText)
//            let searchedEmp : [EmployeesData] = employeeArray.filter({matchText.evaluate(with: $0.employeeName )})
//            let searchedData = employeeArray.filter({matchText.ev})
//            searchedEmployee = searchedData
//        } else if searchText == "" {
//            searchedEmployee = employeeArray
//        }
//employeeArray = searchedEmployee
//}
// }


