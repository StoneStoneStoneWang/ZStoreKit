//
//  ZHandleViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/10/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import CoreLocation
import ZCache

struct ZHandleViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let completeTaps: Signal<Void>
        
        let location: BehaviorRelay<CLLocation>
        
        let locAddress: BehaviorRelay<String>
    }
    struct WLOutput {
        
        var completed: Driver<(Bool,CLLocation?,String?)>
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let completed = input.completeTaps.flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, (Bool, CLLocation?, String?)> in
            
            if ZAccountCache.default.isLogin() {

                return Driver<(Bool,CLLocation?,String?)>.just((true,input.location.value,input.locAddress.value))
            } else {

                return Driver<(Bool,CLLocation?,String?)>.just((false,nil,nil))
            }
        }
        
        let output = WLOutput( completed: completed)
        
        self.output = output
    }
    
}
