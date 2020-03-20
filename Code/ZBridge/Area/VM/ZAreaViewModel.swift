//
//  ZAreaViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/13.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import ZBean

struct ZAreaViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let areas: [ZAreaBean]
        
        let modelSelect: ControlEvent<ZAreaBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(ZAreaBean,IndexPath)>
        
        let tableData: BehaviorRelay<[ZAreaBean]> = BehaviorRelay<[ZAreaBean]>(value: [])
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        output.tableData.accept(input.areas)
        
        self.output = output
    }
}
