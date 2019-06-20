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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "EmpTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EmpTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.lightGray
        callAPI()
        
    }

    func callAPI() {
        print("protocol conformed on emplistVC")
        NetwokManager.fetchData(urlRequest: RequestType<[EmployeesData]>.fetchEmployeesData) { (result) in
    
    switch result {
    case .sucess(let empList):
    self.hideErrorView()
    self.employeeArray = empList
    //saveEmpData(empData: self.employeeArray)
    self.tableView.reloadData()
    break
    case .error(let error):
//    let alert  = UIAlertController(title: "Warning", message: error.localizedDescription, preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //self.present(alert, animated: true, completion: nil)

        DispatchQueue.main.async {
            self.hideErrorView()
            self.showErrorView(onView: self.tableView, error.localizedDescription)
        }
     //EmpErrorView.view().errLabel.text = error.localizedDescription
     //EmpErrorView.view().delegate = self
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

// extension of above class Emplist.Here we will implement necessary delegates to populate tableview with data

extension EmpListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpTableViewCell") as? EmpTableViewCell
        
        cell?.nameLabel.text = employeeArray[indexPath.row].employeeName
        cell?.idLabel.text =  employeeArray[indexPath.row].id
        return cell!
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

//let url = "http://dummy.restapiexample.com/api/v1/employees"
/*
 DispatchQueue.global().async {
 NetwokManager.fetchData(urlRequest: RequestType.fetchWholeData)  { (data, responseError) in
 if let err = responseError {
 print(err.localizedDescription)
 let alert  = UIAlertController(title: "Warning", message: err.localizedDescription, preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
 self.present(alert, animated: true, completion: nil)
 
 } else {
 //let result = try? JSONDecoder().decode([EmployeesData].self, from: data as! Data)
 DispatchQueue.main.async {
 self.employeeArray = data as! [EmployeesData]
 self.tableView.reloadData()
 }
 //print(self.employeeArray)
 }
 
 }
 
 }*/



//self.navigationItem.backBarButtonItem?.tintColor = UIColor.green

// Do any additional setup after loading the view.


//let backgroundView = UIView()
//let cell = tableView.dequeueReusableCell(withIdentifier: "EmpTableViewCell") as? EmpTableViewCell
//let cell = tableView.cellForRow(at: indexPath) as! EmpTableViewCell

//cell.layer.backgroundColor = UIColor.green.cgColor
//        cell.layer.borderWidth = 0.5
//        cell.layer.borderColor = UIColor.blue.cgColor
//        cell.layer.cornerRadius = 10
// tableView.backgroundView?.alpha = 0
  //currentCell.layer.backgroundColor = UIColor.green.cgColor //print(id)

//                if let err = responseErr {
//                    debugPrint(err.localizedDescription)
//                } else {
//                    let movieData = movieList as? JSON
//                    print(movieData)
//                    let movieCatalog = movieData.flatMap(MovieListing.init)
//                    debugPrint(movieCatalog)
//                }

//                catch {
//
//                }
//            self.tableView.reloadData(){
//
//        }
