//
//  ZTextEditBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxCocoa
import WLReqKit
import WLBaseViewModel
import WLToolsKit

struct ZTextEditViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let orignal: Driver<String>
        
        let updated:Driver<String>
        
        let completTaps:Signal<Void>
    }
    
    struct WLOutput {
        
        let completeEnabled: Driver<Bool>
        
        let completed: Driver<String>
    }
    
    init(_ input: WLInput) {
        
        self.input = input
        
        let ou = Driver.combineLatest(input.orignal, input.updated)
        
        let completEnabled = ou.flatMapLatest { return Driver.just($0.0 != $0.1 && !$0.1.isEmpty && !$0.1.wl_isEmpty) }
        
        let completed: Driver<String> = input.completTaps
            .withLatestFrom(input.updated)
            .flatMapLatest({ return Driver.just($0) })
        
        self.output = WLOutput(completeEnabled: completEnabled, completed: completed)
    }
}
