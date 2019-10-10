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
import CoreLocation
import ZCache

struct ZAMapViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<ZKeyValueBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let tag: String
        
        let forms: [[String: String]]
        
        let location: BehaviorRelay<CLLocation>
        
        let locAddress: BehaviorRelay<String>
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
        
        let combine = Driver.combineLatest(output.tableData.asDriver(), input.location.asDriver())
        
        output.completed = input
            .completeTaps
            .withLatestFrom(combine)
            .flatMapLatest {
                
                if ZAccountCache.default.isLogin() {
                    
                    var arr: [[String: String]] = []
                    
                    for item in $0.0 {
                        
                        var res: [String: String] = [:]
                        
                        res.updateValue("txt", forKey: "type")
                        
                        res.updateValue("\(item.type):\(item.value)", forKey: "value")
                        
                        if item.value.isEmpty {
                            
                            return Driver.just(WLBaseResult.failed(item.place))
                        } else {
                            
                            if item.type.contains("手机号") {
                                
                                if !String.validPhone(phone: item.value) {
                                    
                                    return Driver.just(WLBaseResult.failed("请输入正确手机号"))
                                }
                            } else if item.type.contains("备注") {
                                
                                if item.value.wl_isEmpty {
                                    
                                    return Driver.just(WLBaseResult.failed("请输入备注"))
                                } else {
                                    
                                    if ZAMapViewModel.isPurnInt(string: item.value) {
                                        
                                        return Driver.just(WLBaseResult.failed("请输入备注,备注不能为纯数字"))
                                    }
                                }
                            } else if item.type.contains("详细地址") {
                                
                                if item.value.wl_isEmpty {
                                    
                                    return Driver.just(WLBaseResult.failed("请输入详细地址"))
                                } else {
                                    
                                    if ZAMapViewModel.isPurnInt(string: item.value) {
                                        
                                        return Driver.just(WLBaseResult.failed("请输入正确的详细地址,详细地址不能为纯数字"))
                                    }
                                }
                            } else if item.type.contains("时间") {
                                
                                if item.value.wl_isEmpty {
                                    
                                    return Driver.just(WLBaseResult.failed("请选择服务时间"))
                                }
                            }
                        }
                        
                        arr += [res]
                    }
                    
                    arr += [["type":"txt","value":"lat:\($0.1.coordinate.latitude)"]]
                    
                    arr += [["type":"txt","value":"lng:\($0.1.coordinate.longitude)"]]
                    
                    if input.locAddress.value.wl_isEmpty {
                        
                        return Driver.just(WLBaseResult.failed("请手动滑动地图,选择地址"))
                    }
                    
                    arr += [["type":"txt","value": "address:\(input.locAddress.value)"]]
                    
                    return onUserDictResp(ZUserApi.publish(input.tag, content: WLJsonCast.cast(argu: arr)))
                        .mapObject(type: ZCircleBean.self)
                        .map({ WLBaseResult.operation($0) })
                        .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
                } else {
                    
                    return Driver.just(WLBaseResult.empty)
                }
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
    
    static func isPurnInt(string: String) -> Bool {
        
        let scan: Scanner = Scanner(string: string)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
        
    }
}
