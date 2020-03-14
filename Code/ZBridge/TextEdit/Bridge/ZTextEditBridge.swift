//
//  ZTextEditBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZBase
import RxCocoa
import RxSwift

@objc (ZTextEditBridge)
public final class ZTextEditBridge: ZBaseBridge {
    
    var viewModel: ZTextEditViewModel!
    
    let signature: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
}

extension ZTextEditBridge {
    
    @objc public func createTextEdit(_ vc: ZBaseViewController ,succ: @escaping (_ text: String) -> () ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let signaturetv = vc.view.viewWithTag(201) as? UITextView ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton {
            
            let inputs = ZTextEditViewModel.WLInput(orignal: signature.asDriver(),
                                                     updated: signaturetv.rx.text.orEmpty.asDriver(),
                                                     completTaps: completeItem.rx.tap.asSignal())
            
            signaturetv.text = signature.value
            
            viewModel = ZTextEditViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completed
                .drive(onNext: { (result) in
                    
                    succ(result)
                    
                    vc.navigationController?.dismiss(animated: true, completion: nil)
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
