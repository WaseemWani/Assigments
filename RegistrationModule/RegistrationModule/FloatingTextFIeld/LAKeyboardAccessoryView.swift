//
//  LAKeyboardAccessoryView.swift
//  ENDB
//
//  Created by Disha on 17/07/19.
//  Copyright © 2019 Vishal Gupta. All rights reserved.
//

import UIKit
//import LanguageManager_iOS

enum LAAccessoryViewMode {
    case LAAllButtons
    case LADoneButtonOnly
}

/// This protocol is used to implement keyboard accessory view delegate methods
protocol LAKeyboardAccessoryViewDelegate: class {
    
    /// This method is used to perform done button action on the keyboard accessory view
    func doneButtonTapped()
    
    func didTapNextButton()
    func didTapPreviousButton()
    func didTapNextForIndex(index: NSInteger)
    func didTapPreviousForIndex(index: NSInteger)
}

/// This is a custom class to implement keyboard accessory view in Textfields
class LAKeyboardAccessoryView: UIView {
    
    weak var delegate: LAKeyboardAccessoryViewDelegate?
    fileprivate var toolbar = UIToolbar()
    fileprivate var doneButton = UIBarButtonItem()
    fileprivate var nextButton = UIBarButtonItem()
    fileprivate var previousButton = UIBarButtonItem()
    
    var mode: LAAccessoryViewMode = .LADoneButtonOnly
    
    // MARK: - View lifecycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp(withFrame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, mode: LAAccessoryViewMode) {
        super.init(frame: frame)
        self.mode = mode
        self.setUp(withFrame: frame)
        
    }
    
    internal func setUp(withFrame frame: CGRect) {
        toolbar = UIToolbar(frame: frame)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let fixed = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixed.width = 30.0
        doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction(_:)))
//        previousButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(didTapPreviousButton(_:)))
//        nextButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style: .plain, target: self, action: #selector(didTapNextButton(_:)))
        
        previousButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(didTapPreviousButton(_:)))
        nextButton = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: self, action: #selector(didTapNextButton(_:)))

        var barItems: [UIBarButtonItem] = []
            if self.mode == .LADoneButtonOnly {
                barItems = [flexSpace, doneButton]
            } else {
                barItems = [doneButton, flexSpace, previousButton, fixed, nextButton]
            }
        toolbar.setItems(barItems, animated: false)
        toolbar.sizeToFit()
        self.addSubview(toolbar)
    }
    
    override func layoutSubviews() {
        self.toolbar.frame = self.bounds
    }
    
    func disablePrevious() {
        self.nextButton.isEnabled = true
        self.previousButton.isEnabled = false
    }
    
    func disableNext() {
        self.nextButton.isEnabled = false
        self.previousButton.isEnabled = true
    }
    
    func enableAll() {
        self.nextButton.isEnabled = true
        self.previousButton.isEnabled = true
    }
    
    func disableAll() {
        self.nextButton.isEnabled = false
        self.previousButton.isEnabled = false
    }
    
    func disablePreviousAndNext() {
        self.nextButton.isEnabled = false
        self.previousButton.isEnabled = false
    }
    
    func hideNextAndPrevious() {
        self.nextButton.tintColor = UIColor.clear
        self.previousButton.tintColor = UIColor.clear
    }
    
    /// This method is used to perform done button action on keyboard accessory view
    ///
    /// - Parameter sender: sender button
    @objc
    func doneButtonAction(_ sender: UIButton) {
        delegate?.doneButtonTapped()
    }
    
    /// This method is used to perform done button action on keyboard accessory view
    ///
    /// - Parameter sender: sender button
    @objc
    func didTapPreviousButton(_ sender: UIButton) {
        delegate?.didTapPreviousButton()
        delegate?.didTapPreviousForIndex(index: self.tag)
    }
    
    /// This method is used to perform done button action on keyboard accessory view
    ///
    /// - Parameter sender: sender button
    @objc
    func didTapNextButton(_ sender: UIButton) {
        
        delegate?.didTapNextButton()
        delegate?.didTapNextForIndex(index: self.tag)
    }
}

extension LAKeyboardAccessoryViewDelegate {
    func didTapNextButton() {
        
    }
    
    func didTapPreviousButton() {
        
    }
    
    func didTapNextForIndex(index: NSInteger) {
        
    }
    
    func didTapPreviousForIndex(index: NSInteger) {
        
    }
}
