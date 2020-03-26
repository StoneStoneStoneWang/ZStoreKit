//
//  ZProtocolBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import ZTextInner

@objc (ZProtocolBridge)
public final class ZProtocolBridge: ZBaseBridge {
    
    public var viewModel: ZProtocolViewModel!
    
}

extension ZProtocolBridge {
    
    @objc public func createProtocol(_ vc: ZTextInnerViewController) {
        
        let inputs = ZProtocolViewModel.WLInput()
        
        viewModel = ZProtocolViewModel(inputs)
        
        viewModel
            .output
            .contented
            .asObservable()
            .subscribe(onNext: {(value) in
                
                DispatchQueue.main.async {
                    
                    vc.loadHtmlString(value)
                }
                
            })
            .disposed(by: disposed)
    }
}
