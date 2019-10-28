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
import CoreLocation

public final class ZHandlerViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let tag: String
        
        let modelSelect: ControlEvent<ZKeyValueBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let tableData: BehaviorRelay<[ZKeyValueBean]> = BehaviorRelay<[ZKeyValueBean]>(value: [])
        
        let keyValues: [[String: Any]]
        
        let location: BehaviorRelay<CLLocation>
        
        let locAddress: BehaviorRelay<String>
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
        
        var result: [ZKeyValueBean] = []
        
        for item in input.keyValues {
            
            let kv = ZKeyValueBean(JSON: item)!
            
            result += [kv]
        }
        
        input.tableData.accept(result)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let combine = Driver.combineLatest(input.tableData.asDriver(), input.location.asDriver(),input.locAddress.asDriver())
        
        let completing = input.completeTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<WLBaseResult> = input
            .completeTaps
            .withLatestFrom(combine)
            .flatMapLatest {
                
                var result: [[String: Any]] = []
                
                
                for item in $0.0 {
                    
                    var res: [String: String] = [:]
                    
                    res.updateValue("txt", forKey: "type")
                    
                    res.updateValue("\(item.type):\(item.value)", forKey: "value")
                    
                    if !item.place.contains("选填") {
                        
                        if item.value.isEmpty {
                            
                            return Driver.just(WLBaseResult.failed(item.place))
                        } else {
                            
                            if item.type.contains("详细地址") {
                                
                                if item.value.wl_isEmpty {
                                    
                                    return Driver.just(WLBaseResult.failed("请输入详细地址"))
                                } else {
                                    
                                    if ZAMapViewModel.isPurnInt(string: item.value) {
                                        
                                        return Driver.just(WLBaseResult.failed("请输入正确的详细地址,详细地址不能为纯数字"))
                                    }
                                }
                            } else if item.type.contains("联系电话") {
                                
                                if !String.validPhone(phone: item.value) {
                                    
                                    return Driver.just(WLBaseResult.failed("请输入正确手机号"))
                                }
                            } else if item.type.contains("详细地址") {
                                
                                if item.value.wl_isEmpty {
                                    
                                    return Driver.just(WLBaseResult.failed("请输入详细地址"))
                                } else {
                                    
                                    if ZAMapViewModel.isPurnInt(string: item.value) {
                                        
                                        return Driver.just(WLBaseResult.failed("请输入正确的详细地址,详细地址不能为纯数字"))
                                    }
                                }
                            } else {
                                
                                if item.value.wl_isEmpty {
                                    
                                    return Driver.just(WLBaseResult.failed(item.place))
                                }
                            }
                        }
                    }
                    
                    result += [res]
                }
                
                result += [["type":"txt","value":"lat:\($0.1.coordinate.latitude)"]]
                
                result += [["type":"txt","value":"lng:\($0.1.coordinate.longitude)"]]
                
                result += [["type":"txt","value":"address:\($0.2)"]]
                
                let content = WLJsonCast.cast(argu: result)
                
                return onUserDictResp(ZUserApi.publish(input.tag, content: content))
                    .mapObject(type: ZCircleBean.self)
                    .map({ WLBaseResult.operation($0) })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
        }
        
        self.output = WLOutput(zip: zip, completing: completing, completed: completed)
    }
    
    
}

