//
//  ZModifyPwdBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZBase
import ZHud
import RxCocoa
import RxSwift
import ZCocoa

public typealias ZModifyPwdAction = (_ vc: ZBaseViewController) -> ()

@objc (ZModifyPwdBridge)
public final class ZModifyPwdBridge: ZBaseBridge {
    
    public var viewModel: ZModifyPwdViewModel!
}
// MARK:  旧密码201 新密码 202 确认密码 203 修改密码
extension ZModifyPwdBridge {
    
    @objc public func configViewModel(_ vc: ZBaseViewController ,pwdAction: @escaping ZModifyPwdAction) {
        
        if let oldpassword = vc.view.viewWithTag(201) as? UITextField ,let password = vc.view.viewWithTag(202) as? UITextField ,let passwordAgain = vc.view.viewWithTag(203) as? UITextField ,let completeItem = vc.view.viewWithTag(204) as? UIButton {
            
            let input = ZModifyPwdViewModel.WLInput(oldpassword: oldpassword.rx.text.orEmpty.asDriver(),
                                                    password: password.rx.text.orEmpty.asDriver() ,
                                                    passwordAgain: passwordAgain.rx.text.orEmpty.asDriver(),
                                                    completeTaps: completeItem.rx.tap.asSignal())
            
            viewModel = ZModifyPwdViewModel(input, disposed: disposed)
            
            // MARK: 修改密码 点击
            viewModel
                .output
                .completing
                .drive(onNext: { _ in
                    
                    vc.view.endEditing(true)
                    
                    ZHudUtil.show(withStatus: "修改密码中...")
                    
                })
                .disposed(by: disposed)
            
            // MARK: 修改密码 完成
            viewModel
                .output
                .completed
                .drive(onNext: {
                    
                    ZHudUtil.pop()
                    
                    switch $0 {
                        
                    case let .failed(msg): ZHudUtil.showInfo(msg)
                        
                    case let .ok(msg):
                        
                        ZHudUtil.showInfo(msg)
                        
                        pwdAction(vc)
                        
                    default: break
                    }
                })
                .disposed(by: disposed)
        }
    }
}
