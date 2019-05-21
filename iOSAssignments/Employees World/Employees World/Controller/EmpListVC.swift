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
    
        //["Waseem","Utkarsh","Akash","Ashish","Anuranjan","Abhishek","Anubhav","Jasmeet","Anindya"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "EmpTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EmpTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.lightGray
        
        
        let url = "http://dummy.restapiexample.com/api/v1/employees"
        
        DispatchQueue.global().async {
            ApiManager.sharedInstance.fetchEmployeesData(urlString: url)  { (data, responseError) in
                
                if let err = responseError {
                    print(err.localizedDescription)
                    let alert  = UIAlertController(title: "Warning", message: err.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    
                    DispatchQueue.main.async {
                        self.employeeArray = data as! [EmployeesData]
                        self.tableView.reloadData()
                    }
                    //print(self.employeeArray)
                }
                
            }
            
        }
        
    }
   
    
        //self.navigationItem.backBarButtonItem?.tintColor = UIColor.green
    
        // Do any additional setup after loading the view.
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
