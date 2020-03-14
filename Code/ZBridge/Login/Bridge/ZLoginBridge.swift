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
import RxCocoa
import RxSwift
import ZCocoa

@objc(ZLoginActionType)
public enum ZLoginActionType: Int ,Codable {
    
    case swiftLogin = 0
    
    case loginSucc = 1
    
    case gotoFindPwd = 2
    
    case backItem = 3
}

public typealias ZLoginAction = (_ action: ZLoginActionType ,_ vc: ZBaseViewController) -> ()

@objc (ZLoginBridge)
public final class ZLoginBridge: ZBaseBridge {
    
    public var viewModel: ZLoginViewModel!
}

// MARK: 201 手机号 202 密码 203 登陆按钮 204 快捷登录按钮 205 忘记密码按钮 206
extension ZLoginBridge {
    
    @objc public func configViewModel(_ vc: ZBaseViewController ,loginAction: @escaping ZLoginAction) {
        
        if let phone = vc.view.viewWithTag(201) as? UITextField ,let password = vc.view.viewWithTag(202) as? UITextField ,let loginItem = vc.view.viewWithTag(203) as? UIButton
            , let swiftLoginItem = vc.view.viewWithTag(204) as? UIButton ,let forgetItem = vc.view.viewWithTag(205) as? UIButton , let passwordItem = password.rightView
            as? UIButton ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton {
            
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
                .subscribe(onNext: { (_) in
                    
                    loginAction(.backItem,vc)
                })
                .disposed(by: disposed)
            
            // MARK: 登录点击中序列
            viewModel
                .output
                .logining
                .drive(onNext: { _ in
                    
                    vc.view.endEditing(true)
                    
                    ZHudUtil.show(withStatus: "登录中...")
                })
                .disposed(by: disposed)
            
            // MARK: 登录事件返回序列
            viewModel
                .output
                .logined
                .drive(onNext: {
                    
                    ZHudUtil.pop()
                    
                    switch $0 {
                        
                    case let .failed(msg): ZHudUtil.showInfo(msg)
                        
                    case .logined:
                        
                        ZHudUtil.showInfo("登录成功")
                        
                        loginAction(.loginSucc,vc)

                        
                    default: break
                    }
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .swiftLogined
                .drive(onNext: { (_) in
                    
                    loginAction(.swiftLogin,vc)
    
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .forgeted
                .drive(onNext: {(_) in
                    
                    loginAction(.gotoFindPwd,vc)
                    
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
