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
import ZRealReq
import WLBaseResult
import ZApi
import WLReqKit

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
    static func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(ZUserApi.addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content))
            .map({ _ in WLBaseResult.ok("添加黑名单成功")})
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    static func focus(_ uid: String ,encode: String) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(ZUserApi.focus(uid, targetEncoded: encode))
            .flatMapLatest({ return Driver.just(WLBaseResult.ok("关注或取消关注成功")) })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    
    static func like(_ encoded: String ,isLike: Bool) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(ZUserApi.like(encoded))
            .flatMapLatest({ return Driver.just(WLBaseResult.ok( isLike ? "点赞成功" : "取消点赞成功")) })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
    static func removeMyCircle(_ encoded: String ) -> Driver<WLBaseResult> {
        
        return onUserVoidResp(ZUserApi.deleteMyCircle(encoded))
            .map({ WLBaseResult.ok("删除成功！")  })
            .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
