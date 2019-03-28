//
//  NotificationViewController.swift
//  assignment16delagates
//
//  Created by Waseem Wani on 24/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit
import UserNotifications
class NotificationViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var notifButton: UIButton!
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notifButton.titleLabel?.text = "Tap to schedule notification"
         registerLocal()
        // Do any additional setup after loading the view.
    }
    
    @objc func registerLocal() {
        //        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("authorised")
            } else {
                print("You will not recieve the notification")
            }
        }
    }
  

    @IBAction func notificationButtonTapped(_ sender: Any) {
        //notifButton.titleLabel?.text = "notifcation scheduled"
        
        center.removeAllPendingNotificationRequests()
        registerCategories()
        let content = UNMutableNotificationContent()
        content.title = "Hi Waseem"
        content.body = "This is the schdeuled notification."
        content.categoryIdentifier = "alarm"
        //content.userInfo = ["set by": "Waseem"]
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "toThePoint.m4r"))
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
 
    func registerCategories() {
        
        center.delegate = self
        let show = UNNotificationAction(identifier: "show", title: "Something", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    //MARK: - UNUserNotification Delegate Method -
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    
}

/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
