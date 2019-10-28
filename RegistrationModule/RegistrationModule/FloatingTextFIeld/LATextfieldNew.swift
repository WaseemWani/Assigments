//
//  LATextfieldNew.swift
//  LumiApp
//
//  Created by Disha on 21/08/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit
let kTextFieldTextPadding = 8.0 

enum LATextFieldMode {
    case nonFloatingMode
    case floatingMode
    case bottomAlignedMode
}

class LATextfieldNew: UITextField {

    var textFieldMode: LATextFieldMode = .floatingMode
    var offset: CGFloat = 0.0
    var nextIndex: IndexPath?
    var prevIndex: IndexPath?
    var currentIndex: IndexPath?
    var rightImageSidePadding: CGFloat = 0.0
    var isPointerHidden: Bool = false
    var labelFont: UIFont = UIFont()
    var restrictTextPaste: Bool = false
    var showUnderLine: Bool = false {
        didSet {
             underLineView.isHidden = !showUnderLine
            if showUnderLine == true {
                NotificationCenter.default.addObserver(self, selector: #selector(self.handleBeginEditing), name: UITextField.textDidBeginEditingNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(self.handleEndEditing), name: UITextField.textDidBeginEditingNotification, object: nil)

            } else {
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var placeholder: String? {
        didSet {
            guard let placeholderText = placeholder else {
                self.attributedPlaceholder = nil
                return
            }
            let dict = [NSAttributedString.Key.foregroundColor: UIColor.appTextFieldPlaceholderColor,
                            NSAttributedString.Key.font: self.font]
            attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: dict as [NSAttributedString.Key: Any])

            if let floatLabel = floatingLabel {
                floatLabel.text = placeholderText
                updateFloatingLabel()
            }
        }
    }
    
    fileprivate var textOffset: CGFloat = 0.0
    fileprivate var labelCenterY: CGFloat = 0.0
    fileprivate var labelY: CGFloat = 0.0
    fileprivate var translateY: CGFloat = 0.0
    fileprivate let floatingLabelTextPadding: CGFloat = 2.0
    fileprivate var kDefaultTextFieldOffset = 8.0
    fileprivate var floatingLabelShowAnimationDuration = 0.2
    fileprivate var floatingLabelHideAnimationDuration = 0.2
    fileprivate var underLineView: UIView = UIView()
    fileprivate var floatingLabel: UILabel?

    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    init(frame: CGRect, ofset offset: CGFloat, textfieldMode mode: LATextFieldMode) {
        super.init(frame: frame)
        self.offset = offset
        self.textFieldMode = mode
        self.backgroundColor = UIColor.white
        self.autocorrectionType = .no
        self.textAlignment = .natural
        self.commomInit()
    }
    
    func setTextFieldMode(mode: LATextFieldMode) {
        textFieldMode = mode
        if mode == .floatingMode {
            if self.floatingLabel == nil {
                self.floatingLabel = UILabel(frame: .zero)
                self.addSubview(self.floatingLabel ?? UILabel())
            }
            self.floatingLabel?.font = self.labelFont
            self.floatingLabel?.textColor =  UIColor.appTextFieldPlaceholderColor

        } else {
           self.floatingLabel?.removeFromSuperview()
            self.floatingLabel = nil
        }
    }
    
    fileprivate func commomInit() {
        
        underLineView.backgroundColor =  UIColor.appSeparatorColor
        underLineView.isHidden = true
        self.addSubview(underLineView)
        
        self.borderStyle = .none
        self.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        self.textColor = UIColor.appTextFieldFontColor
        self.tintColor =  UIColor.appBlueColor
        self.labelFont = UIFont.systemFont(ofSize: 13.0, weight: .light)

        if textFieldMode == .floatingMode {
            self.floatingLabel = UILabel(frame: .zero)
            self.floatingLabel?.font = self.labelFont
            self.floatingLabel?.textColor = UIColor.appTextFieldPlaceholderColor
            self.floatingLabel?.textAlignment = .natural
            self.addSubview(self.floatingLabel ?? UILabel())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commomInit()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect = rect.insetBy(dx: offset, dy: 0.0)
        rect.origin.y += textOffset
        return rect
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        if isPointerHidden {
            return .zero
        } else {
            return super.caretRect(for: position)
        }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        rect = rect.insetBy(dx: offset, dy: 0.0)
        rect.origin.y += textOffset
        return rect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= rightImageSidePadding
        rect.origin.y += textOffset
        return rect
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        rect.origin.y += textOffset
        return rect
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if self.restrictTextPaste {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    fileprivate func updateFloatingLabel() {
         let floatingLabelSize = floatingLabel?.intrinsicContentSize
        let semanticAttr = self.semanticContentAttribute
        let layoutDirection = UIView.userInterfaceLayoutDirection(for: semanticAttr)
        var o_x: CGFloat = 0.0
        if layoutDirection == .rightToLeft {
            o_x = self.bounds.size.width - (offset + (floatingLabelSize?.width ?? 0.0) / 2.0 )
        } else {
           o_x = offset + (floatingLabelSize?.width ?? 0.0) / 2.0
        }
        let o_y = labelCenterY
        floatingLabel?.bounds = CGRect(x: 0.0, y: 0.0, width: floatingLabelSize?.width ?? 0.0, height: floatingLabelSize?.height ?? 0.0)
        floatingLabel?.center = CGPoint(x: o_x, y: o_y)
    }
    
    @objc
    fileprivate func handleBeginEditing() {
        self.underLineView.backgroundColor = .lumiGreenThemeColor //UIColor.blue
    }
    
    @objc
    fileprivate func handleEndEditing() {
        self.underLineView.backgroundColor = UIColor.separator
    }

    override func layoutSubviews() {
        labelY = 0.0
        translateY = 0.0
        labelCenterY = 0.0
        textOffset = 0.0
        
        let textH = CGFloat(ceil(Float(self.font?.lineHeight ?? 8.0)))
        let textY = CGFloat(floorf(Float((self.bounds.size.height - textH) / 2.0)))

        if textFieldMode == .floatingMode {
            let padding = floatingLabelTextPadding
            let requiredH = ceil(self.labelFont.lineHeight) + ceil(self.font?.lineHeight ?? 8.0) + padding
            labelY = floor((self.bounds.size.height - requiredH) / 2.0)
            labelCenterY = labelY + ceil(self.labelFont.lineHeight) / 2.0
            translateY = self.bounds.size.height / 2.0 - labelCenterY
            textOffset = labelY + ceil(self.labelFont.lineHeight) + padding - textY
            updateFloatingLabel()
            if let textLength = self.text?.count, textLength > 0 {
                showFloatingLabel()
            } else {
                hideFloatingLabel()
            }
        } else if textFieldMode == .bottomAlignedMode {
            textOffset = textY - CGFloat(kDefaultTextFieldOffset)
        }
        underLineView.frame = CGRect(x: offset, y: self.bounds.size.height - 1, width: self.bounds.size.width - 2.0 * offset, height: 1)
        
        super.layoutSubviews()
    }
    
    fileprivate func showFloatingLabel() {
     
        let isActive = self.isFirstResponder
        
        let showClosure: () -> Void = {
            self.floatingLabel?.alpha = 1.0
            self.floatingLabel?.transform = .identity
        }
        
        if isActive {
            UIView.animate(withDuration: floatingLabelShowAnimationDuration, delay: 0.0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                showClosure()
            }, completion: nil )
        } else {
            showClosure()
        }
    }
    
    fileprivate func hideFloatingLabel() {
        let isActive = self.isFirstResponder
        
        let hideClosure: () -> Void = {
            self.floatingLabel?.alpha = 0.0
            self.floatingLabel?.transform = CGAffineTransform(translationX: 0.0, y: self.translateY)
        }
        
        if isActive {
            UIView.animate(withDuration: floatingLabelHideAnimationDuration, delay: 0.0, options: [.beginFromCurrentState, .curveEaseOut], animations: {
                hideClosure()
            }, completion: nil)
            
        } else {
            hideClosure()
        }
    }
}
