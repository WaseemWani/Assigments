//
//  HomeViewController.swift
//  EmployeeAttendanceManagementSystem
//
//  Created by Waseem Wani on 24/04/21.
//

import UIKit
import LocalAuthentication
import CoreLocation

class HomeViewController: UIViewController {
    @IBOutlet var greetingsLabel: UILabel!
    
    @IBOutlet var checkInView: UIView!
    @IBOutlet var checkInLabel: UILabel!
    @IBOutlet var checkinImageView: UIImageView!
    
    @IBOutlet var locationView: UIView!
    @IBOutlet var locationImageView: UIImageView!
    @IBOutlet var setLocationLabel: UILabel!
    
    @IBOutlet var attendanceView: UIView!
    @IBOutlet var listImageView: UIImageView!
    @IBOutlet var viewAttendanceLabel: UILabel!
    
    @IBOutlet var viewProfileView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var viewProfileLabel: UILabel!
    
    var currentLoc: CLLocation!
    let role = UserDefaults.standard.string(forKey: AppConstants.roleKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        addShadowAndRoundCorners()
        setNavigationBar()
        
        if let name = UserDefaults.standard.string(forKey: AppConstants.nameKey) {
            greetingsLabel.text = "Welcome  \(name.capitalized)!"
        }
        
        profileImageView.image = UIImage(systemName: "person.circle")
        viewProfileLabel.text = "View profile"
        listImageView.image = UIImage(systemName: "list.bullet.rectangle")
        viewAttendanceLabel.text = "View attendance"
        
        if role == AppConstants.adminRoleText {
            checkinImageView.image = nil
            checkInLabel.text = nil
            locationImageView.image = UIImage(systemName: "mappin.and.ellipse")
            setLocationLabel.text = "Set office location"
        } else {
            checkinImageView.image = UIImage(systemName: "arrow.right.square")
            checkInLabel.text = "Check in       "
            locationImageView.image = UIImage(systemName: "arrow.left.square")
            setLocationLabel.text = "Check out"
        }
    }
    
    private func addShadowAndRoundCorners() {
        locationView.roundCorners(cornerRadius: 10)
        locationView.addShadow(shadowOpacity: 0.5)
        attendanceView.roundCorners(cornerRadius: 10)
        attendanceView.addShadow(shadowOpacity: 0.5)
        viewProfileView.roundCorners(cornerRadius: 10)
        viewProfileView.addShadow(shadowOpacity: 0.5)
        if role == AppConstants.employeeRoleText {
            checkInView.roundCorners(cornerRadius: 10)
            checkInView.addShadow(shadowOpacity: 0.5)
        }
    }
    
    private func setNavigationBar() {
        self.title = "HOME"
        self.navigationItem.backButtonTitle = " "
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOutTapped))
    }
    
    @objc func logOutTapped() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        UserDefaults.standard.set(false, forKey: AppConstants.loggedInKey)
        navigationController?.setViewControllers([loginViewController], animated: true)
    }
    
    @IBAction func checkInButtonAction(_ sender: Any) {
        if let checkinEntity = DatabaseManager.sharedInstance.retrieveData(modelType: CoreDataModelType<Checkin>.checkInByDate(Date().getLocalizedDate())), checkinEntity.first?.hasCheckedIn != nil {
            showAlert(title: "Oops!", message: "You have already checked in for today.", completionHandler: nil)
        } else {
            let location = CLLocation()
            if currentLoc == location {
                print("ok")
            } else {
                print("not matched")
            }
//            if currentLoc ==  OFFICELOCATION {
//                // biometry check
//            } else {
//                showAlert(title: "Oops!", message: "Location does not match!", completionHandler: nil)
//            }
            authenticateWithBiometrics() { [weak self] authenticated  in
                if authenticated {
                    DatabaseManager.sharedInstance.saveData(modelType: CoreDataModelType<Checkin>.checkIn) { entity in
                        entity.hasCheckedIn = true
                        entity.date = Date().getLocalizedDate()
                        entity.time = Date().getLocalizeTime()
                        self?.showAlert(title: "Success", message: "Checked in successfully!", completionHandler: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func addLocationButtionAction(_ sender: Any) {
        if role == AppConstants.adminRoleText {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewViewController") as? LocationViewViewController else { return }
            navigationController?.pushViewController(locationViewController, animated: true)
        } else {
            if let checkOutEntity = DatabaseManager.sharedInstance.retrieveData(modelType: CoreDataModelType<Checkout>.checkOutByDate(Date().getLocalizedDate())), !checkOutEntity.isEmpty, checkOutEntity.first?.hasCheckedOut != nil {
                showAlert(title: "Oops!", message: "You have already checked out for today.", completionHandler: nil)
            } else {
                authenticateWithBiometrics() { [weak self] authenticated  in
                    if authenticated {
                        DatabaseManager.sharedInstance.saveData(modelType: CoreDataModelType<Checkout>.checkOut) { entity in
                            entity.hasCheckedOut = true
                            entity.date = Date().getLocalizedDate()
                            entity.time = Date().getLocalizeTime()
                            self?.showAlert(title: "Success", message: "Checked out successfully!", completionHandler: nil)
                        }
                    } else {
                        print("Authentication failed, you can not mark the attendance")
                    }
                }
            }
        }
    }
    
    @IBAction func viewAttendanceButtonAction(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let attendanceListViewController = storyBoard.instantiateViewController(withIdentifier: "AttendanceListViewController") as? AttendanceListViewController else { return }
        navigationController?.pushViewController(attendanceListViewController, animated: true)

        if role  == AppConstants.adminRoleText {
//            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
//            guard let attendanceListViewController = storyBoard.instantiateViewController(withIdentifier: "AttendanceListViewController") as? AttendanceListViewController else { return }
//            navigationController?.pushViewController(attendanceListViewController, animated: true)
        } else {
            print("view attendance button tapped: emp action will go here")
        }
    }
    
    @IBAction func viewProfileButtonAction(_ sender: Any) {
        print("view profile screen here")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else  { return }
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension HomeViewController {
    func authenticateWithBiometrics(completion: @escaping (_ authenticated: Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true)
                    } else {
                        self?.showAlert(title: "Authentication failed", message: "You could not be verified; please try again.", completionHandler: nil)
                        completion(false)
                    }
                }
            }
        } else {
            showAlert(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", completionHandler: nil)
        }
    }
}
