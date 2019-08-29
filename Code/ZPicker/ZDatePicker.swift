//
//  ZDatePicker.swift
//  ZDatePickerDemo
//
//  Created by three stone 王 on 2019/3/18.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import UIKit

private extension Selector {
    static let btnTaps = #selector(ZDatePicker.btnTaps)
}

@objc public final class ZDatePicker: UIView {
    public typealias ZDatePickerCallback = ( Date? ) -> ()
    
    // MARK: - Constants
    private let kDefaultButtonHeight: CGFloat = 50
    private let kDefaultButtonSpacerHeight: CGFloat = 1
    private let kCornerRadius: CGFloat = 7
    private let kDoneButtonTag: Int     = 1
    
    // MARK: - Views
    private var dialogView: UIView!
    private var titleLabel: UILabel!
    private var datePicker: UIDatePicker!
    private var cancelButton: UIButton!
    private var doneButton: UIButton!
    
    // MARK: - Variables
    private var defaultDate: Date?
    private var datePickerMode: UIDatePicker.Mode = .dateAndTime
    private var callback: ZDatePickerCallback!
    private var showCancelButton: Bool = false
    private var locale: Locale?
    
    private var textColor: UIColor!
    private var buttonColor: UIColor!
    private var font: UIFont!
    
    // MARK: - Dialog initialization
    @objc public init(textColor: UIColor = UIColor.black,
                      buttonColor: UIColor = UIColor.blue,
                      font: UIFont = .boldSystemFont(ofSize: 15),
                      locale: Locale? = nil,
                      showCancelButton: Bool = true) {
        let size = UIScreen.main.bounds.size
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.textColor = textColor
        self.buttonColor = buttonColor
        self.font = font
        self.showCancelButton = showCancelButton
        self.locale = locale
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        dialogView = createContainerView()
        
        dialogView!.layer.shouldRasterize = true
        dialogView!.layer.rasterizationScale = UIScreen.main.scale
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        dialogView!.layer.opacity = 0.5
        dialogView!.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        addSubview(dialogView!)
    }
    
