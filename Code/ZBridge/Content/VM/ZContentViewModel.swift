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

@objc (ZContentType)
public enum ZContentType: Int {
    
    case mixed
    
    case commodity
    
}

struct ZContentViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZKeyValueBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let type: ZContentType
        
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
        
        if input.type == .mixed {
            
            output.tableData.accept(input.circle.contentMap)
        } else {
            
            var result: [ZKeyValueBean] = []
            
            for item in input.circle.contentMap {
                
                if item.type == "image" {
                    
                    result += [item]
                } else if item.type == "txt" {
                    
                    if item.value.contains("Image:") {
                        
                        result += [item]
                    }
                }
            }
            
            output.tableData.accept(result)
        }
        
        self.output = output
    }
}
