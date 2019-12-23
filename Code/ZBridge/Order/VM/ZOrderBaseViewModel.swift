//
//  ZOrderViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/12/23.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift

struct ZOrderBaseViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<String>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let tableData: [String]
    }
    
    struct WLOutput {
        
        let tableData: BehaviorRelay<[String]>
        
        let zip: Observable<(String,IndexPath)>
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let tableData: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: input.tableData)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(tableData: tableData, zip: zip)
        
        self.output = output
        
    }
}
