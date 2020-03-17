//
//  ZCommentAddBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/13.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import ZTransition
import RxDataSources
import ZCocoa
import ZBean
import ZHud
import ZBridge
public typealias ZCommentAddSucc = () -> ()

@objc (ZCommentAddBridge)
public final class ZCommentAddBridge: ZBaseBridge {
    
    var viewModel: ZCommentAddViewModel!
    
    weak var vc: ZTViewController!
}
extension ZCommentAddBridge {
    
    @objc public func createCommentAdd(_ vc: ZTViewController ,sendAction: @escaping ZCommentAddSucc) {
        
        if let _ = vc.view.viewWithTag(201) as? UITextView ,let sendItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton {
            
            self.vc = vc
            
            let input = ZCommentAddViewModel.WLInput(sendTaps: sendItem.rx.tap.asSignal())
            
            viewModel = ZCommentAddViewModel(input, disposed: disposed)
            
            viewModel
                .output
                .sended
                .drive(onNext: { (_) in
                    
                    sendAction()
                })
                .disposed(by: disposed)
        }
    }
    
    
}
