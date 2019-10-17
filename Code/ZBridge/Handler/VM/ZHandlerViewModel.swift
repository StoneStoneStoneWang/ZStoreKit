//
//  ZHandlerViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2019/10/16.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLToolsKit
import WLReqKit
import ObjectMapper
import WLBaseResult
import ZBean
import ZRealReq
import ZApi

public final class ZHandlerViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let tag: String
        
        let modelSelect: ControlEvent<ZKeyValueBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let tableData: BehaviorRelay<[ZKeyValueBean]> = BehaviorRelay<[ZKeyValueBean]>(value: [])
    }
    
    public struct WLOutput {
        
        let zip: Observable<(ZKeyValueBean,IndexPath)>
        /* 完成 序列*/
        let completing: Driver<Void>
        /* 完成结果 */
        let completed: Driver<WLBaseResult>
    }
    
    public init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let completing = input.completeTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<WLBaseResult> = input
            .completeTaps
            .withLatestFrom(input.tableData.asDriver())
            .flatMapLatest {
                
                var result: [ZKeyValueBean] = []
                
                result += $0
                
                let content = WLJsonCast.cast(argu: result.toJSON())
                
                return onUserDictResp(ZUserApi.publish(input.tag, content: content))
                    .mapObject(type: ZCircleBean.self)
                    .map({ WLBaseResult.operation($0) })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
        }
        
        self.output = WLOutput(zip: zip, completing: completing, completed: completed)
    }
}

