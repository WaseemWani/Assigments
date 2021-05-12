//
//  AttendanceListViewController.swift
//  EmployeeAttendanceManagementSystem
//
//  Created by Waseem Wani on 10/05/21.
//

import UIKit

class AttendanceListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var checkInDataSource = [Checkin]()
    var checkOutDataSource = [Checkout]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ATTENDANCE"
        loadDataBase()
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadDataBase() {
        guard let checkinData = DatabaseManager.sharedInstance.retrieveData(modelType: CoreDataModelType<Checkin>.checkIn),  let checkOutData = DatabaseManager.sharedInstance.retrieveData(modelType: CoreDataModelType<Checkout>.checkOut) else { return }
        checkInDataSource = checkinData
        checkOutDataSource = checkOutData
    }
    
    private func registerCell() {
        let nib = UINib.init(nibName: "AttendanceTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AttendanceTableViewCell")
    }
}

extension AttendanceListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkInDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceTableViewCell") as? AttendanceTableViewCell else {
            return UITableViewCell()
        }
        
        guard checkInDataSource[indexPath.row].hasCheckedIn, let checkInTime = checkInDataSource[indexPath.row].time, let date = checkInDataSource[indexPath.row].date else { return UITableViewCell() }
        
        if checkOutDataSource.count < indexPath.row + 1 {
            cell.configureCell(with: checkInTime, checkOutTime: "Check out not done", date: date)
            return cell
        } else {
            cell.configureCell(with: checkInTime, checkOutTime: checkOutDataSource[indexPath.row].time ?? "", date: date)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
