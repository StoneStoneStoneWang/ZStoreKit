//
//  UITextField+WL.swift
//  TSTFKit_Swift
//
//  Created by three stone 王 on 2018/11/17.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @objc (set_backgroundColor:)
    public func set_backgroundColor(_ color: UIColor) {
        
        backgroundColor = color
    }
    @objc (set_font:)
    public func set_font(_ font: UIFont) {
        
        self.font = font
    }
    @objc (set_textColor:)
    public func set_textColor(_ color: UIColor) {
        
        textColor = color
    }
    @objc (set_textAlignment:)
    public func set_textAlignment(_ alignment: NSTextAlignment) {
        
        textAlignment = alignment
    }
    @objc (set_keyboardType:)
    public func set_keyboardType(_ keyboardType: UIKeyboardType) {
        
        self.keyboardType = keyboardType
    }
    @objc (set_clearButtonMode:)
    public func set_clearButtonMode(_ clearButtonMode: UITextField.ViewMode) {
        
        self.clearButtonMode = clearButtonMode
        
    }
    @objc (set_returnKeyType:)
    public func set_returnKeyType(_ returnKeyType: UIReturnKeyType) {
        
        self.returnKeyType = returnKeyType
    }
    @objc (set_rightViewMode:)
    public func set_rightViewMode(_ rightViewMode: UITextField.ViewMode) {
        
        self.rightViewMode = rightViewMode
    }
    @objc (set_leftViewMode:)
    public func set_leftViewMode(_ leftViewMode: UITextField.ViewMode) {
        
        self.leftViewMode = leftViewMode
    }
    @objc (set_leftView:)
    public func set_leftView(_ leftView: UIView) {
        
        self.leftView = leftView
    }
    @objc (set_rightView:)
    public func set_rightView(_ rightView: UIView) {
        
        self.rightView = rightView
    }
}

public typealias TSShouldReturn = () -> Bool

public typealias TSShouldClear = () -> Bool

extension UITextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    fileprivate var shouldReturn: TSShouldReturn! {
        set {
            
            objc_setAssociatedObject(self, "shouldReturn", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, "shouldReturn") as? TSShouldReturn
        }
    }
    @objc (set_shouldReturn:)
    public func set_shouldReturn(_ shouldReturn: @escaping () -> Bool) {
        
        self.shouldReturn = shouldReturn
    }
    @objc (textFieldShouldReturn:)
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if shouldReturn == nil {
            
            return true
        }
        
        return shouldReturn!()
    }
    
    fileprivate var shouldClear: TSShouldClear! {
        
        set {
            
            objc_setAssociatedObject(self, "shouldClear", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, "shouldClear") as? TSShouldClear
        }
    }
    @objc (set_shouldClear:)
    public func set_shouldClear(_ shouldClear: @escaping () -> Bool) {
        
        self.shouldClear = shouldClear
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if shouldClear == nil {
            
            return true
        }
        
        return shouldClear!()
    }
}

