//
//  ViewController.swift
//  LumiApp
//
//  Created by Disha on 19/08/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

protocol LACustomerInfoViewControllerDelegate: class {
    func pushThankyouViewControllerAction()
}

class LACustomerInfoViewController: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
//    @IBOutlet weak var pullUpTopView: LAPullUpTopView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: LACustomerInfoViewModel! = nil
    var checkButtonFilled = false
    
//    private(set) var transitioning: LAPresentedTransitioningDelegateHandler?
//    weak var delegate: LACustomerInfoViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configureCheckButton(checkButton)
//        self.transitioning = LAPresentedTransitioningDelegateHandler()
        registerButton.backgroundColor = .lumiDeactivatedButtonColor
        viewModel = LACustomerInfoViewModel(defaultData: nil)
        viewModel.vc = self
        setupTableView()
        registerForKeyboardNotification()
//        configurePullUpTopView()
//        self.transitioning = LAPresentedTransitioningDelegateHandler()
    }

    deinit {
           NotificationCenter.default.removeObserver(self)
    }
    
    // waseemwani - adds border to a view
    func configureCheckButton(_ view: UIView) {
        
        view.layer.borderWidth = 3.3
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 2
    }
    
    /// Function to configure Pullup Top View
//    fileprivate func configurePullUpTopView() {
//        self.pullUpTopView.configurePullUpView(isCrossButtonRequied: false, isTitleRequired: true, isTopHandleRequired: false)
//        let titleFont: UIFont = .getDynamicFont(font: .bold, size: kFontSize14)
//        self.pullUpTopView.configureTitleLabel(textString: "Customer_info_header".localiz(), font: titleFont)
//        self.pullUpTopView.backgroundColor = .lumiTableBackgroundColor
//        self.pullUpTopView.contentView.backgroundColor = .lumiTableBackgroundColor
//    }
    
    /// This function is used to setup the tableview
    fileprivate func setupTableView() {
        viewModel.loadDataForCustomerForm()
        tableView?.delegate = self
        tableView?.dataSource = self
        viewModel?.registerCellsForTableView(self.tableView)
        registerGenderTableCell()
        tableView?.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.separatorStyle = .none
        tableView?.rowHeight = UITableView.automaticDimension
        self.view.backgroundColor =  .lumiTableBackgroundColor
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 0.01
    }
    
    func registerGenderTableCell() {
        let nib = UINib.init(nibName: "BottomCellforGender", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BottomCellforGender")
    }
    
    
    /// This method registers for the keyboard notifications
    fileprivate func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(LACustomerInfoViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LACustomerInfoViewController.keyboardWillHide(aNotification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// This method handles the Keyboard hide notification action
    ///
    /// - Parameter aNotification: keyboard should hide notification
    @objc
    fileprivate func keyboardWillShow(notification: NSNotification) {
        let keyboardOffset: CGFloat = LACustomerInfoViewConstants.bottomButtonHeight + LACustomerInfoViewConstants.cardPadding
        guard let info = notification.userInfo, let keyboardSize = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.size.height - keyboardOffset, right: 0.0)
        self.tableView.contentInset = contentInsets
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset
    }
    
    /// This method handles the Keyboard hide notification action
    ///
    /// - Parameter aNotification: keyboard should hide notification
    @objc
    fileprivate func keyboardWillHide(aNotification: NSNotification) {
        guard let userInfo = aNotification.userInfo, let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int else { return }
        let keyboardOffset: CGFloat = 0
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIView.AnimationOptions(rawValue: UIView.AnimationOptions.RawValue(animationCurve << 16)), animations: {
            self.updateTableInsets(offset: keyboardOffset)
        }, completion: { _ in
        })
    }
    
    /// This method updates the table insets in case of keyboard handling
    ///
    /// - Parameter offset: table offsets
    fileprivate func updateTableInsets(offset: CGFloat) {
        var insets = self.tableView.contentInset
        insets.bottom = offset
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        
        if !checkButtonFilled {
            let checkButtonColorTick = UIImage(named: "check_Button_colored_Tick")
            checkButton.setImage(checkButtonColorTick, for: .normal)
            checkButtonFilled = true
        } else {
            checkButton.setImage(nil, for: .normal)
            checkButtonFilled = false
        }
    }
    
 
//    @IBAction func nextButtonAction(_ sender: Any) {
//        resignFirstResponder()
//        if !(viewModel.validateForm()) {
//            self.tableView.reloadData()
//        } else {
//            viewModel.pushVerifyViewController()
//        }
//    }
}

// MARK: - Tableview delegate and data source methods
extension LACustomerInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsForViewControllerWithIndex(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 4 {
            // use gender cell
            let genderCell = tableView.dequeueReusableCell(withIdentifier: "BottomCellforGender") as! BottomCellforGender
            return genderCell
        } else {
            return viewModel.getTableViewCellForRowAndVC(tableView, indexPath, vc: self)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return 110
        } else {
            return CGFloat(40.0)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return 110
        } else {
        return viewModel.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.tableView(tableView, viewForHeaderInSection: section)
    }
}

//extension LACustomerInfoViewController: LAMobileVerificationModalViewControllerDelegate {
//    func pushThankyouViewControllerAction() {
//        self.delegate?.pushThankyouViewControllerAction()
//    }
//}
