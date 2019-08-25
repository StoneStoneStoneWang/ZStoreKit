//
//  ZPrivacyBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZInner;

@objc (ZPrivacyBridge)
public final class ZPrivacyBridge: ZBaseBridge {
    
    public var viewModel: ZPrivacyViewModel!
    
}
extension ZPrivacyBridge {
    
    @objc public func configViewModel(_ vc: ZInnerViewController) {
        
        let inputs = ZPrivacyViewModel.WLInput()
        
        viewModel = ZPrivacyViewModel(inputs)
        
        viewModel
            .output
            .contented
            .asObservable()
            .subscribe(onNext: {(value) in
                
                DispatchQueue.main.async {
                    
                    vc.loadHtml(value)
                }
                
            })
            .disposed(by: disposed)
    }
}
