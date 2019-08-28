//
//  ZSignatureBridge.swift
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


@objc (ZSignatureBridge)
public final class ZSignatureBridge: ZBaseBridge {
    
    var viewModel: ZSignatureViewModel!
    
    let signature: BehaviorRelay<String> = BehaviorRelay<String>(value: ZUserInfoCache.default.userBean.signature)
}

extension ZSignatureBridge {
    
    @objc public func createSignature(_ vc: ZBaseViewController ,succ: @escaping () -> () ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let signaturetv = vc.view.viewWithTag(201) as? UITextView ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton {
            
            let inputs = ZSignatureViewModel.WLInput(orignal: signature.asDriver(),
                                                      updated: signaturetv.rx.text.orEmpty.asDriver(),
                                                      completTaps: completeItem.rx.tap.asSignal())
            
            signaturetv.text = signature.value
            
            viewModel = ZSignatureViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completing
                .drive(onNext: { (_) in
 
                    ZHudUtil.show(withStatus: "修改个性签名...")
                    
                    signaturetv.resignFirstResponder()
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
            
            backItem
                .rx
                .tap
                .subscribe(onNext: { (_) in
                    
                    vc.navigationController?.dismiss(animated: true, completion: nil)
                })
                .disposed(by: disposed)
        }
    }
}
