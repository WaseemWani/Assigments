//
//  ProfileVC.swift
//  LoginSample
//
//  Created by Waseem Wani on 23/07/19.
//  Copyright © 2019 Waseem Wani. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import TwitterKit
import GoogleSignIn

class ProfileVC: UIViewController {

    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView(view: logoutBtn, crnrRadius: 8, bdrWidth: 0.5, brdrClr: #colorLiteral(red: 0.231372549, green: 0.3490196078, blue: 0.5960784314, alpha: 0.8470588235), alphaValue: 1)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
//        logout from the appropraite platform
        let fbLogin = FBLogin()
        fbLogin.logout()

       // popVC()
              }
    
    func popVC() {
        //let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.popViewController(animated: true)
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

extension ProfileVC: CustomizedView {
}
