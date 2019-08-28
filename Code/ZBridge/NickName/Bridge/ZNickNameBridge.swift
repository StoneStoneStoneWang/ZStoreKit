//
//  ZNickNameBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZBase
import ZHud
import ZBean
import RxCocoa
import ZCache
import RxSwift

//extension Reactive where Base: ZNickNameBridge {
//
//    public var complete: Observable<ZUserBean> {
//
//        return self.base.userBean.asObservable()
//    }
//}

@objc (ZNickNameBridge)
public final class ZNickNameBridge: ZBaseBridge {
    
    var viewModel: ZNickNameViewModel!
    
    let nickname: BehaviorRelay<String> = BehaviorRelay<String>(value: ZUserInfoCache.default.userBean.nickname)
}

extension ZNickNameBridge {
    
    @objc public func createNickName(_ vc: ZBaseViewController) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem ,let name = vc.view.viewWithTag(201) as? UITextField {
            
            let inputs = ZNickNameViewModel.WLInput(orignal: nickname.asDriver(),
                                                       updated: name.rx.text.orEmpty.asDriver(),
                                                       completTaps: completeItem.rx.tap.asSignal())
            
            viewModel = ZNickNameViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completing
                .drive(onNext: { (_) in
                    
                    name.resignFirstResponder()
                    
                    ZHudUtil.show(withStatus: "修改昵称中...")
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .completed
                .drive(onNext: { (result) in
                    
                    ZHudUtil.pop()
                    
                    switch result {
                    case let .updateUserInfoSucc(_, msg: msg):
                        
                        ZHudUtil.showInfo(msg)
                        
                        vc.dismiss(animated: true, completion: nil)
                        
                    case let .failed(msg):
                        
                        ZHudUtil.showInfo(msg)
                    default: break
                        
                    }
                })
                .disposed(by: disposed)
        }
    }
}
