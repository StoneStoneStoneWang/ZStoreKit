//
//  WLPasswordTextFiled.swift
//  WLCompoentViewDemo
//
//  Created by three stone 王 on 2019/4/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

@objc (WLPasswordImageTextFiled)
public final class WLPasswordImageTextFiled: WLLeftImageTextField {
    
    @objc (passwordItem)
    public final let passwordItem: UIButton = UIButton(type: .custom)
    @objc (normalIcon)
    public  var normalIcon: String = "" {
        
        willSet {
            guard !newValue.isEmpty else { return }
            passwordItem.setImage(UIImage(named: newValue), for: .normal)
            passwordItem.setImage(UIImage(named: newValue), for: .highlighted)
        }
    }
    @objc (selectedIcon)
    public var selectedIcon: String = "" {
        
        willSet {
            guard !newValue.isEmpty else { return }
            passwordItem.setImage(UIImage(named: newValue), for: .selected)
        }
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.rightViewRect(forBounds: bounds)
        
        return CGRect(x: rect.minX - 30, y: rect.minY, width: rect.width , height: rect.height)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.editingRect(forBounds: bounds)
        
        return CGRect(x: rect.minX, y: rect.minY, width: rect.width  - 30, height: rect.height)
    }
    
    @objc (commitInit)
    public override func commitInit() {
        super.commitInit()
        
        set_rightView(passwordItem)
        
        set_rightViewMode(.always)
        
        set_editType(.secret)
        
        set_maxLength(18)
        
        set_secureTextEntry(true)
        
    }
}

@objc (WLPasswordTitleTextFiled)
public final class WLPasswordTitleTextFiled: WLLeftTitleTextField {
    
    @objc (passwordItem)
    public final let passwordItem: UIButton = UIButton(type: .custom)
    
    @objc (normalIcon)
    public  var normalIcon: String = "" {
        
        willSet {
            guard !newValue.isEmpty else { return }
            passwordItem.setImage(UIImage(named: newValue), for: .normal)
            passwordItem.setImage(UIImage(named: newValue), for: .highlighted)
        }
    }
    @objc (selectedIcon)
    public var selectedIcon: String = "" {
        
        willSet {
            guard !newValue.isEmpty else { return }
            passwordItem.setImage(UIImage(named: newValue), for: .selected)
        }
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.rightViewRect(forBounds: bounds)
        
        return CGRect(x: rect.minX - 30, y: rect.minY, width: rect.width , height: rect.height)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = super.editingRect(forBounds: bounds)
        
        return CGRect(x: rect.minX, y: rect.minY, width: rect.width  - 30, height: rect.height)
    }
    @objc (commitInit)
    public override func commitInit() {
        super.commitInit()
        
        set_rightView(passwordItem)
        
        set_rightViewMode(.always)
        
        set_editType(.secret)
        
        set_maxLength(18)
        
        set_secureTextEntry(true)
        
    }
}
