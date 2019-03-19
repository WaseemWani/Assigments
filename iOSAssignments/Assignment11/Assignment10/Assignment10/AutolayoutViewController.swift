//
//  AutolayoutViewController.swift
//  Assignment10
//
//  Created by Waseem Wani on 15/03/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class AutolayoutViewController: UIViewController {

    @IBOutlet var countTextField : UITextField!
    @IBOutlet var submitButton : UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    }
    
    
    @IBAction func showViewsOnSubmitClick()
    {
        let elementCount = countTextField.text!

        let redView = UIView()
        redView.backgroundColor = .red
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        
        let orangeView = UIView()
        orangeView.backgroundColor = .orange
        
        var mainVerticalStackView = UIStackView()
    
        switch elementCount {
        
        case "1":
            
            mainVerticalStackView.addArrangedSubview(redView)
        
        case "2":
            mainVerticalStackView.insertArrangedSubview(redView, at: 0)
            mainVerticalStackView.insertArrangedSubview(blueView, at: 1)
            
        case "3":
    
            mainVerticalStackView = UIStackView(arrangedSubviews: [redView , blueView , yellowView])

        case "4":
        
            let horizontalStackView1 = UIStackView(arrangedSubviews: [redView , blueView])
            horizontalStackView1.axis = .horizontal
            horizontalStackView1.distribution = .fillEqually
            
            let horizontalStackView2 = UIStackView(arrangedSubviews: [yellowView , orangeView])
            horizontalStackView2.axis = .horizontal
            horizontalStackView2.distribution = .fillEqually

            mainVerticalStackView = UIStackView(arrangedSubviews:[horizontalStackView1,horizontalStackView2])
        
        default:
            mainVerticalStackView = UIStackView(arrangedSubviews: [])
    }
        
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.distribution = .fillEqually
        mainVerticalStackView.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 200)
        
        view.addSubview(mainVerticalStackView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
