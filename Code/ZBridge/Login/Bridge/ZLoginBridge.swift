//
//  ZLoginBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZBase
import ZHud
import ZNoti
import RxCocoa
import RxSwift

@objc (ZLoginBridge)
public final class ZLoginBridge: ZBaseBridge {
    
    public var viewModel: ZLoginViewModel!
}
extension ZLoginBridge {
    
    @objc public func configViewModel(_ vc: ZBaseViewController) {
        
        if let phone = vc.view.viewWithTag(201) as? UITextField ,let password = vc.view.viewWithTag(202) as? UITextField ,let loginItem = vc.view.viewWithTag(203) as? UIButton
         , let swiftLoginItem = vc.view.viewWithTag(204) as? UIButton ,let forgetItem = vc.view.viewWithTag(205) as? UIButton , let passwordItem = password.viewWithTag(206) as? UIButton ,let backItem = vc.navigationItem.leftBarButtonItem {
            
            let input = ZLoginViewModel.WLInput(username: phone.rx.text.orEmpty.asDriver(),
                                                password: password.rx.text.orEmpty.asDriver() ,
                                                loginTaps: loginItem.rx.tap.asSignal(),
                                                swiftLoginTaps: swiftLoginItem.rx.tap.asSignal(),
                                                forgetTaps: forgetItem.rx.tap.asSignal(),
                                                passwordItemTaps: passwordItem.rx.tap.asSignal())
            
            viewModel = ZLoginViewModel(input)
            
            backItem
                .rx
                .tap
                .subscribe(onNext: { [weak self] (_) in
                    
                    guard let `self` = self else { return }
                    
                })
                .disposed(by: disposed)
            
            // MARK: 登录点击中序列
            viewModel
                .output
                .logining
                .drive(onNext: { [weak self] _ in
                    
                    guard let `self` = self else { return }
                    
                    vc.view.endEditing(true)
                    
                    ZHudUtil.show(withStatus: "登录中...")
                })
                .disposed(by: disposed)
            
            // MARK: 登录事件返回序列
            viewModel
                .output
                .logined
                .drive(onNext: { [weak self] in
                    guard let `self` = self else { return }
                    
                    ZHudUtil.pop()
                    
                    switch $0 {
                        
                    case let .failed(msg): ZHudUtil.showInfo(msg)
                        
                    case .logined:
                        
                        ZHudUtil.showInfo("登录成功")
                        
                        ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiLoginSucc), andValue: nil, andFrom: vc)
                        
                    default: break
                    }
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .swiftLogined
                .drive(onNext: { [weak self]  (_) in
                    
                    guard let `self` = self else { return }
                    
                    ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiGotoReg), andValue: nil, andFrom: vc)
                    
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .forgeted
                .drive(onNext: { [weak self]  (_) in
                    
                    guard let `self` = self else { return }
                    
                    ZNotiConfigration.postNotification(withName: NSNotification.Name(rawValue: ZNotiGotoFindPwd), andValue: nil, andFrom: vc)
                    
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .passwordItemed
                .drive(passwordItem.rx.isSelected)
                .disposed(by: disposed)
            
            viewModel
                .output
                .passwordEntryed
                .drive(password.rx.isSecureTextEntry)
                .disposed(by: disposed)
        }
        
    }
}
