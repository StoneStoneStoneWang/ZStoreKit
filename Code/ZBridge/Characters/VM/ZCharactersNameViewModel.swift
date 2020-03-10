//
//  ZCharactersNameViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/6.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import RxCocoa
import WLBaseViewModel
import WLBaseResult

struct ZCharactersNameViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let orignal: Driver<String>
        
        let updated:Driver<String>
        
        let completTaps:Signal<Void>
    }
    
    struct WLOutput {
        
        let completeEnabled: Driver<Bool>
        
        let completed: Driver<WLBaseResult>
    }
    
    init(_ input: WLInput) {
        
        self.input = input
        
        let ou = Driver.combineLatest(input.orignal, input.updated)
        
        let completEnabled = ou.flatMapLatest { return Driver.just($0.0 != $0.1 && !$0.1.isEmpty && !$0.1.wl_isEmpty) }
        
        let completed: Driver<WLBaseResult> = input.completTaps
            .withLatestFrom(input.updated)
            .flatMapLatest({
                
                if $0.isEmpty {
                    
                    return Driver<WLBaseResult>.just(WLBaseResult.failed("请输入角色姓名"))
                }
                
                return Driver<WLBaseResult>.just(WLBaseResult.ok($0))
                
            })
        
        self.output = WLOutput(completeEnabled: completEnabled, completed: completed)
    }
}
