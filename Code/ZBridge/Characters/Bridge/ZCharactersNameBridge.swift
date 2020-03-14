//
//  ZCharactersNameBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/6.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import ZBase
import ZHud
import ZBean
import RxCocoa
import ZCache
import RxSwift
import ZBridge

@objc (ZCharactersNameBridge)
public final class ZCharactersNameBridge: ZBaseBridge {
    
    var viewModel: ZCharactersNameViewModel!
    
    let nickname: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
}

extension ZCharactersNameBridge {
    
    @objc public func createCharactersName(_ vc: ZBaseViewController ,nameValue: String,succ: @escaping (_ value: String) -> () ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let name = vc.view.viewWithTag(201) as? UITextField ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton{
            
            nickname.accept(nameValue)
            
            let inputs = ZCharactersNameViewModel.WLInput(orignal: nickname.asDriver(),
                                                          updated: name.rx.text.orEmpty.asDriver(),
                                                          completTaps: completeItem.rx.tap.asSignal())
            
            name.text = nickname.value
            
            viewModel = ZCharactersNameViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completed
                .drive(onNext: { (result) in
                    
                    switch result {
                    case .ok(let v):
                        
                        succ(v)
                        
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
                    
                    vc.dismiss(animated: true, completion: nil)
                })
                .disposed(by: disposed)
        }
    }
}
