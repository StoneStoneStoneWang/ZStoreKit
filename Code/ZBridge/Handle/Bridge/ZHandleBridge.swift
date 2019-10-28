//
//  ZHandleBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/10/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CoreLocation
import ZTransition

@objc (ZHandleBridge)
public final class ZHandleBridge: ZBaseBridge {
    
    var viewModel: ZHandleViewModel!
    
    var location: BehaviorRelay<CLLocation> = BehaviorRelay<CLLocation>(value: CLLocation(latitude: 39, longitude: 106))
    
    var locAddress: BehaviorRelay<String> = BehaviorRelay<String>(value: "北京")
}

extension ZHandleBridge {
    
    @objc public func createHandle(_ vc: ZTViewController,completeItem: UIButton,succ: @escaping (Bool,CLLocation?,String?) -> ()) {
        
        let input = ZHandleViewModel.WLInput(completeTaps: completeItem.rx.tap.asSignal(),
                                             location: location,
                                             locAddress: locAddress)
        
        viewModel = ZHandleViewModel(input)
        
        viewModel
            .output
            .completed
            .drive(onNext: { succ($0.0,$0.1,$0.2) })
            .disposed(by: disposed)
        
    }
    
    @objc public func updateLocation(_ location: CLLocation) {
        
        self.location.accept(location)
    }
    
    @objc public func updateLocationAddress(_ address: String) {
        
        self.locAddress.accept(address)
    }
}

