//
//  ZContentViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/9/19.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import ZBean
import WLBaseResult

struct ZContentViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZKeyValueBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let circle: ZCircleBean
    }
    
    struct WLOutput {
        
        let zip: Observable<(ZKeyValueBean,IndexPath)>
        
        let tableData: BehaviorRelay<[ZKeyValueBean]> = BehaviorRelay<[ZKeyValueBean]>(value: [])
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        output.tableData.accept(input.circle.contentMap)
        
        self.output = output
    }
}