    /// Create the dialog view, and animate opening the dialog
    @objc public func show(_ title: String,
                           doneButtonTitle: String = "Done",
                           cancelButtonTitle: String = "Cancel",
                           defaultDate: Date = Date(),
                           minimumDate: Date? = nil, maximumDate: Date? = nil,
                           datePickerMode: UIDatePicker.Mode = .dateAndTime,
                           callback: @escaping ZDatePickerCallback) {
        self.titleLabel.text = title
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        if showCancelButton {
            self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        }
        self.datePickerMode = datePickerMode
        self.callback = callback
        self.defaultDate = defaultDate
        self.datePicker.datePickerMode = self.datePickerMode
        self.datePicker.date = self.defaultDate ?? Date()
        self.datePicker.maximumDate = maximumDate
        self.datePicker.minimumDate = minimumDate
        if let locale = locale {
            datePicker.locale = locale
        }
        /* Add dialog to main window */
        guard let appDelegate = UIApplication.shared.delegate else { fatalError() }
        guard let window = appDelegate.window else { fatalError() }
        window?.addSubview(self)
        window?.bringSubviewToFront(self)
        window?.endEditing(true)
        
        /* Anim */
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                self.dialogView!.layer.opacity = 1
                self.dialogView!.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    /// Dialog close animation then cleaning and removing the view from the parent
    private func close() {
        let currentTransform = dialogView.layer.transform
        
        let startRotation = (value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + .pi * 270 / 180), 0, 0, 0)
        
        dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        dialogView.layer.opacity = 1
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [],
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                let transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self.dialogView.layer.transform = transform
                self.dialogView.layer.opacity = 0
        }) { (_) in
            for v in self.subviews {
                v.removeFromSuperview()
            }
            
            self.removeFromSuperview()
            self.setupView()
        }
    }
    
    /// Creates the container view here: create the dialog, then add the custom content and buttons
    private func createContainerView() -> UIView {
        let screenSize = UIScreen.main.bounds.size
        let dialogSize = CGSize(width: 300, height: 230 + kDefaultButtonHeight + kDefaultButtonSpacerHeight)
        
        // For the black background
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        // This is the dialog's container; we attach the custom content and the buttons to this one
        let container = UIView(frame: CGRect(x: (screenSize.width - dialogSize.width) / 2,
                                             y: (screenSize.height - dialogSize.height) / 2,
                                             width: dialogSize.width,
                                             height: dialogSize.height))
        
        // First, we style the dialog to match the iOS8 UIAlertView >>>
        let gradient: CAGradientLayer = CAGradientLayer(layer: self.layer)
        gradient.frame = container.bounds
        gradient.colors = [UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor,
                           UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1).cgColor,
                           UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor]
        
        let cornerRadius = kCornerRadius
        gradient.cornerRadius = cornerRadius
        container.layer.insertSublayer(gradient, at: 0)
        
        container.layer.cornerRadius = cornerRadius
        container.layer.borderColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        container.layer.borderWidth = 1
        container.layer.shadowRadius = cornerRadius + 5
        container.layer.shadowOpacity = 0.1
        container.layer.shadowOffset = CGSize(width: 0 - (cornerRadius + 5) / 2, height: 0 - (cornerRadius + 5) / 2)
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowPath = UIBezierPath(roundedRect: container.bounds,
                                                  cornerRadius: container.layer.cornerRadius).cgPath
        
        // There is a line above the button
        let yPosition = container.bounds.size.height - kDefaultButtonHeight - kDefaultButtonSpacerHeight
        let lineView = UIView(frame: CGRect(x: 0,
                                            y: yPosition,
                                            width: container.bounds.size.width,
                                            height: kDefaultButtonSpacerHeight))
        lineView.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        container.addSubview(lineView)
        
        //Title
        titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 280, height: 30))
        titleLabel.textAlignment = .center
        titleLabel.textColor = textColor
        titleLabel.font = font.withSize(17)
        container.addSubview(titleLabel)
        
        datePicker = configuredDatePicker()
        container.addSubview(datePicker)
        
        // Add the buttons
        addButtonsToView(container: container)
        
        return container
    }
    
    fileprivate func configuredDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 30, width: 0, height: 0))
        datePicker.setValue(textColor, forKeyPath: "textColor")
        datePicker.autoresizingMask = .flexibleRightMargin
        datePicker.frame.size.width = 300
        datePicker.frame.size.height = 216
        return datePicker
    }
    
    /// Add buttons to container
    private func addButtonsToView(container: UIView) {
        var buttonWidth = container.bounds.size.width / 2
        
        var leftButtonFrame = CGRect(
            x: 0,
            y: container.bounds.size.height - kDefaultButtonHeight,
            width: buttonWidth,
            height: kDefaultButtonHeight
        )
        var rightButtonFrame = CGRect(
            x: buttonWidth,
            y: container.bounds.size.height - kDefaultButtonHeight,
            width: buttonWidth,
            height: kDefaultButtonHeight
        )
        if !showCancelButton {
            buttonWidth = container.bounds.size.width
            leftButtonFrame = CGRect()
            rightButtonFrame = CGRect(
                x: 0,
                y: container.bounds.size.height - kDefaultButtonHeight,
                width: buttonWidth,
                height: kDefaultButtonHeight
            )
        }
        let interfaceLayoutDirection = UIApplication.shared.userInterfaceLayoutDirection
        let isLeftToRightDirection = interfaceLayoutDirection == .leftToRight
        
        if showCancelButton {
            cancelButton = UIButton(type: .custom) as UIButton
            cancelButton.frame = isLeftToRightDirection ? leftButtonFrame : rightButtonFrame
            cancelButton.setTitleColor(buttonColor, for: .normal)
            cancelButton.setTitleColor(buttonColor, for: .highlighted)
            cancelButton.titleLabel!.font = self.font.withSize(14)
            cancelButton.layer.cornerRadius = kCornerRadius
            cancelButton.addTarget(self, action: .btnTaps, for: .touchUpInside)
            container.addSubview(self.cancelButton)
        }
        doneButton = UIButton(type: .custom) as UIButton
        doneButton.frame = isLeftToRightDirection ? rightButtonFrame : leftButtonFrame
        doneButton.tag = kDoneButtonTag
        doneButton.setTitleColor(buttonColor, for: .normal)
        doneButton.setTitleColor(buttonColor, for: .highlighted)
        doneButton.titleLabel!.font = font.withSize(14)
        doneButton.layer.cornerRadius = kCornerRadius
        doneButton.addTarget(self, action: .btnTaps, for: .touchUpInside)
        container.addSubview(doneButton)
    }
    
    @objc fileprivate func btnTaps(sender: UIButton) {
        
        callback(sender.tag == kDoneButtonTag ? datePicker.date : nil)
        
        close()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
