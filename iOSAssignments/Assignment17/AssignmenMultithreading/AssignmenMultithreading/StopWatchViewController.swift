//
//  ViewController.swift
//  AssignmenMultithreading
//
//  Created by Waseem Wani on 19/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopWatchLabel: UILabel!
    @IBOutlet weak var lapTimesTableView: UITableView!
    @IBOutlet weak var lapButton: UIButton!
    //@IBOutlet weak var pauseButton: UIButton!
    //@IBOutlet weak var resumeButton: UIButton!
    
    var timer = Timer()
    var seconds: Int = 0
    var minutes: Int = 0
    var hours: Int = 0
    var lapTimesArray: [Any] =  []
    
    override func viewDidLoad() {

        super.viewDidLoad()
        lapTimesTableView.delegate = self
        lapTimesTableView.dataSource = self
        startButton.titleLabel?.text = "Start"
    
        // making buttons round
        stopButton.layer.cornerRadius = stopButton.frame.width / 2.0
        stopButton.layer.masksToBounds = true
        
        startButton.layer.cornerRadius = startButton.frame.width / 2.0
        startButton.layer.masksToBounds = true
        
        lapButton.layer.cornerRadius =  lapButton.frame.width / 2.0
        lapButton.layer.masksToBounds = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @objc func timeIncreament() {
        
        if seconds < 9 {
            seconds += 1
            stopWatchLabel.text = String(minutes)+":0"+String(seconds)
        }
        
       else if (seconds >= 9 && seconds < 60)
        {
            seconds += 1
            stopWatchLabel.text = String(minutes)+":"+String(seconds)
        }

        if (seconds == 59) {
            seconds = 0
            minutes += 1
        
            stopWatchLabel.text = String(minutes)+":00"
    }
       
        if minutes == 59 {
            hours += 1
            minutes = 0
            seconds = 0
            stopWatchLabel.text = String(hours)+":"+String(minutes)+":"+String(seconds)
        }
        
        if minutes == 60 {
            timer.invalidate()
        }
    }
    

    
    @IBAction func startTimer(_ sender: Any) {
        startButton.isEnabled = false
        stopButton.isEnabled = true
        lapButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(StopWatchViewController.timeIncreament), userInfo: nil, repeats: true)
    }

    @IBAction func lapTimer(_ sender: Any) {
        lapTimesTableView.isHidden = false
        
        DispatchQueue.main.async {
            self.lapTimesArray.insert(String(self.minutes)+":"+String(self.seconds), at: 0)
            self.lapTimesTableView.reloadData()
        }
    }
    
    
    @IBAction func stopTimer(_ sender: Any) {
        
        lapTimesTableView.isHidden = true
        seconds = 0
        minutes = 0
        stopWatchLabel.text = "00:00"
        lapTimesArray = []
        timer.invalidate()
        startButton.isEnabled = true
        stopButton.isEnabled = false
        lapButton.isEnabled = false
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTimesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lapTimesTablleViewCell =  tableView.dequeueReusableCell(withIdentifier: "TableCell")
        lapTimesTablleViewCell?.textLabel?.text = (lapTimesArray[indexPath.row] as! String)
        return lapTimesTablleViewCell!

    }

}

