//
//  ZAMapViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import WLToolsKit
import WLBaseResult
import ZBean
import ZRealReq
import ZApi

struct ZAMapViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZKeyValueBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let tag: String
        
        let forms: [[String: String]]
    }
    struct WLOutput {
        
        let zip: Observable<(ZKeyValueBean,IndexPath)>
        
        let tableData: BehaviorRelay<[ZKeyValueBean]> = BehaviorRelay<[ZKeyValueBean]>(value: [])
        
        let completing: Driver<Void>
        
        var completed: Driver<WLBaseResult>
    }
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let completing: Driver<Void> = input.completeTaps.flatMap { Driver.just($0) }
        
        var output = WLOutput(zip: zip, completing: completing, completed: Driver<WLBaseResult>.just(WLBaseResult.empty))
        
        output.completed = input
            .completeTaps
            .withLatestFrom(output.tableData.asDriver())
            .flatMapLatest {
                
                var arr: [[String: String]] = []
                
                for item in $0 {
                    
                    var res: [String: String] = [:]
                    
                    res.updateValue(item.type, forKey: "type")
                    
                    res.updateValue(item.value, forKey: "value")
                    
                    if item.value.isEmpty {
                        
                        return Driver.just(WLBaseResult.failed(item.place))
                    }
                    
                    arr += [res]
                }
                
                return onUserDictResp(ZUserApi.publish(input.tag, content: WLJsonCast.cast(argu: arr)))
                    .mapObject(type: ZCircleBean.self)
                    .map({ WLBaseResult.operation($0) })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
        }
        
        for item in input.forms {
            
            let res = ZKeyValueBean(JSON: item)
            
            output.tableData.accept( output.tableData.value + [res!])
        }
        
        self.output = output
    }
    
    public func clearJson()  {
        
        let mutable = output.tableData.value
        
        for item in mutable {
            
            item.value = ""
        }
        
        output.tableData.accept(mutable)
    }
}
