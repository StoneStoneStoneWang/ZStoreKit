//
//  ZTranslateViewModel.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/16.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import WLBaseViewModel
import WLBaseResult
import WLReqKit
import ZApi
import ZRealReq
import ObjectMapper

@objc (ZTranslateBean)
public class ZTranslateBean: NSObject,Mappable {
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
        type <- map["type"]
        
        from <- map["from"]
        
        to <- map["to"]
        
        text <- map["text"]
        
        result <- map["result"]
    }
    
    var type: String = ""
    
    var from: String = ""
    
    var to: String = ""
    
    var text: String = ""
    
    var result: String = ""
}


struct ZTranslateViewModel: WLBaseViewModel  {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let translateTaps:Signal<Void>
        
        let from: Driver<String> // 翻译前
        
        let to: Driver<String> // 翻译后
        
        let speakerTaps: Signal<Void>
        
        let style: ZTranslateStyle
    }
    
    struct WLOutput {
        
        let translating: Driver<Bool>
        
        let translated: Driver<WLBaseResult>
        
        let speaker: Driver<WLBaseResult>
        
        let placeholderHidden: Driver<Bool>
    }
    
    init(_ input: WLInput
        ) {
        
        self.input = input
        
        let translating: Driver<Bool> = input
            .translateTaps
            .flatMap {_ in  return Driver.just(true) }
        
        let translated: Driver<WLBaseResult> = input
            .translateTaps
            .withLatestFrom(input.from)
            .flatMapLatest {
                
                if !$0.isEmpty {
                    
                    return onTranslateResp(ZTranslateApi.translateToCN($0, style: input.style))
                        .map({ return $0["data"] as! [String: Any] })
                        .mapObject(type: ZTranslateBean.self)
                        .map { WLBaseResult.ok($0.result) }
                        .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
                }
                else { return Driver.just(WLBaseResult.failed("请输入需要翻译的内容")) }
        }
        
        let speaker = input.speakerTaps.withLatestFrom(input.to)
            .flatMapLatest { return Driver.just($0.isEmpty ? WLBaseResult.empty : WLBaseResult.ok($0)) }
        
        let placeholderHidden: Driver<Bool> = input.from.map { !$0.isEmpty }
        
        self.output = WLOutput(translating: translating, translated: translated, speaker: speaker, placeholderHidden: placeholderHidden)
    }
}
